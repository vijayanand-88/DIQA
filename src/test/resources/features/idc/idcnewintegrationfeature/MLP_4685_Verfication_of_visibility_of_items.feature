#@MLP-4685
#Feature: MLP-4685 - Verification of visibility of items
#
#  @MLP-4685 @MLP-5120 @regression @positive
#  Scenario:MLP-4685_MLP-5120 Verification of setting access information for an item
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user makes a REST Call for DELETE request with url "accesses/BigData/BigData.Table%3A%3A%3A1" with the following query param
#      | recursive | false |
#    And supply payload with file name "idc/MLP-4685_SystemAccess.json"
#    When user makes a REST Call for PUT request with url "accesses/BigData/BigData.Table%3A%3A%3A1" with the following query param
#      | recursive | false&operation=SET |
#    And Status code 204 must be returned
#    Then user makes a REST Call for Get request with url "accesses/BigData/BigData.Table%3A%3A%3A1" with the following query param
#      | what | asg.acl&recursive=false |
#    And response returns with the following items
#      | description | searchItems | expectedResults |
#      | Status Code |             | 200             |
#    And user compares the value from response using json path "$..['asg.acl']"
#      | jsonValues                                           |
#      | {\"users\":[\"TestSystem\"],\"groups\":[\"System\"]} |
#
#  @MLP-4685 @webtest @regression @positive
#  Scenario:Verification of Adding tags to the item
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user selects "BigData" catalog from catalog list
#    And user enters the search text "Customerspart" and clicks on search
#    And user selects the "Table" from the Type
#    And user click on any of the item and assign "Phone Number" tag to the item.
#    And user should be able logoff the IDC
#
#
#  @MLP-4685 @regression @positive
#  Scenario Outline: Login Scenario - To verify visibility of item  after setting access
#    Given user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>" and body "<body>" for "TestServiceUser" user
#    When Status code 403 must be returned
#    Then response message contains value "Access to the specified resource has been forbidden"
#    Examples:
#      | contentType      | acceptType       | type   | url                                                                      | body                            |
#      | application/json | application/json | Get    | items/BigData/BigData.Table%3A%3A%3A1                                    |                                 |
#      | application/json | application/json | Get    | components/BigData/item/BigData.Table%3A%3A%3A1                          |                                 |
#      | application/json | application/json | Get    | items/BigData/BigData.Table%3A%3A%3A1/env?dir=%3C-%3E&limit=0            |                                 |
#      | application/json | application/json | Post   | items/BigData/env?dir=%3C-%3E&limit=0                                    | idc/TableExample.json           |
#      | application/json | application/json | Put    | items/BigData/BigData.Table%3A%3A%3A1                                    | idc/TableExample.json           |
#      | application/json | application/json | Delete | items/BigData/BigData.Table%3A%3A%3A1                                    |                                 |
#      | application/json | application/json | Post   | items/BigData/BigData.Table%3A%3A%3A1?allowUpdate=false                  | idc/MLP-1101_Item_Creation.json |
#      | application/json | application/json | Post   | items/BigData/BigData.Table%3A%3A%3A1/Test?allowUpdate=false             | idc/MLP-1101_Item_Creation.json |
#      | application/json | application/json | Get    | comments/BigData/BigData.Table%3A%3A%3A1                                 |                                 |
#      | application/json | application/json | Post   | comments/BigData/BigData.Table%3A%3A%3A1                                 | idc/Example.json                |
#      | application/json | application/json | Get    | comments/preview/BigData/BigData.Table%3A%3A%3A1                         |                                 |
#      | application/json | application/json | Get    | ratings/BigData/BigData.Table%3A%3A%3A1?limit=10&order=date&reverse=true |                                 |
#      | application/json | application/json | Delete | ratings/BigData/BigData.Table%3A%3A%3A1?limit=10&order=date&reverse=true |                                 |
#      | application/json | application/json | Post   | ratings/BigData/BigData.Table%3A%3A%3A1/1                                |                                 |
#      | application/json | application/json | Get    | recommendations/items/BigData/BigData.Table%3A%3A%3A1                    |                                 |
#      | application/json | application/json | Post   | tags/BigData/assignments                                                 | idc/MLP_4685_TagExample.json    |
#      | application/json | application/json | Get    | tags/BigData/assignments?items=BigData.Table%3A%3A%3A1                   |                                 |
#      | application/json | application/json | Post   | searches/BigData/query/dataTagging?limit=0                               | idc/TableExample.json           |
#      | application/json | application/json | Get    | searches/BigData/query/solrQuery/BigData.Table%3A%3A%3A1?limit=0         |                                 |
#      | application/json | application/json | Post   | searches/BigData?query=g.V().hasLabel(%22BigData.Table%22)&limit=0       | idc/TableExample.json           |
#
#  @MLP-4685 @regression @positive
#  Scenario: Login Scenario - To verify visibility of item  after setting access for dataset
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/MLP-3297_DataSets_with_no_Elements.json"
#    When user makes a REST Call for POST request with url "datasets"
#    Then Status code 200 must be returned
#    And verify DataSet is created with name "DataSet with No DataElements", Description "data set with no DataElements" and status as "PUBLIC"
#    And user makes REST call for Get "datasets" and retrieves value from using jsonpath "$.[-1:].id"
#    And user add temp text JsonArray value in payload "idc/MLP_4685_DataElementsDataSet.json" to "0" index
#    And supply payload with file name "idc/MLP-4685_SystemAccess.json"
#    When user makes a REST Call for "PUT" request with url "accesses/DataSets/DataSets.DataSet%3A%3A%3AstoredID" and path "?recursive=false&operation=SET"
#    And user reset the REST API Service
#    And supply payload with file name "idc/MLP_4685_DataElementsDataSet.json"
#    When user makes a REST Call for "POST" request with url "datasets/DataSets.DataSet%3A%3A%3AstoredID/dataelements" and path "?operation=ADD"
#    Then response message contains value "Access to the specified resource has been forbidden"
#    And user makes a REST Call for "DELETE" request with url "accesses/DataSets/DataSets.DataSet%3A%3A%3AstoredID" and path "?recursive=false&operation=SET"
#    And user makes a REST Call for "DELETE" request with url "datasets/DataSets.DataSet%3A%3A%3AstoredID" and path ""
#
#
#  @MLP-4685 @regression @positive
#  Scenario Outline: Login Scenario - To verify visibility of item searches after setting access
#    Given user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>" and body "<body>" for "TestServiceUser" user
#    When Status code 200 must be returned
#    Then response message should not have value "BigData.Table:::1" for jsonpath "$..id"
##    And response message not contains value "BigData.Table:::1"
#
#    Examples:
#      | contentType      | acceptType       | type | url                                                                                                                              | body                      |
#      | application/json | application/json | Get  | searches/BigData/list/Table?limit=0                                                                                              |                           |
#      | application/json | application/json | Get  | searches/BigData?query=g.V().hasLabel(%22BigData.Table%22)&limit=0                                                               |                           |
#      | application/json | application/json | Post | searches/fulltext?query=%22id%22%3A%20%22BigData.Table%3A%3A%3A1%22&advanced=false&limit=10000&offset=0&limitFacets=1000         |                           |
#      | application/json | application/json | Get  | searches/fulltext?query=%22type%22%3A%20%22Table%22&advanced=false&limit=10000&offset=0                                          |                           |
#      | application/json | application/json | Get  | searches/fulltext/BigData?query=%22id%22%3A%20%22BigData.Table%3A%3A%3A1%22&limit=10000&offset=0                                 |                           |
#      | application/json | application/json | Post | searches/fulltext/BigData?query=%22id%22%3A%20%22BigData.Table%3A%3A%3A1%22&advanced=false&limit=10000&offset=0&limitFacets=1000 |                           |
#      | text/plain       | application/json | Post | searches                                                                                                                         | idc/MLP-4685_Searches.txt |
#      | application/json | application/json | Get  | tags/BigData/items?tags=Phone%20Number&subtags=true&limit=0&offset=0                                                             |                           |
#      | application/json | application/json | Get  | tags/BigData/Phone%20Number/items?subtags=true&limit=0&offset=0                                                                  |                           |
#
#  @MLP-4685 @regression @positive
#  Scenario Outline: Login Scenario - To verify visibility of item fulltext searches after setting access
#    Given user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>" and body "<body>" for "TestServiceUser" user
#    When Status code 200 must be returned
#    And response message not contains value "Customerspart"
#
#    Examples:
#      | contentType      | acceptType       | type | url                                                                  | body |
#      | application/json | application/json | Get  | searches/fulltext/autosuggest?input=customer&limit=100               |      |
#      | application/json | application/json | Get  | searches/fulltext/autosuggest/BigData?input=customer&limit=100       |      |
#      | application/json | application/json | Get  | searches/fulltext/autosuggest/BigData/Table?input=customer&limit=100 |      |
#
#
#  @MLP-4685 @regression @positive
#  Scenario: Verification of setting access information for Dataset
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/MLP-4685_DataSets.json"
#    When user makes a REST Call for POST request with url "datasets"
#    And Status code 200 must be returned
#    And user get the column "AutomationDataSet" id from the following query
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | DataSets   | V_DataSet | ID         | name         |
#    And supply payload with file name "idc/MLP-4685_SystemAccess.json"
#    And user makes a REST Call for PUT request with url "accesses/DataSets/DataSets.DataSet%3A%3A%3A" with dynamic id for dataset
#    And Status code 204 must be returned
#
#
#  @MLP-4685 @regression @positive
#  Scenario Outline: Login Scenario - To verify visibility of datasets after setting access
#    Given user get the column "AutomationDataSet" id from the following query
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | DataSets   | V_DataSet | ID         | name         |
#    When user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestServiceUser" user
#    Then Status code 403 must be returned
#    And response message contains value "Access to the specified resource has been forbidden"
#    Examples:
#      | contentType      | acceptType       | type   | url                                | endpoint                               | body                                          |
#      | application/json | application/json | Get    | datasets/DataSets.DataSet%3A%3A%3A |                                        |                                               |
#      | application/json | application/json | Put    | datasets/DataSets.DataSet%3A%3A%3A |                                        |                                               |
#      | application/json | application/json | Post   | datasets/DataSets.DataSet%3A%3A%3A |                                        |                                               |
#      | application/json | application/json | Delete | datasets/DataSets.DataSet%3A%3A%3A |                                        |                                               |
#      | application/json | application/json | Post   | datasets/DataSets.DataSet%3A%3A%3A | /notebooks                             | idc/MLP-3297_DataSets_with_data_Elements.json |
#      | application/json | application/json | Get    | datasets/DataSets.DataSet%3A%3A%3A | /notebooks/views                       |                                               |
#      | application/json | application/json | Put    | datasets/DataSets.DataSet%3A%3A%3A | /notebooks/DataSets.Notebook%3A%3A%3A1 | idc/MLP-3808_NewNotebook.json                 |
#      | application/json | application/json | Post   | datasets/DataSets.DataSet%3A%3A%3A | /dataelements?operation=ADD            | idc/MLP_4685_DataSet.json                     |
#
#
#  @MLP-4685 @regression @positive
#  Scenario: Verification of visibility for GET "/datasets
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    When user makes a REST Call for Get request with url "/datasets"
#    And Status code 200 must be returned
#    And response message not contains value "AutomationDataSet"
#
#  @MLP-4685 @regression @positive
#  Scenario: Verification of visibility for GET "/datasets for the assigned user
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
#      | Content-Type  | application/json               |
#      | Accept        | application/json               |
#    When user makes a REST Call for Get request with url "/datasets"
#    And Status code 200 must be returned
#    And response message contains value "AutomationDataSet"
#
#  @MLP-4685 @regression @positive
#  Scenario: Verification of visibility for POST /ratings/{catalogname}/{itemid}/{rating} assigned user
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
#      | Content-Type  | application/json               |
#      | Accept        | application/json               |
#    When user makes a REST Call for POST request with url "ratings/BigData/BigData.Table:::1/1"
#    And Status code 201 must be returned
#
#
#  @MLP-4685 @regression @positive
#  Scenario Outline: Login Scenario - To verify visibility of item for the assigned user
#    Given user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>" and body "<body>" for "TestSystemUser" user
#    When Status code 200 must be returned
#    Examples:
#      | contentType      | acceptType       | type | url                                                                      | body                                   |
#      | application/json | application/json | Get  | components/BigData/item/BigData.Table%3A%3A%3A1                          |                                        |
#      | application/json | application/json | Get  | items/BigData/BigData.Table%3A%3A%3A1                                    |                                        |
#      | application/json | application/json | Get  | items/BigData/BigData.Table%3A%3A%3A1/env?dir=%3C-%3E&limit=0            |                                        |
#      | application/json | application/json | Get  | comments/BigData/BigData.Table%3A%3A%3A1                                 |                                        |
#      | application/json | application/json | Get  | comments/preview/BigData/BigData.Table%3A%3A%3A1                         |                                        |
#      | application/json | application/json | Get  | ratings/BigData/BigData.Table%3A%3A%3A1?limit=10&order=date&reverse=true |                                        |
#      | application/json | application/json | Get  | recommendations/items/BigData/BigData.Table%3A%3A%3A1                    |                                        |
#      | application/json | application/json | Get  | tags/BigData/assignments?items=BigData.Table%3A%3A%3A1                   |                                        |
#      | application/json | application/json | Get  | searches/BigData/query/solrQuery/BigData.Table%3A%3A%3A1?limit=0         |                                        |
#      | application/json | application/json | Post | items/BigData/env?dir=%3C-%3E&limit=0                                    | idc/TableExample.json                  |
#      | application/json | application/json | Post | comments/BigData/BigData.Table%3A%3A%3A1                                 | idc/PlainTextExample.txt               |
#      | application/json | application/json | Get  | items/BigData/relations?srcid=BigData.Table%3A%3A%3A1&limit=0            |                                        |
#      | application/json | application/json | Post | items/BigData/BigData.Table%3A%3A%3A1?allowUpdate=false                  | idc/MLP-1101_Item_Creation.json        |
#      | application/json | application/json | Post | items/BigData/BigData.Table%3A%3A%3A1/Definitions?allowUpdate=false      | idc/MLP-1101_MultipleItemCreation.json |
#
#  @MLP-4685 @regression @positive
#  Scenario: Login Scenario - To verify visibility of data elements item for the assigned user
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/MLP-3297_DataSets_with_no_Elements.json"
#    When user makes a REST Call for POST request with url "datasets"
#    Then Status code 200 must be returned
#    And verify DataSet is created with name "DataSet with No DataElements", Description "data set with no DataElements" and status as "PUBLIC"
#    And user makes REST call for Get "datasets" and retrieves value from using jsonpath "$.[-1:].id"
#    And user add temp text JsonArray value in payload "idc/MLP_4685_DataElementsDataSet.json" to "0" index
#    And supply payload with file name "idc/MLP_4685_DataElementsDataSet.json"
#    When user makes a REST Call for "POST" request with url "datasets/DataSets.DataSet%3A%3A%3AstoredID/dataelements" and path ""
#    Then Status code 200 must be returned
#    And user makes a REST Call for "DELETE" request with url "accesses/DataSets/DataSets.DataSet%3A%3A%3AstoredID" and path "?recursive=false&operation=SET"
#    And user makes a REST Call for "DELETE" request with url "datasets/DataSets.DataSet%3A%3A%3AstoredID" and path ""
#
#
#  @MLP-4685 @regression @positive
#  Scenario Outline: Login Scenario - Verification of visibility for PUT comments/{catalog}/{id}
#    Given user get the column "TestAutomation" id from the following query
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | BigData    | V_Comment | ID         | message      |
#    When user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestServiceUser" user
#    Then Status code 403 must be returned
#    And response message contains value "Access to the specified resource has been forbidden"
#    Examples:
#      | contentType      | acceptType       | type | url                                       | endpoint | body                     |
#      | application/json | application/json | Put  | comments/BigData/BigData.Comment%3A%3A%3A |          | idc/PlainTextExample.txt |
#
#
#  @MLP-4685 @regression @positive
#  Scenario Outline: Login Scenario - Verification of visibility for PUT comments/{catalog}/{id} for assigned user
#    Given user get the column "TestAutomation" id from the following query
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | BigData    | V_Comment | ID         | message      |
#    When user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestSystemUser" user
#    Then Status code 204 must be returned
#    Examples:
#      | contentType      | acceptType       | type   | url                                       | endpoint | body                     |
#      | application/json | application/json | Put    | comments/BigData/BigData.Comment%3A%3A%3A |          | idc/PlainTextExample.txt |
#      | application/json | application/json | Delete | comments/BigData/BigData.Comment%3A%3A%3A |          |                          |
#
#
#  @MLP-4685 @regression @positive
#  Scenario Outline: Login Scenario - Verification of visibility for POST/datasets/{id} assigned user
#    Given user get the column "AutomationDataSet" id from the following query
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | DataSets   | V_DataSet | ID         | name         |
#    When user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestSystemUser" user
#    Then Status code 200 must be returned
#    Examples:
#      | contentType      | acceptType       | type | url                                | endpoint | body                            |
#      | application/json | application/json | Post | datasets/DataSets.DataSet%3A%3A%3A |          | idc/MLP_4685_DataSetAccess.json |
#
#
#  @MLP-4685 @regression @positive
#  Scenario Outline: Login Scenario - To verify visibility of item searches for the assigned user
#    Given user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>" and body "<body>" for "TestSystemUser" user
#    When Status code 200 must be returned
#    And response message contains value "BigData.Table:::1"
#
#    Examples:
#      | contentType      | acceptType       | type | url                                                                                                                                    | body                      |
#      | application/json | application/json | Get  | searches/BigData/list/Table?limit=0                                                                                                    |                           |
#      | application/json | application/json | Get  | searches/BigData?query=g.V().hasLabel(%22BigData.Table%22)&limit=0                                                                     |                           |
#      | application/json | application/json | Post | searches/fulltext?query=type%20%3D%20Table&advanced=false&limit=10000&offset=0&limitFacets=10        |                           |
#      | application/json | application/json | Get  | searches/fulltext?query=type%20%3D%20Table&what=id&advanced=false&limit=100000&offset=0                                        |                           |
#      | application/json | application/json | Get  | searches/fulltext/BigData?query=type%20%3D%20Table&what=id&advanced=false&limit=100000&offset=0                               |                           |
#      | application/json | application/json | Post | searches/fulltext/BigData?query=type%20%3D%20Table&advanced=false&limit=10000&offset=0&limitFacets=10 |                           |
#      | application/json | application/json | Post | searches/BigData/query/queryDiagramIn?limit=0                                                                                          | idc/TableExample.json     |
#      | application/json | application/json | Get  | searches/BigData/query/queryDiagramIn/BigData.Table%3A%3A%3A1?limit=0                                                                  |                           |
#      | application/json | application/json | Post | searches/BigData?query=g.V().hasLabel(%22BigData.Table%22)&limit=0                                                                     | idc/TableExample.json     |
#      | text/plain       | application/json | Post | searches                                                                                                                               | idc/MLP-4685_Searches.txt |
#      | application/json | application/json | Get  | tags/BigData/items?tags=Phone%20Number&subtags=true&limit=0&offset=0                                                                   |                           |
#      | application/json | application/json | Get  | tags/BigData/Phone%20Number/items?subtags=true&limit=0&offset=0                                                                        |                           |
#
#
#  @MLP-4685 @regression @positive
#  Scenario Outline: Login Scenario - To verify tag assignment and Delete ratings for the assigned user
#    Given user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>" and body "<body>" for "TestSystemUser" user
#    When Status code 204 must be returned
#    Examples:
#      | contentType      | acceptType       | type   | url                                     | body                   |
#      | application/json | application/json | Delete | ratings/BigData/BigData.Table%3A%3A%3A1 |                        |
#      | application/json | application/json | Post   | tags/BigData/assignments                | idc/MLP_4685_Tags.json |
#
#  @MLP-4685 @MLP-5120 @regression @positive
#  Scenario:MLP-4685_MLP-5120 Verification of adding access information for an item
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/MLP-4685_ServiceAccess.json"
#    When user makes a REST Call for PUT request with url "accesses/BigData/BigData.Table%3A%3A%3A1" with the following query param
#      | recursive | false&operation=ADD |
#    And Status code 204 must be returned
#    Then user makes a REST Call for Get request with url "accesses/BigData/BigData.Table%3A%3A%3A1" with the following query param
#      | what | asg.acl&recursive=false |
#    And response returns with the following items
#      | description | searchItems | expectedResults |
#      | Status Code |             | 200             |
#    And user compares the value from response using json path "$..['asg.acl']"
#      | jsonValues                                                                       |
#      | {\"users\":[\"TestSystem\",\"TestService\"],\"groups\":[\"System\",\"Service\"]} |
#
#  @MLP-5120 @regression @positive
#  Scenario:MLP-5120 Verification of getting access information for an item with acluser and aclgroup
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/MLP-4685_ServiceAccess.json"
#    When user makes a REST Call for Get request with url "accesses/BigData/BigData.Table%3A%3A%3A1" with the following query param
#      | what | asg.acl&recursive=false&acluser=TestSystem&acluser=TestService&aclgroup=System&aclgroup=Service |
#    Then response returns with the following items
#      | description | searchItems | expectedResults |
#      | Status Code |             | 200             |
#    And user compares the value from response using json path "$..['asg.acl']"
#      | jsonValues                                                                       |
#      | {\"users\":[\"TestSystem\",\"TestService\"],\"groups\":[\"System\",\"Service\"]} |
#
#  @MLP-4685 @MLP-5120 @regression @positive
#  Scenario:MLP-4685_MLP-5120 Verification of subtracting access information for an item
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/MLP-4685_ServiceAccess.json"
#    When user makes a REST Call for PUT request with url "accesses/BigData/BigData.Table%3A%3A%3A1" with the following query param
#      | recursive | false&operation=SUB |
#    And Status code 204 must be returned
#    Then user makes a REST Call for Get request with url "accesses/BigData/BigData.Table%3A%3A%3A1?what=asg.acl&recursive=false"
#    And response returns with the following items
#      | description | searchItems | expectedResults |
#      | Status Code |             | 200             |
#    And user compares the value from response using json path "$..['asg.acl']"
#      | jsonValues                                           |
#      | {\"users\":[\"TestSystem\"],\"groups\":[\"System\"]} |
#
#
#  @MLP-4685 @MLP-5120 @regression @positive
#  Scenario:MLP-4685_MLP-5120 Verification of deleting access information for an item
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    When user makes a REST Call for DELETE request with url "accesses/BigData/BigData.Table%3A%3A%3A1?recursive=false"
#    And Status code 204 must be returned
#    Then user makes a REST Call for Get request with url "accesses/BigData/BigData.Table%3A%3A%3A1?what=asg.acl&recursive=false"
#    And Status code 200 must be returned
#    And response message not contains value "{\"users\":[\"TestSystem\"],\"groups\":[\"System\"]}"
#
#  @MLP-4685 @MLP-5120 @regression @positive
#  Scenario: Verification of setting access information for an item with recursive true
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/MLP_4685_CreateColumn.json"
#    When user makes a REST Call for POST request with url "items/BigData/BigData.Table%3A%3A%3A1?allowUpdate=false"
#    And Status code 200 must be returned
#    And supply payload with file name "idc/MLP-4685_SystemAccess.json"
#    When user makes a REST Call for PUT request with url "accesses/BigData/BigData.Table%3A%3A%3A1?recursive=true&operation=SET"
#    And Status code 204 must be returned
#
#  @webtest @positive @regression
#  Scenario:Adding an tag to the child item
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user selects "BigData" catalog from catalog list
#    And user enters the search text "NewChildColumn" and clicks on search
#    And user selects the "Column" from the Type
#    And user click on any of the item and assign "Phone Number" tag to the item.
#    And user should be able logoff the IDC
#
#
#  @MLP-4685 @regression @positive
#  Scenario Outline: Login Scenario - To verify visibility of item after setting access for child item
#    Given user get the column "NewChildColumn" id from the following query
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | BigData    | V_Column  | ID         | name         |
#    And  user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestServiceUser" user
#    When Status code 403 must be returned
#    Then response message contains value "Access to the specified resource has been forbidden"
#
#    Examples:
#      | contentType      | acceptType       | type   | url                                                                          | endpoint                          | body                            |
#      | application/json | application/json | Get    | items/BigData/BigData.Column%3A%3A%3A                                        |                                   |                                 |
#      | application/json | application/json | Get    | components/BigData/item/BigData.Column%3A%3A%3A                              |                                   |                                 |
#      | application/json | application/json | Get    | items/BigData/BigData.Column%3A%3A%3A                                        | /env?dir=%3C-%3E&limit=0          |                                 |
#      | application/json | application/json | Post   | items/BigData/env?dir=%3C-%3E&limit=                                         |                                   | idc/TableExample.json           |
#      | application/json | application/json | Put    | items/BigData/BigData.Column%3A%3A%3A                                        |                                   | idc/TableExample.json           |
#      | application/json | application/json | Delete | items/BigData/BigData.Column%3A%3A%3A                                        |                                   |                                 |
#      | application/json | application/json | Post   | items/BigData/BigData.Column%3A%3A%3A                                        | ?allowUpdate=false                | idc/MLP-1101_Item_Creation.json |
#      | application/json | application/json | Post   | items/BigData/BigData.Column%3A%3A%3A                                        | /Test?allowUpdate=false           | idc/MLP-1101_Item_Creation.json |
#      | application/json | application/json | Get    | comments/BigData/BigData.Column%3A%3A%3A                                     |                                   |                                 |
#      | application/json | application/json | Post   | comments/BigData/BigData.Column%3A%3A%3A                                     |                                   | idc/Example.json                |
#      | application/json | application/json | Get    | comments/preview/BigData/BigData.Column%3A%3A%3A                             |                                   |                                 |
#      | application/json | application/json | Get    | ratings/BigData/BigData.Column%3A%3A%3A                                      | ?limit=10&order=date&reverse=true |                                 |
#      | application/json | application/json | Delete | ratings/BigData/BigData.Column%3A%3A%3A                                      | ?limit=10&order=date&reverse=true |                                 |
#      | application/json | application/json | Post   | ratings/BigData/BigData.Column%3A%3A%3A                                      | /1                                |                                 |
#      | application/json | application/json | Get    | recommendations/items/BigData/BigData.Column%3A%3A%3A                        |                                   |                                 |
#      | application/json | application/json | Get    | tags/BigData/assignments?items=BigData.Column%3A%3A%3A                       |                                   |                                 |
#      | application/json | application/json | Post   | searches/BigData/query/queryDiagramOut?limit                                 |                                   | idc/TableExample.json           |
#      | application/json | application/json | Get    | searches/BigData/query/solrQuery/BigData.Column%3A%3A%3A                     | ?limit=0                          |                                 |
#      | application/json | application/json | Post   | searches/BigData?query=g.V().hasLabel(%22BigData.Column%22)&what=name&limit= |                                   | idc/TableExample.json           |
#
#
#  @MLP-4685 @regression @positive
#  Scenario Outline: Login Scenario - To verify visibility of item relations for child item
#    Given user get the column "NewChildColumn" id from the following query
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | BigData    | V_Column  | ID         | name         |
#    And  user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestServiceUser" user
#    When Status code 200 must be returned
#
#    Examples:
#      | contentType      | acceptType       | type | url                                                   | endpoint | body |
#      | application/json | application/json | Get  | items/BigData/relations?srcid=BigData.Column%3A%3A%3A | &limit=0 |      |
#
#  @MLP-4685 @regression @positive
#  Scenario Outline: Login Scenario - Verification of visibility for adding comments for child
#    Given user get the column "NewChildColumn" id from the following query
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | BigData    | V_Column  | ID         | name         |
#    When user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestSystemUser" user
#    Then Status code 200 must be returned
#    Examples:
#      | contentType      | acceptType       | type | url                                      | endpoint | body                     |
#      | application/json | application/json | Post | comments/BigData/BigData.Column%3A%3A%3A |          | idc/MLP-4685_Comment.txt |
#
#  @MLP-4685 @regression @positive
#  Scenario Outline: Login Scenario - Verification of visibility for PUT comments/{catalog}/{id} for child item
#    Given user get the column "ChildComment" id from the following query
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | BigData    | V_Comment | ID         | message      |
#    When user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestServiceUser" user
#    Then Status code 403 must be returned
#    And response message contains value "Access to the specified resource has been forbidden"
#    Examples:
#      | contentType      | acceptType       | type   | url                                       | endpoint | body                     |
#      | application/json | application/json | Put    | comments/BigData/BigData.Comment%3A%3A%3A |          | idc/PlainTextExample.txt |
#      | application/json | application/json | Delete | comments/BigData/BigData.Comment%3A%3A%3A |          |                          |
#
#
#  @MLP-4685 @regression @positive
#  Scenario Outline: Login Scenario - To verify visibility giving access to items of assigned user
#    Given user get the column "ClusterTest03" id from the following query
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | BigData    | V_Cluster | ID         | name         |
#    And  user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestSystemUser" user
#    When Status code 204 must be returned
#
#    Examples:
#      | contentType      | acceptType       | type | url                                       | endpoint                       | body                           |
#      | application/json | application/json | Put  | accesses/BigData/BigData.Cluster%3A%3A%3A | ?recursive=false&operation=SET | idc/MLP-4685_SystemAccess.json |
#
#
#  @MLP-4685 @regression @positive
#  Scenario Outline: Login Scenario - To verify visibility for Put and Delete items of assigned user
#    Given user get the column "ClusterTest03" id from the following query
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | BigData    | V_Cluster | ID         | name         |
#    And  user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestSystemUser" user
#    When Status code 204 must be returned
#
#    Examples:
#      | contentType      | acceptType       | type   | url                                    | endpoint | body                            |
#      | application/json | application/json | Put    | items/BigData/BigData.Cluster%3A%3A%3A |          | idc/MLP-1101_Item_Updation.json |
#      | application/json | application/json | Delete | items/BigData/BigData.Cluster%3A%3A%3A |          |                                 |
#
#
#  @MLP-4685 @regression @positive
#  Scenario Outline: Login Scenario - To verify visibility of item searches for the child user
#    Given user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>" and body "<body>" for "TestServiceUser" user
#    When Status code 200 must be returned
#    And response message not contains value "NewChildColumn"
#    Examples:
#      | contentType      | acceptType       | type | url                                                                                                                        | body |
#      | application/json | application/json | Get  | searches/BigData/list/Column?what=name&limit=0                                                                             |      |
#      | application/json | application/json | Get  | searches/BigData?query=g.V().hasLabel(%22BigData.Column%22)&what=name&limit=0                                              |      |
#      | application/json | application/json | Post | searches/fulltext?query=%22type%22%3A%20%22Column%22&what=name&advanced=false&limit=10000&offset=0&limitFacets=10000       |      |
#      | application/json | application/json | Get  | searches/fulltext?query=%22type%22%3A%20%22Table%22&what=name&advanced=false&limit=10000&offset=0                          |      |
#      | application/json | application/json | Get  | searches/fulltext/BigData?query=%22type%22%3A%20%22Column%22&what=name&limit=10000&offset=0                                |      |
#      | application/json | application/json | Post | searches/fulltext/BigData?query=%22type%22%3A%20%22Column%22&what=name&advanced=false&limit=10000&offset=0&limitFacets=100 |      |
#      | application/json | application/json | Get  | searches/fulltext/autosuggest?input=NewChild&limit=100                                                                     |      |
#      | application/json | application/json | Get  | searches/fulltext/autosuggest/BigData?input=NewChild&limit=100                                                             |      |
#      | application/json | application/json | Get  | searches/fulltext/autosuggest/BigData/Column?input=NewChild&limit=100                                                      |      |
#      | application/json | application/json | Get  | tags/BigData/items?tags=Phone%20Number&subtags=true&limit=0&offset=0                                                       |      |
#      | application/json | application/json | Get  | tags/BigData/Phone%20Number/items?subtags=true&limit=0&offset=0                                                            |      |
#
#  @MLP-4685 @regression @positive
#  Scenario Outline: Login Scenario - To verify visibility of datasets after setting access for assigned user
#    Given user get the column "AutomationDataSet" id from the following query
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | DataSets   | V_DataSet | ID         | name         |
#    When user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestSystemUser" user
#    Then Status code 200 must be returned
#    Examples:
#      | contentType      | acceptType       | type | url                                | endpoint | body                             |
#      | application/json | application/json | Post | datasets/DataSets.DataSet%3A%3A%3A |          | idc/MLP-4685_DataSetExample.json |
#
#  @MLP-4685 @regression @positive
#  Scenario Outline: Login Scenario - To verify visibility of datasets after setting access for assigned user
#    Given user get the column "AutomationDataSet" id from the following query
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | DataSets   | V_DataSet | ID         | name         |
#    When user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestSystemUser" user
#    Then Status code 200 must be returned
#    Examples:
#      | contentType      | acceptType       | type   | url                                | endpoint                    | body                          |
#      | application/json | application/json | Get    | datasets/DataSets.DataSet%3A%3A%3A |                             |                               |
#      | application/json | application/json | Put    | datasets/DataSets.DataSet%3A%3A%3A |                             | idc/MLP-4685_DataSets.json    |
#      | application/json | application/json | Post   | datasets/DataSets.DataSet%3A%3A%3A | /notebooks                  | idc/MLP-3808_NewNotebook.json |
#      | application/json | application/json | Get    | datasets/DataSets.DataSet%3A%3A%3A | /notebooks/views            |                               |
#      | application/json | application/json | Post   | datasets/DataSets.DataSet%3A%3A%3A | /dataelements?operation=ADD | idc/MLP_4685_DataSet.json     |
#      | application/json | application/json | Delete | datasets/DataSets.DataSet%3A%3A%3A |                             |                               |
#
#
#  @MLP-4685 @regression @positive
#  Scenario Outline: Login Scenario - To verify visibility of item fulltext searches after setting access
#    Given user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>" and body "<body>" for "TestServiceUser" user
#    When Status code 200 must be returned
#    And response message not contains value "Customerspart"
#
#    Examples:
#      | contentType      | acceptType       | type | url                                                                  | body |
#      | application/json | application/json | Get  | searches/fulltext/autosuggest?input=Customerspart&limit=100               |      |
#      | application/json | application/json | Get  | searches/fulltext/autosuggest/BigData?input=Customerspart&limit=100       |      |
#      | application/json | application/json | Get  | searches/fulltext/autosuggest/BigData/Table?input=Customerspart&limit=100 |      |
#
#  @MLP-4685 @regression @positive
#  Scenario Outline: Login Scenario - To verify visibility of item fulltext searches for the assigned user
#    Given user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>" and body "<body>" for "TestSystemUser" user
#    When Status code 200 must be returned
#    And response message contains value "customerspart"
#
#    Examples:
#      | contentType      | acceptType       | type | url                                                                       | body |
#      | application/json | application/json | Get  | searches/fulltext/autosuggest?input=customerspart&limit=10000               |      |
#      | application/json | application/json | Get  | searches/fulltext/autosuggest/BigData?input=customerspart&limit=10000       |      |
#      | application/json | application/json | Get  | searches/fulltext/autosuggest/BigData/Table?input=customerspart&limit=10000 |      |
#
#  @MLP-4685 @MLP-5120 @regression @positive
#  Scenario Outline: Verification of adding access information for an item with recursive true
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/MLP-4685_ServiceAccess.json"
#    When user makes a REST Call for PUT request with url "accesses/BigData/BigData.Table%3A%3A%3A1?recursive=true&operation=ADD"
#    And Status code 204 must be returned
#    And user get the column "NewChildColumn" id from the following query
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | BigData    | V_Column  | ID         | name         |
#    And configure a new REST API for the service "IDC"
#    Then user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestSystemUser" user
#    And response returns with the following items
#      | description | searchItems | expectedResults |
#      | Status Code |             | 200             |
#    And user compares the value from response using json path "$..['asg.acl']"
#      | jsonValues                                                                       |
#      | {\"users\":[\"TestSystem\",\"TestService\"],\"groups\":[\"System\",\"Service\"]} |
#
#    Examples:
#      | contentType      | acceptType       | type | url                                      | endpoint                      | body |
#      | application/json | application/json | Get  | accesses/BigData/BigData.Column%3A%3A%3A | ?what=asg.acl&recursive=false |      |
#
#  @MLP-4685 @MLP-5120 @regression @positive
#  Scenario Outline: Verification of subtracting access information for an item with recursive true
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/MLP-4685_ServiceAccess.json"
#    When user makes a REST Call for PUT request with url "accesses/BigData/BigData.Table%3A%3A%3A1?recursive=true&operation=SUB"
#    And Status code 204 must be returned
#    And user get the column "NewChildColumn" id from the following query
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | BigData    | V_Column  | ID         | name         |
#    And configure a new REST API for the service "IDC"
#    Then user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestSystemUser" user
#    And response returns with the following items
#      | description | searchItems | expectedResults |
#      | Status Code |             | 200             |
#    And user compares the value from response using json path "$..['asg.acl']"
#      | jsonValues                                           |
#      | {\"users\":[\"TestSystem\"],\"groups\":[\"System\"]} |
#
#    Examples:
#      | contentType      | acceptType       | type | url                                      | endpoint                      | body |
#      | application/json | application/json | Get  | accesses/BigData/BigData.Column%3A%3A%3A | ?what=asg.acl&recursive=false |      |
#
#  @MLP-5120 @regression @positive
#  Scenario: Verification of getting access information for an item with recursive true
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    When user makes a REST Call for Get request with url "accesses/BigData/BigData.Table%3A%3A%3A1?what=asg.acl&recursive=true"
#    And Status code 200 must be returned
#    And user compares the value from response using json path "$.[1].['asg.acl']"
#      | jsonValues                                   |
#      | {"users":["TestSystem"],"groups":["System"]} |
#    And user compares the value from response using json path "$.[2].['asg.acl']"
#      | jsonValues                                   |
#      | {"users":["TestSystem"],"groups":["System"]} |
#
#
#  @MLP-4685 @MLP-5120 @regression @positive
#  Scenario: Verification of deleting access information for an item with recursive true
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    When user makes a REST Call for DELETE request with url "accesses/BigData/BigData.Table%3A%3A%3A1?recursive=true"
#    Then Status code 204 must be returned
#    Then user makes a REST Call for Get request with url "accesses/BigData/BigData.Table%3A%3A%3A1?what=asg.acl&recursive=false"
#    And Status code 200 must be returned
#    And response message not contains value "{\"users\":[\"TestSystem\"],\"groups\":[\"System\"]}"
#    And user get the column "NewChildColumn" id from the following query
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | BigData    | V_Column  | ID         | name         |
#    And user makes a REST Call to DELETE dataset "items/BigData/BigData.Column:::"
#
#  @MLP-4685 @MLP-5120 @regression @positive
#  Scenario: Verification of setting access information for multiple item
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/MLP-4685_MultipleItems.json"
#    When user makes a REST Call for POST request with url "accesses/BigData?recursive=false&operation=SET&acluser=TestInfo&aclgroup=Info"
#    And Status code 204 must be returned
#    Then user makes a REST Call for Get request with url "accesses/BigData/BigData.Table%3A%3A%3A4?what=asg.acl&recursive=false"
#    And response returns with the following items
#      | description | searchItems | expectedResults |
#      | Status Code |             | 200             |
#    And user compares the value from response using json path "$..['asg.acl']"
#      | jsonValues                                       |
#      | {\"users\":[\"TestInfo\"],\"groups\":[\"Info\"]} |
#    And user makes a REST Call for Get request with url "accesses/BigData/BigData.Table%3A%3A%3A5?what=asg.acl&recursive=false"
#    And response returns with the following items
#      | description | searchItems | expectedResults |
#      | Status Code |             | 200             |
#    And user compares the value from response using json path "$..['asg.acl']"
#      | jsonValues                                       |
#      | {\"users\":[\"TestInfo\"],\"groups\":[\"Info\"]} |
#
#
#  @MLP-4685 @MLP-5120 @regression @positive
#  Scenario: Verification of adding access information for multiple item
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/MLP-4685_MultipleItems.json"
#    When user makes a REST Call for POST request with url "accesses/BigData?recursive=false&operation=ADD&acluser=TestSystem&aclgroup=System"
#    And Status code 204 must be returned
#    Then user makes a REST Call for Get request with url "accesses/BigData/BigData.Table%3A%3A%3A4?what=asg.acl&recursive=false"
#    And response returns with the following items
#      | description | searchItems | expectedResults |
#      | Status Code |             | 200             |
#    And user compares the value from response using json path "$..['asg.acl']"
#      | jsonValues                                                                 |
#      | {\"users\":[\"TestInfo\",\"TestSystem\"],\"groups\":[\"Info\",\"System\"]} |
#    And user makes a REST Call for Get request with url "accesses/BigData/BigData.Table%3A%3A%3A5?what=asg.acl&recursive=false"
#    And response returns with the following items
#      | description | searchItems | expectedResults |
#      | Status Code |             | 200             |
#    And user compares the value from response using json path "$..['asg.acl']"
#      | jsonValues                                                                 |
#      | {\"users\":[\"TestInfo\",\"TestSystem\"],\"groups\":[\"Info\",\"System\"]} |
#
#
#  @MLP-4685 @MLP-5120 @regression @positive
#  Scenario: Verification of subtracting access information for multiple item
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/MLP-4685_MultipleItems.json"
#    When user makes a REST Call for POST request with url "accesses/BigData" with the following query param
#      | recursive | false&operation=SUB&acluser=TestSystem&aclgroup=System |
#    And Status code 204 must be returned
#    And configure a new REST API for the service "IDC"
#    And A query param with "" and "" and supply authorized users, contentType and Accept headers
#    Then user makes a REST Call for Get request with url "accesses/BigData/BigData.Table%3A%3A%3A4" with the following query param
#      | what | asg.acl |
#    And response returns with the following items
#      | description | searchItems | expectedResults |
#      | Status Code |             | 200             |
#    And user compares the value from response using json path "$..['asg.acl']"
#      | jsonValues                                       |
#      | {\"users\":[\"TestInfo\"],\"groups\":[\"Info\"]} |
#    Then user makes a REST Call for Get request with url "accesses/BigData/BigData.Table%3A%3A%3A5" with the following query param
#      | what | asg.acl |
#    And response returns with the following items
#      | description | searchItems | expectedResults |
#      | Status Code |             | 200             |
#    And user compares the value from response using json path "$..['asg.acl']"
#      | jsonValues                                       |
#      | {\"users\":[\"TestInfo\"],\"groups\":[\"Info\"]} |
#
#  @MLP-4685 @regression @positive
#  Scenario: Verification of getting access information for an item with what parameter
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    Then user makes a REST Call for Get request with url "accesses/BigData/BigData.Table%3A%3A%3A4?what=asg.acl&what=asg.access&recursive=false"
#    And response returns with the following items
#      | description | searchItems | expectedResults |
#      | Status Code |             | 200             |
#    And user compares the value from response using json path "$..['asg.acl']"
#      | jsonValues                                       |
#      | {\"users\":[\"TestInfo\"],\"groups\":[\"Info\"]} |
#    And user compares the value from response using json path "$..['asg.access']"
#      | jsonValues                               |
#      | {"users":["TestInfo"],"groups":["Info"]} |
#
#  @MLP-5120 @regression @positive
#  Scenario: Verification of getting access information for an item without what parameter
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    Then user makes a REST Call for Get request with url "accesses/BigData/BigData.Table%3A%3A%3A4?recursive=false"
#    And response returns with the following items
#      | description | searchItems | expectedResults |
#      | Status Code |             | 200             |
#    And response message not contains value "asg.acl"
#
#
#  @MLP-4685 @regression @positive
#  Scenario: Verification of clearing access information for multiple item
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/MLP-4685_MultipleItems.json"
#    When user makes a REST Call for POST request with url "accesses/BigData?recursive=false&operation=CLEAR&acluser=TestInfo&aclgroup=Info"
#    And Status code 204 must be returned
#    Then user makes a REST Call for Get request with url "accesses/BigData/BigData.Table%3A%3A%3A4?what=asg.acl&recursive=false"
#    And Status code 200 must be returned
#    And response message not contains value "TestInfo"
#    And user makes a REST Call for Get request with url "accesses/BigData/BigData.Table%3A%3A%3A5?what=asg.acl&recursive=false"
#    And Status code 200 must be returned
#    And response message not contains value "TestInfo"
#
#
#  @MLP-4685 @regression @positive
#  Scenario Outline: Login Scenario - Deleting items created
#    Given user get the column "NameMulti" id from the following query
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | BigData    | V_Cluster | ID         | name         |
#    And  user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestSystemUser" user
#    When Status code 204 must be returned
#
#    Examples:
#      | contentType      | acceptType       | type   | url                                    | endpoint | body |
#      | application/json | application/json | Delete | items/BigData/BigData.Cluster%3A%3A%3A |          |      |
#
#  @MLP-4685 @regression @positive
#  Scenario Outline: Login Scenario - Deleting items created
#    Given user get the column "NameMultione" id from the following query
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | BigData    | V_Cluster | ID         | name         |
#    And  user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestSystemUser" user
#    When Status code 204 must be returned
#
#    Examples:
#      | contentType      | acceptType       | type   | url                                    | endpoint | body |
#      | application/json | application/json | Delete | items/BigData/BigData.Cluster%3A%3A%3A |          |      |
#
#  @MLP-4685 @regression @positive
#  Scenario: MLP-4685 Verification of setting and getting information for an item with what parameter for few Services
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/MLP-4685_SystemAccess.json"
#    When user makes a REST Call for PUT request with url "accesses/BigData/BigData.Table%3A%3A%3A1" with the following query param
#      | recursive | true&operation=SET |
#    And Status code 204 must be returned
#    Then user makes a REST Call for Get request with url "accesses/BigData/BigData.Table%3A%3A%3A1?what=asg.acl&what=asg.access&recursive=true"
#    And Status code 200 must be returned
#    And user compares the following value from response using json path
#      | jsonValues                       | jsonPath                        |
#      | {users:TestSystem,groups:System} | $.[1].['asg.acl']               |
#      | TestSystem                       | $.[1].['asg.access'].['users']  |
#      | System                           | $.[1].['asg.access'].['groups'] |
#
#
#  @MLP-4685 @regression @positive
#  Scenario Outline: Verification of getting information for an item with what parameter for few Services
#    Given user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>" and body "<body>" for "TestSystemUser" user
#    When Status code 200 must be returned
#    And response message contains the following values
#      | responseMessage |
#      | asg.access      |
#      | asg.acl         |
#    Examples:
#      | contentType      | acceptType       | type | url                                                                                                                                  | body                        |
#      | application/json | application/json | Get  | items/BigData/BigData.Table%3A%3A%3A1?what=asg.acl&what=asg.access                                                                   |                             |
#      | application/json | application/json | Get  | items/BigData/BigData.Table%3A%3A%3A1/env?what=asg.acl&what=asg.access&dir=%3C-%3E&limit=0                                          |                             |
#      | application/json | application/json | Get  | searches/BigData/list/Table?what=asg.acl&what=asg.access&limit=0                                                                     |                             |
#      | application/json | application/json | Get  | searches/fulltext/BigData?query=type%20%3D%20Table&what=asg.acl&what=asg.access&advanced=true&limit=10000&offset=0                   |                             |
#      | application/json | application/json | Get  | searches/BigData?query=g.V().hasLabel(%27%24%7Bschema%7D.Table%27)%20&what=asg.acl&what=asg.access&limit=0                           |                             |
#      | application/json | application/json | Get  | searches/fulltext?query=type%20%3D%20Table&what=asg.acl&what=asg.access&advanced=false&limit=10000&offset=0                          |                             |
#      | application/json | application/json | Post | items/BigData?what=asg.acl&what=asg.access                                                                                           | idc/MLP-4685_TableData.json |
#      | application/json | application/json | Post | searches/BigData?query=g.V().hasLabel(%27%24%7Bschema%7D.Table%27)%20&what=asg.acl&what=asg.access&limit=0                           | idc/MLP-4685_TableData.json |
#      | application/json | application/json | Post | searches/fulltext/BigData?query=type%20%3D%20Table&what=asg.acl&what=asg.access&advanced=false&limit=10000&offset=0&limitFacets=1000 |                             |
#
#  @MLP-4685 @sanity @regression @datasets
#  Scenario: MLP-4685 Verification of visibility for GET/datasets/{id}/{fileName}/content assigned user
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
#    And configure a new REST API for the service "IDC"
#    And  To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Content-Type  | application/octet-stream               |
#      | Accept        | application/octet-stream               |
#      | Authorization | Basic VGVzdEd1ZXN0VXNlcjpHdWVzdFVzZXI= |
#    And user makes a REST Call for Get request with url "datasets/DataSets.Notebook%3A%3A%3A1/Analysis.md/content?deletetempfiles=true"
#    And Status code 403 must be returned
#    And configure a new REST API for the service "IDC"
#    And A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user makes a REST Call to DELETE dataset "datasets/DataSets.DataSet:::"
#
#
#  @MLP-4685 @regression @rating @positive
#  Scenario:MLP-4685: Verification of recommendation based on rating for Table
#    Given Delete all records in the table "E_rating"
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
#      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
#      | Content-Type  | application/json               |
#      | Accept        | application/json               |
#    When user makes a REST Call for POST request with url "ratings/BigData/BigData.Table%3A%3A%3A2/5"
#    And Status code 201 must be returned
#    And configure a new REST API for the service "IDC"
#    And A query param with "" and "" and supply authorized users, contentType and Accept headers
#    When user makes a REST Call for POST request with url "ratings/BigData/BigData.Table%3A%3A%3A2/5"
#    And Status code 201 must be returned
#    And supply payload with file name "idc/MLP-4685_GuestAccess.json"
#    When user makes a REST Call for PUT request with url "accesses/BigData/BigData.Table%3A%3A%3A2?recursive=false&operation=SET"
#    And Status code 204 must be returned
#    And configure a new REST API for the service "IDC"
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic VGVzdEd1ZXN0VXNlcjpHdWVzdFVzZXI= |
#      | Content-Type  | application/json                       |
#      | Accept        | application/json                       |
#    Then user makes a REST Call for Get request with url "recommendations/items/BigData"
#    And Status code 200 must be returned
#    And configure a new REST API for the service "IDC"
#    And A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user makes a REST Call for DELETE request with url "accesses/BigData/BigData.Table%3A%3A%3A2?recursive=false"
#    And Status code 204 must be returned
#
#  @MLP-4685 @regression @rating @positive
#  Scenario:MLP-4685: Verification of deleting accesses
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
#      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
#      | Content-Type  | application/json               |
#      | Accept        | application/json               |
#    And user makes a REST Call for DELETE request with url "accesses/BigData/BigData.Table%3A%3A%3A1" with the following query param
#      | recursive | true |
#    And Status code 204 must be returned