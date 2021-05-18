@MLP-29656
Feature: MLP_29656 Verification of query items without type restriction

  #7243858#
  @MLP-29656  @regression @positive
  Scenario:SC1#: Verification of GraphQL query using type as ANY for searching items with specifying item name
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                                                                                    | body | response code | response message | jsonPath |
      | application/json |       |       | Get  | searches/Default?query=%7B%20%20Any(name%3A%22customeraddress%22)%20%7B%20name%20type%7D%20%7D&limit=0 |      | 200           |                  |          |
    Then Json response message should contains the following value
      | responseMessage            |
      | "name" : "customeraddress" |
      | "type" : "Table"           |

    #72438603#
  @MLP-29656  @regression @positive
  Scenario:SC2#: Verification of GraphQL query using type as ANY for searching items with displaying only name
    And Execute REST API with following parameters
      | Header           | Query | Param | type | url                                                | body | response code | response message | jsonPath |
      | application/json |       |       | Get  | searches/Default?query=%7BAny%7Bname%7D%7D&limit=0 |      | 200           |                  |          |
    And Json response message should contains the following value
      | responseMessage |
      | "name"          |
    And response message not contains value ""type" :"

  @MLP-29656  @regression @positive
  Scenario:SC3#: Verification of GraphQL query using type as ANY for searching items with displaying only name and type
    And Execute REST API with following parameters
      | Header           | Query | Param | type | url                                                       | body | response code | response message | jsonPath |
      | application/json |       |       | Get  | searches/Default?query=%7BAny%7Bname%20type%7D%7D&limit=0 |      | 200           |                  |          |
    And Json response message should contains the following value
      | responseMessage                |
      | "name":                        |
      | "type" : "Table"               |
      | "type" : "Column"              |
      | "type" : "Tag"                 |
      | "type" : "Directory"           |
      | "type" : "Database"            |
      | "type" : "Cluster"             |
      | "type" : "Service"             |
      | "type" : "BusinessApplication" |


      #7243972#
  @MLP-29656  @regression @positive
  Scenario:SC4#: Verification of GraphQL query with mentioning type as Table under ANY
    And Execute REST API with following parameters
      | Header           | Query | Param | type | url                                                                                          | body | response code | response message | jsonPath |
      | application/json |       |       | Get  | searches/Default?query=%7B%20%20Any(type%3A%22Table%22)%20%7B%20name%20type%7D%20%7D&limit=0 |      | 200           |                  |          |
    And Json response message should contains the following value
      | responseMessage  |
      | "name":          |
      | "type" : "Table" |
    And response message not contains value ""type" : "Column""
    And response message not contains value ""type" : "Database""

