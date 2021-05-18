@MLP-24734
Feature:MLP-24734:Platform support for new DD Loader: identification and technical attributes

   #7130382
  Scenario: Verify if origin type is written to DB when xml is imported
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data            |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And user attaches/upload file "Constant.REST_DIR/payloads/idc/IDxPayloads/MLP_24734/import.xml" to request
    And user makes a REST Call for POST request with url "/import/Default/file" with the following query param
      |  |  |
    Then Status code 200 must be returned
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage  | queryField  | columnName     | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | OriginType | originQuery | asg_origintype | rowList      |
    Then postgres database query result stored in "list" should have following values listed
      | DWR_ORG_UNIT |


   #7130374
  Scenario Outline:Verify if local id is accepted as scope id when creating items
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                          | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Post | items/Default/root | idc/IDxPayloads/MLP_24734/createRootItem.json | 200           |                  |          |


  Scenario Outline:user connects to database and retrieves the class id function id and lineage hop ids
    Given user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive | catalog | type     | name           | asg_scopeid | targetFile                                      | jsonpath         |
      | APPDBPOSTGRES | ID      | Default | Database | RootDatabase01 |             | payloads/idc/IDxPayloads/MLP_24734/itemids.json | $.DatabaseID     |
      | APPDBPOSTGRES | ID      | Default | Table    | ChildTable01   |             | payloads/idc/IDxPayloads/MLP_24734/itemids.json | $.TableID        |
      | APPDBPOSTGRES | ID      | Default | Column   | ChildColumn    |             | payloads/idc/IDxPayloads/MLP_24734/itemids.json | $.ColumnID       |
      | APPDBPOSTGRES | ID      | Default | Table    | ChildTable01   |             | payloads/idc/IDxPayloads/MLP_24734/itemids.json | $.Table4OriginID |


  Scenario Outline: user compares the json response and
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user hits request "<type>" with "<endPoint>" using dynamic id from "<dynamicIdFile>" using "<jsonPath>" and verify "<responseCode>" and "<responseValue>" with "<expectedValue>"
    Examples:
      | type | endPoint                             | dynamicIdFile                                   | jsonPath   | responseCode | responseValue | expectedValue |
      | Get  | items/Default/Default.Table:::DYNID  | payloads/idc/IDxPayloads/MLP_24734/itemids.json | $.TableID  | 200          | $.asg_scopeid | 1             |
      | Get  | items/Default/Default.Column:::DYNID | payloads/idc/IDxPayloads/MLP_24734/itemids.json | $.ColumnID | 200          | $.asg_scopeid | 2             |


     #7130375 ##7130374 #7130381 #7130377 #7130379
  Scenario Outline: Verify if item end point with invalid local id returns error code and error message
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                       | bodyFile                                                    | path               | response code | response message                   | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Post | items/Default/root                        | payloads/idc/IDxPayloads/MLP_24734/createItemScenarios.json | $.OrderInDiffPlace | 200           |                                    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Post | /items/Default/Default.Database%3A%3A%3A1 | payloads/idc/IDxPayloads/MLP_24734/createItemScenarios.json | $.InvalidLocalID   | 400           | Cannot resolve local IDs: [string] |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Post | items/Default/root                        | payloads/idc/IDxPayloads/MLP_24734/createItemScenarios.json | $.rootToGrandChild | 200           |                                    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Post | items/Default/root                        | payloads/idc/IDxPayloads/MLP_24734/createItemScenarios.json | $.reverseRoot      | 200           |                                    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Post | items/Default/root                        | payloads/idc/IDxPayloads/MLP_24734/createItemScenarios.json | $.InvalidScopeID   | 400           | NumberFormatException              |          |


  ##7249825## ##7249826##
  Scenario Outline:Verify if multiple originids are updated for an item id using the api call
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user hits request "<type>" with "<endPoint>" and "<body>" using dynamic id from "<dynamicIdFile>" using "<jsonPath>" and verify "<responseCode>" and "<responseValue>" with "<expectedValue>" and store the value "<targetFile>"
    Examples:
      | type | endPoint                                             | body                                                    | dynamicIdFile                                   | jsonPath         | responseCode | responseValue | expectedValue | targetFile                                  |
      | Put  | items/Default/Default.Table:::DYNID                  | payloads/idc/IDxPayloads/MLP_24734/asgoriginid_Add.json | payloads/idc/IDxPayloads/MLP_24734/itemids.json | $.Table4OriginID | 204          |               |               |                                             |
      | Get  | items/Default/Default.Table:::DYNID?what=asg.origins |                                                         | payloads/idc/IDxPayloads/MLP_24734/itemids.json | $.Table4OriginID | 200          |               |               | idc/IDxPayloads/MLP_24734/getoriginids.json |

  ##7249826##
  Scenario: Compare the actual and expected json value of the orginids
    And user "update" the json file "idc\IDxPayloads\MLP_24734\getoriginids.json" file for following values
      | jsonPath | jsonValues |
      | $..id    |            |


  ##7249825##
  Scenario Outline: Get the orgin id values
    Given user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive  | catalog | type  | name | asg_scopeid | targetFile                                              | jsonpath |
      | APPDBPOSTGRES | ORIGINID | Default | Table | ds1  |             | payloads/idc/IDxPayloads/MLP_24734/actualorginids1.json | $.ds1    |
      | APPDBPOSTGRES | ORIGINID | Default | Table | ds2  |             | payloads/idc/IDxPayloads/MLP_24734/actualorginids1.json | $.ds2    |


  ##7249828##
  Scenario Outline:Verify if multiple originids are deleted for an item id using the api call
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user hits request "<type>" with "<endPoint>" and "<body>" using dynamic id from "<dynamicIdFile>" using "<jsonPath>" and verify "<responseCode>" and "<responseValue>" with "<expectedValue>" and store the value "<targetFile>"
    Examples:
      | type | endPoint                            | body                                                       | dynamicIdFile                                   | jsonPath         | responseCode | responseValue | expectedValue | targetFile |
      | Put  | items/Default/Default.Table:::DYNID | payloads/idc/IDxPayloads/MLP_24734/asgoriginid_Delete.json | payloads/idc/IDxPayloads/MLP_24734/itemids.json | $.Table4OriginID | 204          |               |               |            |

  ##7249828##
  Scenario Outline: Get the orgin id values for the removed orginids
    Given user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive  | catalog | type  | name | asg_scopeid | targetFile                                              | jsonpath |
      | APPDBPOSTGRES | ORIGINID | Default | Table | ds1  |             | payloads/idc/IDxPayloads/MLP_24734/actualorginids2.json | $.ds1    |
      | APPDBPOSTGRES | ORIGINID | Default | Table | ds2  |             | payloads/idc/IDxPayloads/MLP_24734/actualorginids2.json | $.ds2    |

  ##7249825## ##7249826## ##7249828##
  Scenario Outline: Compare the actual and expected json value of the orginids
    Given user json assert between "<expectedJson>" data and "<actualJson>" data
    Examples:
      | expectedJson                                                              | actualJson                                                                   |
      | Constant.REST_DIR/payloads/idc/IDxPayloads/MLP_24734/getoriginids.json    | Constant.REST_DIR//payloads/idc/IDxPayloads/MLP_24734/expectedoriginids.json |
      | Constant.REST_DIR/payloads/idc/IDxPayloads/MLP_24734/actualorginids1.json | Constant.REST_DIR//payloads/idc/IDxPayloads/MLP_24734/expectedorginids1.json |
      | Constant.REST_DIR/payloads/idc/IDxPayloads/MLP_24734/actualorginids2.json | Constant.REST_DIR//payloads/idc/IDxPayloads/MLP_24734/expectedorginids2.json |

  Scenario:Delete thhe Db
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name           | type       | query | param |
      | SingleItemDelete | Default | RootDatabase01 | DatabaseDO |       |       |
      | SingleItemDelete | Default | RootDatabase01 | Database   |       |       |
      | SingleItemDelete | Default | RootDB1        | Database   |       |       |
      | SingleItemDelete | Default | ChildTable01   | TableDO    |       |       |
      | SingleItemDelete | Default | ChildTable01   | Table      |       |       |
      | SingleItemDelete | Default | ChildTable02   | Table      |       |       |
      | SingleItemDelete | Default | ChildColumn    | ColumnDO   |       |       |
      | SingleItemDelete | Default | ChildColumn    | Column     |       |       |
      | SingleItemDelete | Default | gc1            | Column     |       |       |
      | SingleItemDelete | Default | reverseRoot    | Column     |       |       |
      | SingleItemDelete | Default | child1         | Table      |       |       |
