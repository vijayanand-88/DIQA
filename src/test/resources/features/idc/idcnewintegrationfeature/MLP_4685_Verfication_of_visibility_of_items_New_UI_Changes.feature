@MLP-4685
Feature: MLP-4685 - Verification of visibility of items

  @MLP-4685 @MLP-5120 @regression @positive
  Scenario:MLP-4685_MLP-5120 Create an item
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/IDX_Integration_Payloads/MLP-4685_Item_Creation.json"
    And user makes a REST Call for POST request with url "items/Default/root" and store the response
    And Status code 200 must be returned

  Scenario Outline: user retrieves ID with catalog name and type
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive | catalog | type  | name            | asg_scopeid | targetFile                                                  | jsonpath        |
      | APPDBPOSTGRES | ID      | Default | Table | TableSingleTest |             | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json | $..has_Table.id |

  @MLP-4685 @MLP-5120 @regression @positive
  Scenario:MLP-4685_MLP-5120 Verification of setting access information for an item
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/json               |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And user makes a REST Call for "DELETE" request with url "accesses/Default/Default.Table%3A%3A%3Adynamic" and path "" and get paramater from "payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json" file and "$..has_Table.id" json
      |  |  |
    And supply payload with file name "idc/IDX_Integration_Payloads/MLP-4685_SystemAccess.json"
    And user makes a REST Call for "PUT" request with url "accesses/Default/Default.Table%3A%3A%3Adynamic" and path "" and get paramater from "payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json" file and "$..has_Table.id" json
      | recursive | false&operation=SET |
    And Status code 204 must be returned
    And user makes a REST Call for "GET" request with url "accesses/Default/Default.Table%3A%3A%3Adynamic" and path "" and get paramater from "payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json" file and "$..has_Table.id" json
      | recursive | false |
    And Status code 200 must be returned
    And user compares the value from response using json path "$..['asg_acl']"
      | jsonValues                                           |
      | {\"users\":[\"TestSystem\"],\"groups\":[\"System\"]} |

  @MLP-4685 @MLP-5120 @regression @positive
  Scenario:MLP-4685 updating the id from the response
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "GET" request with url "accesses/Default/Default.Table%3A%3A%3Adynamic" and path "" and get paramater from "payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json" file and "$..has_Table.id" json
      | recursive | false |
    And Status code 200 must be returned
    Then user update the json file "idc/IDX_Integration_Payloads/TableExample.json" for following values using "response array"
      | jsonPath  |
      | $..['id'] |
    And user update the json file "idc/IDX_Integration_Payloads/MLP_4685_TagExample.json" for following values using "response"
      | jsonPath  |
      | $..['id'] |

  @MLP-4685 @regression @positive
  Scenario Outline: Login Scenario - To verify visibility of item  after setting access
    Given user makes request with "<url>" and type "<type>" to verify "<responseCode>" and "<responseMessage>" using "<inputJson>" from "<inputFile>" with body "<body>" for "TestDataAdmin" user and with "<contentType>" and "<acceptType>"
    Examples:
      | contentType      | acceptType       | type   | url                                                                            | body                                                         | responseCode | inputJson       | inputFile                                                   | responseMessage                                     |
      | application/json | application/json | Get    | items/Default/Default.Table%3A%3A%3Adynamic                                    |                                                              | 403          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json | Access to the specified resource has been forbidden |
      | application/json | application/json | Get    | components/Default/item/Default.Table%3A%3A%3Adynamic                          |                                                              | 403          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json | Access to the specified resource has been forbidden |
      | application/json | application/json | Get    | items/Default/Default.Table%3A%3A%3Adynamic/env?dir=%3C-%3E&limit=0            |                                                              | 403          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json | Access to the specified resource has been forbidden |
      | application/json | application/json | Post   | items/Default/env?dir=%3C-%3E&limit=0                                          | idc/IDX_Integration_Payloads/TableExample.json               | 403          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json | Access to the specified resource has been forbidden |
      | application/json | application/json | Put    | items/Default/Default.Table%3A%3A%3Adynamic                                    | idc/IDX_Integration_Payloads/TableExample.json               | 403          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json | Access to the specified resource has been forbidden |
      | application/json | application/json | Delete | items/Default/Default.Table%3A%3A%3Adynamic                                    |                                                              | 403          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json | Access to the specified resource has been forbidden |
      | application/json | application/json | Post   | items/Default/Default.Table%3A%3A%3Adynamic?allowUpdate=false                  | idc/IDX_Integration_Payloads/MLP_4685_New_Item_Creation.json | 403          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json | Access to the specified resource has been forbidden |
      | application/json | application/json | Post   | items/Default/Default.Table%3A%3A%3Adynamic/Test?allowUpdate=false             | idc/IDX_Integration_Payloads/MLP_4685_New_Item_Creation.json | 403          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json | Access to the specified resource has been forbidden |
      | application/json | application/json | Get    | comments/Default/Default.Table%3A%3A%3Adynamic                                 |                                                              | 403          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json | Access to the specified resource has been forbidden |
      | application/json | application/json | Post   | comments/Default/Default.Table%3A%3A%3Adynamic                                 | idc/IDX_Integration_Payloads/Example.json                    | 403          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json | Access to the specified resource has been forbidden |
      | application/json | application/json | Get    | comments/preview/Default/Default.Table%3A%3A%3Adynamic                         |                                                              | 403          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json | Access to the specified resource has been forbidden |
      | application/json | application/json | Get    | ratings/Default/Default.Table%3A%3A%3Adynamic?limit=10&order=date&reverse=true |                                                              | 403          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json | Access to the specified resource has been forbidden |
      | application/json | application/json | Delete | ratings/Default/Default.Table%3A%3A%3Adynamic?limit=10&order=date&reverse=true |                                                              | 403          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json | Access to the specified resource has been forbidden |
      | application/json | application/json | Get    | recommendations/items/Default/Default.Table%3A%3A%3Adynamic                    |                                                              | 403          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json | Access to the specified resource has been forbidden |
      | application/json | application/json | Post   | tags/Default/assignments                                                       | idc/IDX_Integration_Payloads/MLP_4685_TagExample.json        | 403          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json | Access to the specified resource has been forbidden |
      | application/json | application/json | Get    | tags/Default/assignments?items=Default.Table%3A%3A%3Adynamic                   |                                                              | 403          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json | Access to the specified resource has been forbidden |
      | application/json | application/json | Post   | searches/Default/query/dataTagging?limit=0                                     | idc/IDX_Integration_Payloads/TableExample.json               | 403          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json | Access to the specified resource has been forbidden |
      | application/json | application/json | Get    | searches/Default/query/solrQuery/Default.Table%3A%3A%3Adynamic?limit=0         |                                                              | 403          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json | Access to the specified resource has been forbidden |
#      | application/json | application/json | Post   | searches/Default?query=g.V().hasLabel(%22Default.Table%22)&limit=0             | idc/IDX_Integration_Payloads/TableExample.json               | 403          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json | Access to the specified resource has been forbidden |
#      | application/json | application/json | Post   | ratings/Default/Default.Table%3A%3A%3Adynamic/1                                |                                                              | 403          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json | Access to the specified resource has been forbidden |

  @MLP-4685 @regression @positive
  Scenario Outline: Login Scenario - To verify visibility of item searches after setting access
    Given user makes request with "<url>" and type "<type>" to verify "<responseCode>" and "<responseMessage>" using "<inputJson>" from "<inputFile>" with body "<body>" for "TestDataAdmin" user and with "<contentType>" and "<acceptType>"
    When Status code 200 must be returned
    Examples:
      | contentType      | acceptType       | type | url                                                                                                                                                  | body                                                  | responseCode | inputJson       | inputFile                                                   | responseMessage |
      | application/json | application/json | Get  | searches/Default/list/Table?limit=0                                                                                                                  |                                                       | 200          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json |                 |
      | application/json | application/json | Post | searches/fulltext/Default?query=%22id%22%3A%22Default.Table%3A%3A%3Adynamic%22&advanced=false&natural=false&limit=10&offset=0&limitFacets=10         | idc/IDX_Integration_Payloads/MLP-4685_Empty_Json.json | 200          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json |                 |
      | application/json | application/json | Get  | searches/fulltext?query=%22type%22%3A%20%22Table%22&advanced=false&limit=10000&offset=0                                                              |                                                       | 200          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json |                 |
      | application/json | application/json | Get  | searches/fulltext/Default?query=%22id%22%3A%20%22Default.Table%3A%3A%3Adynamic%22&limit=10000&offset=0                                               |                                                       | 200          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json |                 |
      | application/json | application/json | Post | searches/fulltext/Default?query=%22id%22%3A%20%22Default.Table%3A%3A%3Adynamic%22&advanced=false&natural=false&limit=10000&offset=0&limitFacets=1000 | idc/IDX_Integration_Payloads/MLP-4685_Empty_Json.json | 200          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json |                 |
      | application/json | application/json | Get  | tags/Default/items?tags=Phone%20Number&subtags=true&limit=0&offset=0                                                                                 |                                                       | 200          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json |                 |
      | application/json | application/json | Get  | tags/Default/Phone%20Number/items?subtags=true&limit=0&offset=0                                                                                      |                                                       | 200          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json |                 |
#      | application/json | application/json | Post | searches                                                                                                                                             | idc/IDX_Integration_Payloads/MLP-4685_Searches.txt    | 200          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json |     |
#      | application/json | application/json | Get  | searches/Default?query=g.V().hasLabel(%22Default.Table%22)&limit=0                                                                     |                                                    | 200          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json |                       |


  @MLP-4685 @regression @positive
  Scenario Outline: Login Scenario1 - To verify visibility of item fulltext searches after setting access
    Given user makes request with "<url>" and type "<type>" to verify "<responseCode>" and "<responseMessage>" using "<inputJson>" from "<inputFile>" with body "<body>" for "TestDataAdmin" user and with "<contentType>" and "<acceptType>"
    And response message not contains value "TableSingleTest"
    Examples:
      | contentType      | acceptType       | type | url                                                                    | body | responseCode | inputJson       | inputFile                                                   | responseMessage |
      | application/json | application/json | Get  | searches/fulltext/autosuggest?input=TableSingle&limit=10               |      | 200          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json |                 |
      | application/json | application/json | Get  | searches/fulltext/autosuggest/Default?input=TableSingleTest&limit=10   |      | 200          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json |                 |
      | application/json | application/json | Get  | searches/fulltext/autosuggest/Default/Table?input=TableSingle&limit=10 |      | 200          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json |                 |

  @MLP-4685 @regression @positive
  Scenario Outline: Verification of visibility for POST /ratings/{catalogname}/{itemid}/{rating} assigned user
    Given user makes request with "<url>" and type "<type>" to verify "<responseCode>" and "<responseMessage>" using "<inputJson>" from "<inputFile>" with body "<body>" for "TestDataAdmin" user and with "<contentType>" and "<acceptType>"
    Examples:
      | contentType      | acceptType       | type | url                                             | body | responseCode | inputJson       | inputFile                                                   | responseMesssage |
      | application/json | application/json | Post | ratings/Default/Default.Table%3A%3A%3Adynamic/1 |      | 201          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json |                  |

  @MLP-4685 @regression @positive
  Scenario Outline: Login Scenario - To verify visibility of item for the assigned user
    Given user makes request with "<url>" and type "<type>" to verify "<responseCode>" and "<responseMessage>" using "<inputJson>" from "<inputFile>" with body "<body>" for "TestSystemUser" user and with "<contentType>" and "<acceptType>"
    Examples:
      | contentType      | acceptType       | type | url                                                                       | body                                                            | responseCode | inputJson       | inputFile                                                   | responseMessage |
      | application/json | application/json | Get  | components/Default/item/Default.Table%3A%3A%3Adynamic                     |                                                                 | 200          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json |                 |
      | application/json | application/json | Get  | items/Default/Default.Table%3A%3A%3Adynamic                               |                                                                 | 200          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json |                 |
      | application/json | application/json | Get  | items/Default/Default.Table%3A%3A%3Adynamic/env?dir=%3C-%3E&limit=0       |                                                                 | 200          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json |                 |
      | application/json | application/json | Get  | comments/Default/Default.Table%3A%3A%3Adynamic                            |                                                                 | 200          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json |                 |
      | application/json | application/json | Get  | comments/preview/Default/Default.Table%3A%3A%3Adynamic                    |                                                                 | 200          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json |                 |
      | application/json | application/json | Get  | recommendations/items/Default/Default.Table%3A%3A%3Adynamic               |                                                                 | 200          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json |                 |
      | application/json | application/json | Get  | tags/Default/assignments?items=Default.Table%3A%3A%3Adynamic              |                                                                 | 200          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json |                 |
      | application/json | application/json | Get  | searches/Default/query/solrQuery/Default.Table%3A%3A%3Adynamic?limit=0    |                                                                 | 200          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json |                 |
      | application/json | application/json | Post | items/Default/env?dir=%3C-%3E&limit=0                                     | idc/IDX_Integration_Payloads/TableExample.json                  | 200          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json |                 |
      | application/json | application/json | Post | comments/Default/Default.Table%3A%3A%3Adynamic                            | idc/IDX_Integration_Payloads/PlainTextExample.txt               | 200          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json |                 |
      | application/json | application/json | Post | items/Default/Default.Table%3A%3A%3Adynamic?allowUpdate=false             | idc/IDX_Integration_Payloads/MLP-4685_Item_Creation.json        | 200          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json |                 |
      | application/json | application/json | Post | items/Default/Default.Table%3A%3A%3Adynamic/Definitions?allowUpdate=false | idc/IDX_Integration_Payloads/MLP-4685_MultipleItemCreation.json | 200          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json |                 |
      | application/json | application/json | Get  | items/Default/relations?srcid=Default.Table%3A%3A%3Adynamic&limit=0       |                                                                 | 200          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json |                 |
#      | application/json | application/json | Get  | ratings/Default/Default.Table%3A%3A%3Adynamic?limit=10&order=date&reverse=true |                                                                 | 200          |                 |                                                             |                 |


  @MLP-4685 @regression @positive
  Scenario Outline: Login Scenario - Verification of visibility for PUT comments/{catalog}/{id}
    Given user get the column "TestAutomation" id from the following query
      | description | schemaName | tableName | typeName | columnName | criteriaName | criteriaAttribute      |
      | SELECT      | public     | items     | Comment  | id         |              | attributes->>'message' |
    When user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestDataAdmin" user
    Then Status code 403 must be returned
    And response message contains value "Access to the specified resource has been forbidden"
    Examples:
      | contentType      | acceptType       | type | url                                       | endpoint | body                                              |
      | application/json | application/json | Put  | comments/Default/Default.Comment%3A%3A%3A |          | idc/IDX_Integration_Payloads/PlainTextExample.txt |


  @MLP-4685 @regression @positive
  Scenario Outline: Login Scenario - Verification of visibility for PUT comments/{catalog}/{id} for assigned user
    Given user get the column "TestAutomation" id from the following query
      | description | schemaName | tableName | typeName | columnName | criteriaName | criteriaAttribute      |
      | SELECT      | public     | items     | Comment  | id         |              | attributes->>'message' |
    When user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestSystemUser" user
    Then Status code 204 must be returned
    Examples:
      | contentType      | acceptType       | type   | url                                       | endpoint | body                                              |
      | application/json | application/json | Put    | comments/Default/Default.Comment%3A%3A%3A |          | idc/IDX_Integration_Payloads/PlainTextExample.txt |
      | application/json | application/json | Delete | comments/Default/Default.Comment%3A%3A%3A |          |                                                   |


  @MLP-4685 @regression @positive
  Scenario Outline: Login Scenario - To verify visibility of item searches for the assigned user
    Given user makes request with "<url>" and type "<type>" to verify "<responseCode>" and "<responseMessage>" using "<inputJson>" from "<inputFile>" with body "<body>" for "TestSystemUser" user and with "<contentType>" and "<acceptType>"
    Examples:
      | contentType      | acceptType       | type | url                                                                                                   | body                                           | responseCode | inputJson       | inputFile                                                   | responseMessage         |
      | application/json | application/json | Get  | searches/Default/list/Table?limit=0                                                                   |                                                | 200          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json | Default.Table:::dynamic |
      | application/json | application/json | Post | searches/fulltext?query=type%20%3D%20Table&advanced=false&limit=10000&offset=0&limitFacets=10         |                                                | 200          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json | Default.Table:::dynamic |
      | application/json | application/json | Get  | searches/fulltext?query=type%20%3D%20Table&what=id&advanced=false&limit=100000&offset=0               |                                                | 200          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json | Default.Table:::dynamic |
      | application/json | application/json | Get  | searches/fulltext/Default?query=type%20%3D%20Table&what=id&advanced=false&limit=100000&offset=0       |                                                | 200          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json | Default.Table:::dynamic |
      | application/json | application/json | Post | searches/fulltext/Default?query=type%20%3D%20Table&advanced=false&limit=10000&offset=0&limitFacets=10 |                                                | 200          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json | Default.Table:::dynamic |
      | application/json | application/json | Post | searches/Default/query/queryDiagramIn?limit=0                                                         | idc/IDX_Integration_Payloads/TableExample.json | 200          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json | Default.Table:::dynamic |
      | application/json | application/json | Get  | searches/Default/query/queryDiagramIn/Default.Table%3A%3A%3Adynamic?limit=0                           |                                                | 200          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json | Default.Table:::dynamic |
      | application/json | application/json | Get  | tags/Default/items?tags=Phone%20Number&subtags=true&limit=0&offset=0                                  |                                                | 200          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json |                         |
      | application/json | application/json | Get  | tags/Default/Phone%20Number/items?subtags=true&limit=0&offset=0                                       |                                                | 200          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json |                         |
#      | text/plain       | application/json | Post | searches                                                                                              | idc/IDX_Integration_Payloads/MLP-4685_Searches.txt | 200          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json | Default.Table:::dynamic |
#      | application/json | application/json | Get  | searches/Default?query=g.V().hasLabel(%22Default.Table%22)&limit=0                                    |                           |                           200          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json ||
#      | application/json | application/json | Post | searches/Default?query=g.V().hasLabel(%22Default.Table%22)&limit=0                                    | idc/TableExample.json     |                           200          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json ||


##Adding trusttrothy tag #descoped
#  @MLP-4685 @regression @positive
#  Scenario Outline: Login Scenario - To verify tag assignment and Delete ratings for the assigned user
#    Given user makes request with "<url>" and type "<type>" to verify "<responseCode>" and "<responseMessage>" using "<inputJson>" from "<inputFile>" with body "<body>" for "TestSystemUser" user and with "<contentType>" and "<acceptType>"
#    When Status code 204 must be returned
#    Examples:
#      | contentType      | acceptType       | type   | url                                           | body                   | responseCode | inputJson       | inputFile                                                   | responseMessage |
#      | application/json | application/json | Delete | ratings/Default/Default.Table%3A%3A%3Adynamic |                        | 204          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json |                 |
#      | application/json | application/json | Post   | tags/Default/assignments                      | idc/MLP_4685_Tags.json | 204          |                 |                                                             |                 |

  @MLP-4685 @MLP-5120 @regression @positive
  Scenario:MLP-4685_MLP-5120 Verification of adding access information for an item
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/IDX_Integration_Payloads/MLP-4685_DataAdminAccess.json"
    And user makes a REST Call for "PUT" request with url "accesses/Default/Default.Table%3A%3A%3Adynamic" and path "" and get paramater from "payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json" file and "$..has_Table.id" json
      | recursive | false&operation=ADD |
    And Status code 204 must be returned
    And user makes a REST Call for "GET" request with url "accesses/Default/Default.Table%3A%3A%3Adynamic" and path "" and get paramater from "payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json" file and "$..has_Table.id" json
      | recursive | false |
    And Status code 200 must be returned
    And user compares the value from response using json path "$..['asg_acl']"
      | jsonValues                                                               |
      | {\users\:\TestSystem\,\Test Data Admin\,\groups\:\System\,\Data Admins\} |

  @MLP-5120 @regression @positive
  Scenario:MLP-5120 Verification of getting access information for an item with acluser and aclgroup
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for "GET" request with url "accesses/Default/Default.Table%3A%3A%3Adynamic" and path "" and get paramater from "payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json" file and "$..has_Table.id" json
      | what | asg_acl&recursive=false&acluser=TestSystem&acluser=Test%20Data%20Admin&aclgroup=System&aclgroup=Data%20Admins |
    And Status code 200 must be returned
    And user compares the value from response using json path "$..['asg_acl']"
      | jsonValues                                                               |
      | {\users\:\TestSystem\,\Test Data Admin\,\groups\:\System\,\Data Admins\} |

  @MLP-4685 @MLP-5120 @regression @positive
  Scenario:MLP-4685_MLP-5120 Verification of subtracting access information for an item
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/IDX_Integration_Payloads/MLP-4685_DataAdminAccess.json"
    And user makes a REST Call for "PUT" request with url "accesses/Default/Default.Table%3A%3A%3Adynamic" and path "" and get paramater from "payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json" file and "$..has_Table.id" json
      | recursive | false&operation=SUB |
    And Status code 204 must be returned
    And user makes a REST Call for "GET" request with url "accesses/Default/Default.Table%3A%3A%3Adynamic" and path "" and get paramater from "payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json" file and "$..has_Table.id" json
      | recursive | false |
    And Status code 200 must be returned
    And user compares the value from response using json path "$..['asg_acl']"
      | jsonValues                                           |
      | {\"users\":[\"TestSystem\"],\"groups\":[\"System\"]} |

  @MLP-4685 @MLP-5120 @regression @positive
  Scenario:MLP-4685_MLP-5120 Verification of deleting access information for an item
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for "DELETE" request with url "accesses/Default/Default.Table%3A%3A%3Adynamic" and path "" and get paramater from "payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json" file and "$..has_Table.id" json
      | recursive | false |
    And Status code 204 must be returned
    And user makes a REST Call for "GET" request with url "accesses/Default/Default.Table%3A%3A%3Adynamic" and path "" and get paramater from "payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json" file and "$..has_Table.id" json
      | recursive | false |
    And Status code 200 must be returned
    And response message not contains value "{\"users\":[\"TestSystem\"],\"groups\":[\"System\"]}"

  @MLP-4685 @MLP-5120 @regression @positive
  Scenario: Verification of setting access information for an item with recursive true
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/IDX_Integration_Payloads/MLP_4685_CreateColumn.json"
    And user makes a REST Call for "POST" request with url "items/Default/Default.Table%3A%3A%3Adynamic" and path "" and get paramater from "payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json" file and "$..has_Table.id" json
      | allowUpdate | false |
    And Status code 200 must be returned
    And supply payload with file name "idc/IDX_Integration_Payloads/MLP-4685_SystemAccess.json"
    And user makes a REST Call for "PUT" request with url "accesses/Default/Default.Table%3A%3A%3Adynamic" and path "" and get paramater from "payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json" file and "$..has_Table.id" json
      | recursive | true&operation=SET |
    And Status code 204 must be returned


    ##Adding tag #descoped
#  @webtest @positive @regression
#  Scenario:Adding an tag to the child item
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user selects "Default" catalog from catalog list
#    And user enters the search text "NewChildColumn" and clicks on search
#    And user selects the "Column" from the Type
#    And user click on any of the item and assign "Phone Number" tag to the item.
#    And user should be able logoff the IDC


  @MLP-4685 @regression @positive
  Scenario Outline: Login Scenario - To verify visibility of item after setting access for child item
    Given user get the column "NewChildColumn" id from the following query
      | description | schemaName | tableName | typeName | columnName | criteriaName |
      | SELECT      | public     | items     | Column   | id         | name         |
    And  user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestDataAdmin" user
    When Status code 403 must be returned
    Then response message contains value "Access to the specified resource has been forbidden"
    Examples:
      | contentType      | acceptType       | type   | url                                                      | endpoint                          | body                                                     |
      | application/json | application/json | Get    | items/Default/Default.Column%3A%3A%3A                    |                                   |                                                          |
      | application/json | application/json | Get    | components/Default/item/Default.Column%3A%3A%3A          |                                   |                                                          |
      | application/json | application/json | Get    | items/Default/Default.Column%3A%3A%3A                    | /env?dir=%3C-%3E&limit=0          |                                                          |
      | application/json | application/json | Post   | items/Default/env?dir=%3C-%3E&limit=                     |                                   | idc/IDX_Integration_Payloads/TableExample.json           |
      | application/json | application/json | Put    | items/Default/Default.Column%3A%3A%3A                    |                                   | idc/IDX_Integration_Payloads/TableExample.json           |
      | application/json | application/json | Delete | items/Default/Default.Column%3A%3A%3A                    |                                   |                                                          |
      | application/json | application/json | Post   | items/Default/Default.Column%3A%3A%3A                    | ?allowUpdate=false                | idc/IDX_Integration_Payloads/MLP-4685_Item_Creation.json |
      | application/json | application/json | Post   | items/Default/Default.Column%3A%3A%3A                    | /Test?allowUpdate=false           | idc/IDX_Integration_Payloads/MLP-4685_Item_Creation.json |
      | application/json | application/json | Get    | comments/Default/Default.Column%3A%3A%3A                 |                                   |                                                          |
      | application/json | application/json | Post   | comments/Default/Default.Column%3A%3A%3A                 |                                   | idc/IDX_Integration_Payloads/Example.json                |
      | application/json | application/json | Get    | comments/preview/Default/Default.Column%3A%3A%3A         |                                   |                                                          |
      | application/json | application/json | Get    | ratings/Default/Default.Column%3A%3A%3A                  | ?limit=10&order=date&reverse=true |                                                          |
      | application/json | application/json | Delete | ratings/Default/Default.Column%3A%3A%3A                  | ?limit=10&order=date&reverse=true |                                                          |
      | application/json | application/json | Post   | ratings/Default/Default.Column%3A%3A%3A                  | /1                                |                                                          |
      | application/json | application/json | Get    | recommendations/items/Default/Default.Column%3A%3A%3A    |                                   |                                                          |
      | application/json | application/json | Get    | tags/Default/assignments?items=Default.Column%3A%3A%3A   |                                   |                                                          |
      | application/json | application/json | Post   | searches/Default/query/queryDiagramOut?limit             |                                   | idc/IDX_Integration_Payloads/TableExample.json           |
      | application/json | application/json | Get    | searches/Default/query/solrQuery/Default.Column%3A%3A%3A | ?limit=0                          |                                                          |
#      | application/json | application/json | Post   | searches/Default?query=g.V().hasLabel(%22Default.Column%22)&what=name&limit= |                                   | idc/IDX_Integration_Payloads/TableExample.json           |


  @MLP-4685 @regression @positive
  Scenario Outline: Login Scenario - To verify visibility of item relations for child item
    Given user get the column "NewChildColumn" id from the following query
      | description | schemaName | tableName | typeName | columnName | criteriaName |
      | SELECT      | public     | items     | Column   | id         | name         |
    And  user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestDataAdmin" user
    When Status code 200 must be returned
    Examples:
      | contentType      | acceptType       | type | url                                                   | endpoint | body |
      | application/json | application/json | Get  | items/Default/relations?srcid=Default.Column%3A%3A%3A | &limit=0 |      |

  @MLP-4685 @regression @positive
  Scenario Outline: Login Scenario - Verification of visibility for adding comments for child
    Given user get the column "NewChildColumn" id from the following query
      | description | schemaName | tableName | typeName | columnName | criteriaName |
      | SELECT      | public     | items     | Column   | id         | name         |
    When user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestSystemUser" user
    Then Status code 200 must be returned
    Examples:
      | contentType      | acceptType       | type | url                                      | endpoint | body                                              |
      | application/json | application/json | Post | comments/Default/Default.Column%3A%3A%3A |          | idc/IDX_Integration_Payloads/MLP-4685_Comment.txt |

  @MLP-4685 @regression @positive
  Scenario Outline: Login Scenario - Verification of visibility for PUT comments/{catalog}/{id} for child item
    Given user get the column "ChildComment" id from the following query
      | description | schemaName | tableName | typeName | columnName | criteriaName | criteriaAttribute      |
      | SELECT      | public     | items     | Comment  | id         |              | attributes->>'message' |
    When user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestDataAdmin" user
    Then Status code 403 must be returned
    And response message contains value "Access to the specified resource has been forbidden"
    Examples:
      | contentType      | acceptType       | type   | url                                       | endpoint | body                                              |
      | application/json | application/json | Put    | comments/Default/Default.Comment%3A%3A%3A |          | idc/IDX_Integration_Payloads/PlainTextExample.txt |
      | application/json | application/json | Delete | comments/Default/Default.Comment%3A%3A%3A |          |                                                   |

  @MLP-4685 @MLP-5120 @regression @positive
  Scenario:MLP-4685_MLP-5120 Create an New item
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/IDX_Integration_Payloads/MLP_4685_New_Item_Creation.json"
    And user makes a REST Call for POST request with url "items/Default/root" and store the response
    And Status code 200 must be returned

  @MLP-4685 @regression @positive
  Scenario Outline: Login Scenario - To verify visibility giving access to items of assigned user
    Given user get the column "ClusterTest03" id from the following query
      | description | schemaName | tableName | typeName | columnName | criteriaName |
      | SELECT      | public     | items     | Cluster  | id         | name         |
    And  user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestSystemUser" user
    When Status code 204 must be returned
    Examples:
      | contentType      | acceptType       | type | url                                       | endpoint                       | body                                                    |
      | application/json | application/json | Put  | accesses/Default/Default.Cluster%3A%3A%3A | ?recursive=false&operation=SET | idc/IDX_Integration_Payloads/MLP-4685_SystemAccess.json |


  @MLP-4685 @regression @positive
  Scenario Outline: Login Scenario - To verify visibility for Put and Delete items of assigned user
    Given user get the column "ClusterTest03" id from the following query
      | description | schemaName | tableName | typeName | columnName | criteriaName |
      | SELECT      | public     | items     | Cluster  | id         | name         |
    And  user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestSystemUser" user
    When Status code 204 must be returned
    Examples:
      | contentType      | acceptType       | type   | url                                    | endpoint | body                                                     |
      | application/json | application/json | Put    | items/Default/Default.Cluster%3A%3A%3A |          | idc/IDX_Integration_Payloads/MLP-4685_Item_Updation.json |
      | application/json | application/json | Delete | items/Default/Default.Cluster%3A%3A%3A |          |                                                          |

  @MLP-4685 @regression @positive
  Scenario Outline: verify visibility of item searches for the child user
    Given user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>" and body "<body>" for "TestDataAdmin" user
    When Status code 200 must be returned
    Examples:
      | contentType      | acceptType       | type | url                                  | body |
      | application/json | application/json | Get  | searches/Default/list/Column?limit=0 |      |

  @MLP-4685 @regression @positive
  Scenario Outline: Login Scenario - To verify visibility of item searches for the child user
    Given user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>" and body "<body>" for "TestDataAdmin" user
    When Status code 200 must be returned
    And response message not contains value "NewChildColumn"
    Examples:
      | contentType      | acceptType       | type | url                                                                                                                        | body |
      | application/json | application/json | Post | searches/fulltext?query=%22type%22%3A%20%22Column%22&what=name&advanced=false&limit=10000&offset=0&limitFacets=10000       |      |
      | application/json | application/json | Get  | searches/fulltext?query=%22type%22%3A%20%22Table%22&what=name&advanced=false&limit=10000&offset=0                          |      |
      | application/json | application/json | Get  | searches/fulltext/Default?query=%22type%22%3A%20%22Column%22&what=name&limit=10000&offset=0                                |      |
      | application/json | application/json | Post | searches/fulltext/Default?query=%22type%22%3A%20%22Column%22&what=name&advanced=false&limit=10000&offset=0&limitFacets=100 |      |
      | application/json | application/json | Get  | searches/fulltext/autosuggest?input=NewChild&limit=100                                                                     |      |
      | application/json | application/json | Get  | searches/fulltext/autosuggest/Default?input=NewChild&limit=100                                                             |      |
      | application/json | application/json | Get  | searches/fulltext/autosuggest/Default/Column?input=NewChild&limit=100                                                      |      |
      | application/json | application/json | Get  | tags/Default/items?tags=Phone%20Number&subtags=true&limit=0&offset=0                                                       |      |
      | application/json | application/json | Get  | tags/Default/Phone%20Number/items?subtags=true&limit=0&offset=0                                                            |      |
#      | application/json | application/json | Get  | searches/Default?query=g.V().hasLabel(%22Default.Column%22)&what=name&limit=0                                              |      |

  @MLP-4685 @regression @positive
  Scenario Outline: Login Scenario - To verify visibility of item fulltext searches after setting access
    Given user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>" and body "<body>" for "TestDataAdmin" user
    When Status code 200 must be returned
    And response message not contains value "TableSingleTest"
    Examples:
      | contentType      | acceptType       | type | url                                                                         | body |
      | application/json | application/json | Get  | searches/fulltext/autosuggest?input=TableSingleTest&limit=100               |      |
      | application/json | application/json | Get  | searches/fulltext/autosuggest/Default?input=TableSingleTest&limit=100       |      |
      | application/json | application/json | Get  | searches/fulltext/autosuggest/Default/Table?input=TableSingleTest&limit=100 |      |

  @MLP-4685 @regression @positive
  Scenario Outline: Login Scenario - To verify visibility of item fulltext searches for the assigned user
    Given user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>" and body "<body>" for "TestSystemUser" user
    When Status code 200 must be returned
    And response message contains value "TableSingleTest"
    Examples:
      | contentType      | acceptType       | type | url                                                                           | body |
      | application/json | application/json | Get  | searches/fulltext/autosuggest?input=TableSingleTest&limit=10000               |      |
      | application/json | application/json | Get  | searches/fulltext/autosuggest/Default?input=TableSingleTest&limit=10000       |      |
      | application/json | application/json | Get  | searches/fulltext/autosuggest/Default/Table?input=TableSingleTest&limit=10000 |      |

  @MLP-4685 @MLP-5120 @regression @positive
  Scenario Outline: Verification of adding access information for an item with recursive true
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/IDX_Integration_Payloads/MLP-4685_DataAdminAccess.json"
    And user makes a REST Call for "PUT" request with url "accesses/Default/Default.Table%3A%3A%3Adynamic" and path "" and get paramater from "payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json" file and "$..has_Table.id" json
      | recursive | true&operation=ADD |
    And Status code 204 must be returned
    Given user get the column "NewChildColumn" id from the following query
      | description | schemaName | tableName | typeName | columnName | criteriaName |
      | SELECT      | public     | items     | Column   | id         | name         |
    And configure a new REST API for the service "IDC"
    Then user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestSystemUser" user
    And response returns with the following items
      | description | searchItems | expectedResults |
      | Status Code |             | 200             |
    And user compares the value from response using json path "$..['asg_acl']"
      | jsonValues                                                               |
      | {\users\:\TestSystem\,\Test Data Admin\,\groups\:\System\,\Data Admins\} |
    Examples:
      | contentType      | acceptType       | type | url                                      | endpoint         | body |
      | application/json | application/json | Get  | accesses/Default/Default.Column%3A%3A%3A | ?recursive=false |      |

  @MLP-4685 @MLP-5120 @regression @positive
  Scenario Outline: Verification of subtracting access information for an item with recursive true
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/IDX_Integration_Payloads/MLP-4685_DataAdminAccess.json"
    And user makes a REST Call for "PUT" request with url "accesses/Default/Default.Table%3A%3A%3Adynamic" and path "" and get paramater from "payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json" file and "$..has_Table.id" json
      | recursive | true&operation=SUB |
    And Status code 204 must be returned
    Given user get the column "NewChildColumn" id from the following query
      | description | schemaName | tableName | typeName | columnName | criteriaName |
      | SELECT      | public     | items     | Column   | id         | name         |
    And configure a new REST API for the service "IDC"
    Then user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestSystemUser" user
    And response returns with the following items
      | description | searchItems | expectedResults |
      | Status Code |             | 200             |
    And user compares the value from response using json path "$..['asg_acl']"
      | jsonValues                                           |
      | {\"users\":[\"TestSystem\"],\"groups\":[\"System\"]} |
    Examples:
      | contentType      | acceptType       | type | url                                      | endpoint         | body |
      | application/json | application/json | Get  | accesses/Default/Default.Column%3A%3A%3A | ?recursive=false |      |

  @MLP-5120 @regression @positive
  Scenario: Verification of getting access information for an item with recursive true
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for "GET" request with url "accesses/Default/Default.Table%3A%3A%3Adynamic" and path "" and get paramater from "payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json" file and "$..has_Table.id" json
      | recursive | true |
    And Status code 200 must be returned
    And user compares the value from response using json path "$.[0].['asg_acl']"
      | jsonValues                                   |
      | {"users":["TestSystem"],"groups":["System"]} |
    And user compares the value from response using json path "$.[1].['asg_acl']"
      | jsonValues                                   |
      | {"users":["TestSystem"],"groups":["System"]} |

  @MLP-4685 @MLP-5120 @regression @positive
  Scenario:MLP-4685_MLP-5120 Create a New Table Item(SampleTest1)
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/IDX_Integration_Payloads/MLP_4685_New_Table_Item_Creation.json"
    And user makes a REST Call for POST request with url "items/Default/root" and store the response
    And Status code 200 must be returned
    And user add JsonArray value in payload "idc/IDX_Integration_Payloads/MLP-4685_MultipleItems.json" to "0" index from response
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/IDX_Integration_Payloads/MLP_4685_New_Table_Item_Creation2.json"
    And user makes a REST Call for POST request with url "items/Default/root" and store the response
    And Status code 200 must be returned
    And user append JsonArray value in payload "idc/IDX_Integration_Payloads/MLP-4685_MultipleItems.json" to "0" index with "," from response

  @MLP-4685 @MLP-5120 @regression @positive
  Scenario: Verification of setting access information for multiple item
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/IDX_Integration_Payloads/MLP-4685_MultipleItems.json"
    And user makes a REST Call for "POST" request with url "accesses/Default" and path "" and get paramater from "" file and "" json
      | recursive | false&operation=SET&acluser=Test%20Guest%20User&aclgroup=Guest%20Users |
    And Status code 204 must be returned

  @MLP-4685 @MLP-5120 @regression @positive
  Scenario Outline: Verification of getting access information for multiple item1
    Given user get the column "SampleTest1" id from the following query
      | description | schemaName | tableName | typeName | columnName | criteriaName |
      | SELECT      | public     | items     | Table    | id         | name         |
    And configure a new REST API for the service "IDC"
    Then user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestSystemUser" user
    And response returns with the following items
      | description | searchItems | expectedResults |
      | Status Code |             | 200             |
    And user compares the value from response using json path "$..['asg_acl']"
      | jsonValues                                                     |
      | {\"users\":[\"Test Guest User\"],\"groups\":[\"Guest Users\"]} |
    Examples:
      | contentType      | acceptType       | type | url                                     | endpoint         | body |
      | application/json | application/json | Get  | accesses/Default/Default.Table%3A%3A%3A | ?recursive=false |      |


  @MLP-4685 @MLP-5120 @regression @positive
  Scenario Outline: Verification of getting access information for multiple item2
    Given user get the column "SampleTest2" id from the following query
      | description | schemaName | tableName | typeName | columnName | criteriaName |
      | SELECT      | public     | items     | Table    | id         | name         |
    And configure a new REST API for the service "IDC"
    Then user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestSystemUser" user
    And response returns with the following items
      | description | searchItems | expectedResults |
      | Status Code |             | 200             |
    And user compares the value from response using json path "$..['asg_acl']"
      | jsonValues                                                     |
      | {\"users\":[\"Test Guest User\"],\"groups\":[\"Guest Users\"]} |
    Examples:
      | contentType      | acceptType       | type | url                                     | endpoint         | body |
      | application/json | application/json | Get  | accesses/Default/Default.Table%3A%3A%3A | ?recursive=false |      |


  @MLP-4685 @MLP-5120 @regression @positive
  Scenario: Verification of adding access information for multiple item
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/IDX_Integration_Payloads/MLP-4685_MultipleItems.json"
    And user makes a REST Call for "POST" request with url "accesses/Default" and path "" and get paramater from "" file and "" json
      | recursive | false&operation=ADD&acluser=Test%20Data%20Admin&aclgroup=Data%20Admins |
    And Status code 204 must be returned

  @MLP-4685 @MLP-5120 @regression @positive
  Scenario Outline: Verification of getting added access information for multiple item1
    Given user get the column "SampleTest1" id from the following query
      | description | schemaName | tableName | typeName | columnName | criteriaName |
      | SELECT      | public     | items     | Table    | id         | name         |
    And configure a new REST API for the service "IDC"
    Then user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestSystemUser" user
    And response returns with the following items
      | description | searchItems | expectedResults |
      | Status Code |             | 200             |
    And user compares the value from response using json path "$..['asg_acl']"
      | jsonValues                                                                         |
      | {\users\:\Test Guest User\,\Test Data Admin\,\groups\:\Guest Users\,\Data Admins\} |
    Examples:
      | contentType      | acceptType       | type | url                                     | endpoint         | body |
      | application/json | application/json | Get  | accesses/Default/Default.Table%3A%3A%3A | ?recursive=false |      |


  @MLP-4685 @MLP-5120 @regression @positive
  Scenario Outline: Verification of getting added access information for multiple item2
    Given user get the column "SampleTest2" id from the following query
      | description | schemaName | tableName | typeName | columnName | criteriaName |
      | SELECT      | public     | items     | Table    | id         | name         |
    And configure a new REST API for the service "IDC"
    Then user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestSystemUser" user
    And response returns with the following items
      | description | searchItems | expectedResults |
      | Status Code |             | 200             |
    And user compares the value from response using json path "$..['asg_acl']"
      | jsonValues                                                                         |
      | {\users\:\Test Guest User\,\Test Data Admin\,\groups\:\Guest Users\,\Data Admins\} |
    Examples:
      | contentType      | acceptType       | type | url                                     | endpoint         | body |
      | application/json | application/json | Get  | accesses/Default/Default.Table%3A%3A%3A | ?recursive=false |      |

  @MLP-4685 @MLP-5120 @regression @positive
  Scenario: Verification of subtracting access information for multiple item
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/IDX_Integration_Payloads/MLP-4685_MultipleItems.json"
    And user makes a REST Call for "POST" request with url "accesses/Default" and path "" and get paramater from "" file and "" json
      | recursive | false&operation=SUB&acluser=Test%20Data%20Admin&aclgroup=Data%20Admins |
    And Status code 204 must be returned

  @MLP-4685 @MLP-5120 @regression @positive
  Scenario Outline: Verification of getting subtracted access information for multiple item1
    Given user get the column "SampleTest1" id from the following query
      | description | schemaName | tableName | typeName | columnName | criteriaName |
      | SELECT      | public     | items     | Table    | id         | name         |
    And configure a new REST API for the service "IDC"
    Then user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestSystemUser" user
    And response returns with the following items
      | description | searchItems | expectedResults |
      | Status Code |             | 200             |
    And user compares the value from response using json path "$..['asg_acl']"
      | jsonValues                                         |
      | {\users\:\Test Guest User\,\groups\:\Guest Users\} |
    Examples:
      | contentType      | acceptType       | type | url                                     | endpoint         | body |
      | application/json | application/json | Get  | accesses/Default/Default.Table%3A%3A%3A | ?recursive=false |      |


  @MLP-4685 @MLP-5120 @regression @positive
  Scenario Outline: Verification of getting subtracted access information for multiple item2
    Given user get the column "SampleTest2" id from the following query
      | description | schemaName | tableName | typeName | columnName | criteriaName |
      | SELECT      | public     | items     | Table    | id         | name         |
    And configure a new REST API for the service "IDC"
    Then user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestSystemUser" user
    And response returns with the following items
      | description | searchItems | expectedResults |
      | Status Code |             | 200             |
    And user compares the value from response using json path "$..['asg_acl']"
      | jsonValues                                         |
      | {\users\:\Test Guest User\,\groups\:\Guest Users\} |
    Examples:
      | contentType      | acceptType       | type | url                                     | endpoint         | body |
      | application/json | application/json | Get  | accesses/Default/Default.Table%3A%3A%3A | ?recursive=false |      |

  @MLP-4685 @regression @positive
  Scenario Outline: Verification of getting access information for an item with what parameter
    Given user get the column "SampleTest2" id from the following query
      | description | schemaName | tableName | typeName | columnName | criteriaName |
      | SELECT      | public     | items     | Table    | id         | name         |
    And configure a new REST API for the service "IDC"
    Then user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestSystemUser" user
    And response returns with the following items
      | description | searchItems | expectedResults |
      | Status Code |             | 200             |
    And user compares the value from response using json path "$..['asg_acl']"
      | jsonValues                                         |
      | {\users\:\Test Guest User\,\groups\:\Guest Users\} |
    Examples:
      | contentType      | acceptType       | type | url                                     | endpoint                      | body |
      | application/json | application/json | Get  | accesses/Default/Default.Table%3A%3A%3A | ?what=asg_acl&recursive=false |      |

  @MLP-4685 @MLP-5120 @regression @positive
  Scenario: Verification of clearing access information for multiple item
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/IDX_Integration_Payloads/MLP-4685_MultipleItems.json"
    And user makes a REST Call for "POST" request with url "accesses/Default" and path "" and get paramater from "" file and "" json
      | recursive | false&operation=CLEAR&&acluser=Test%20Guest%20User&aclgroup=Guest%20Users |
    And Status code 204 must be returned

  @MLP-4685 @MLP-5120 @regression @positive
  Scenario Outline: Verification of getting clearing access information for multiple item1
    Given user get the column "SampleTest1" id from the following query
      | description | schemaName | tableName | typeName | columnName | criteriaName |
      | SELECT      | public     | items     | Table    | id         | name         |
    And configure a new REST API for the service "IDC"
    Then user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestSystemUser" user
    And response returns with the following items
      | description | searchItems | expectedResults |
      | Status Code |             | 200             |
    And response message not contains value "Test Guest User"
    Examples:
      | contentType      | acceptType       | type | url                                     | endpoint         | body |
      | application/json | application/json | Get  | accesses/Default/Default.Table%3A%3A%3A | ?recursive=false |      |


  @MLP-4685 @MLP-5120 @regression @positive
  Scenario Outline: Verification of getting clearing access information for multiple item2
    Given user get the column "SampleTest2" id from the following query
      | description | schemaName | tableName | typeName | columnName | criteriaName |
      | SELECT      | public     | items     | Table    | id         | name         |
    And configure a new REST API for the service "IDC"
    Then user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestSystemUser" user
    And response returns with the following items
      | description | searchItems | expectedResults |
      | Status Code |             | 200             |
    And response message not contains value "TestInfo"
    Examples:
      | contentType      | acceptType       | type | url                                     | endpoint         | body |
      | application/json | application/json | Get  | accesses/Default/Default.Table%3A%3A%3A | ?recursive=false |      |

  @MLP-4685 @regression @positive
  Scenario: MLP-4685 Verification of setting and getting information for an item with what parameter for few Services
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/IDX_Integration_Payloads/MLP-4685_DataAdminAccess.json"
    And user makes a REST Call for "PUT" request with url "accesses/Default/Default.Table%3A%3A%3Adynamic" and path "" and get paramater from "payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json" file and "$..has_Table.id" json
      | recursive | true&operation=SET |
    And Status code 204 must be returned
    And user makes a REST Call for "GET" request with url "accesses/Default/Default.Table%3A%3A%3Adynamic" and path "" and get paramater from "payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json" file and "$..has_Table.id" json
      | recursive | true |
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues                                 | jsonPath          |
      | {users:Test Data Admin,groups:Data Admins} | $.[0].['asg_acl'] |


  @MLP-4685 @regression @positive
  Scenario Outline: Verification of getting information for an item with what parameter for few Services
    Given user makes request with "<url>" and type "<type>" to verify "<responseCode>" and "<responseMessage>" using "<inputJson>" from "<inputFile>" with body "<body>" for "TestDataAdmin" user and with "<contentType>" and "<acceptType>"
    Examples:
      | contentType      | acceptType       | type | url                                                                                                     | body                                           | responseCode | inputJson       | inputFile                                                   | responseMessage |
      | application/json | application/json | Get  | items/Default/Default.Table%3A%3A%3Adynamic                                                             |                                                | 200          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json | asg_acl         |
      | application/json | application/json | Get  | items/Default/Default.Table%3A%3A%3Adynamic/env?dir=%3C-%3E&limit=0                                     |                                                | 200          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json | asg_acl         |
      | application/json | application/json | Get  | searches/Default/list/Table?limit=0                                                                     |                                                | 200          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json | asg_acl         |
      | application/json | application/json | Get  | searches/fulltext/Default?query=type%3DTable&advanced=true&natural=false&limit=10&offset=0              |                                                | 200          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json |                 |
      | application/json | application/json | Get  | searches/fulltext?query=*&advanced=false&natural=false&limit=10000&offset=0                             |                                                | 200          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json |                 |
      | application/json | application/json | Post | items/Default?what=asg_acl                                                                              | idc/IDX_Integration_Payloads/TableExample.json | 200          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json | asg_acl         |
      | application/json | application/json | Post | searches/fulltext/Default?query=type%20%3D%20Table&advanced=false&limit=10000&offset=0&limitFacets=1000 |                                                | 200          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json | asg_acl         |
#      | application/json | application/json | Post | searches/Default?query=g.V().hasLabel(%27%24%7Bschema%7D.Table%27)%20&what=asg_acl&what=asg.access&limit=0                           | idc/MLP-4685_TableData.json | 200          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json | asg_acl                      |
#      | application/json | application/json | Get  | searches/Default?query=g.V().hasLabel(%27%24%7Bschema%7D.Table%27)%20&what=asg_acl&what=asg.access&limit=0                           |                             | 200          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-4685_Item_id.json | asg_acl                       |

  Scenario Outline: user retrieves ID with catalog name and type for SampleTest1
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive | catalog | type  | name        | asg_scopeid | targetFile                                                             | jsonpath        |
      | APPDBPOSTGRES | ID      | Default | Table | SampleTest1 |             | payloads/idc/IDX_Integration_Payloads/MLP-4685_SampleTest_Item_id.json | $..has_Table.id |

  @MLP-4685  @regression @positive
  Scenario: Verification of recommendation based on rating for Table
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for "POST" request with url "ratings/Default/Default.Table%3A%3A%3Adynamic/5" and path "" and get paramater from "payloads/idc/IDX_Integration_Payloads/MLP-4685_SampleTest_Item_id.json" file and "$..has_Table.id" json
      |  |  |
    And Status code 201 must be returned
    And supply payload with file name "idc/IDX_Integration_Payloads/MLP-4685_GuestAccess.json"
    And user makes a REST Call for "PUT" request with url "accesses/Default/Default.Table%3A%3A%3Adynamic" and path "" and get paramater from "payloads/idc/IDX_Integration_Payloads/MLP-4685_SampleTest_Item_id.json" file and "$..has_Table.id" json
      | recursive | true&operation=SET |
    And Status code 204 must be returned
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    Then user makes a REST Call for Get request with url "recommendations/items/Default"
    And Status code 200 must be returned
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for "DELETE" request with url "accesses/Default/Default.Table%3A%3A%3Adynamic" and path "" and get paramater from "payloads/idc/IDX_Integration_Payloads/MLP-4685_SampleTest_Item_id.json" file and "$..has_Table.id" json
      | recursive | true |
    And Status code 204 must be returned
