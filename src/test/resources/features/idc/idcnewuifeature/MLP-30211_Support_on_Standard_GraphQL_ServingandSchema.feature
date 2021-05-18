@MLP-30211
Feature:Support for standard GraphQL serving and schema

  #7268703#
  @MLP-30211 @webtest @regression @positive
  Scenario:MLP-30211:SC#1_Verify Single tags filter with Table Metadata
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "customeraddress" and clicks on search
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "customeraddress" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     | Section |
      | Click      | Add Tag Button |         |
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem | Section   |
      | Tag Selection                  | Salary     | Available |
      | Verify Tag Presence in Section | Salary     | Assigned  |
    And user "click" on "Assign" button in "Create Item Page"
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                                                                                                                    | body | response code | response message | jsonPath |
      | application/json |       |       | Get  | searches/Default?query=%7B%20Table(tags%3A%22Salary%22)%20%7B%20name%20location%20storageType%20createdBy%20inputType%7D%20%7D&limit=0 |      | 200           |                  |          |
    Then Json response message should contains the following value
      | responseMessage                                                                     |
      | "name" : "customeraddress"                                                          |
      | "location" : "/user/hive/warehouse/exportcustomeraddressdataset.db/customeraddress" |
      | "createdBy" : "root"                                                                |
      | "storageType" : "managed"                                                           |
      | "inputType" : "org.apache.hadoop.mapred.TextInputFormat"                            |
    And user enters the search text "customeraddress" and clicks on search
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "customeraddress" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     | Section |
      | Click      | Add Tag Button |         |
    And User performs following actions in the "Assign a Tag" popup
      | Actiontype                        | ActionItem | Section  |
      | Remove tagged item in the Section | Salary     | Assigned |
      | Verify Tag Absence in Section     | Salary     | Assigned |
    And user "click" on "Assign" button in "Assign a Business Application popup"

  #7268709#
  @MLP-30211 @webtest @regression @positive
  Scenario:MLP-30211:SC#2_Verify Single tags filter with Column Metadata
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "customeraddress" and clicks on search
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "address" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     | Section |
      | Click      | Add Tag Button |         |
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem | Section   |
      | Tag Selection                  | Salary     | Available |
      | Verify Tag Presence in Section | Salary     | Assigned  |
    And user "click" on "Assign" button in "Create Item Page"
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                                                                               | body | response code | response message | jsonPath |
      | application/json |       |       | Get  | searches/Default?query=%7B%20Column(tags%3A%22Salary%22)%20%7B%20name%20dataType%7D%20%7D&limit=0 |      | 200           |                  |          |
    Then Json response message should contains the following value
      | responseMessage                                                                                |
      | "dataType" : "struct<city:string,state:string,street:string,country:string,postalcode:string>" |
      | "name" : "address"                                                                             |
    And user enters the search text "customeraddress" and clicks on search
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "address" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     | Section |
      | Click      | Add Tag Button |         |
    And User performs following actions in the "Assign a Tag" popup
      | Actiontype                        | ActionItem | Section  |
      | Remove tagged item in the Section | Salary     | Assigned |
      | Verify Tag Absence in Section     | Salary     | Assigned |
    And user "click" on "Assign" button in "Assign a Business Application popup"

  #7268710#
  @MLP-30211 @webtest @regression @positive
  Scenario:MLP-30211:SC#3_Verify Single tags filter with DataType Metadata
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "struct<city:string,state:string,street:string,country:string,postalcode:string>" and clicks on search
    And user performs "facet selection" in "DataType" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "struct<city:string,state:string,street:string,country:string,postalcode:string>" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     | Section |
      | Click      | Add Tag Button |         |
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem | Section   |
      | Tag Selection                  | Salary     | Available |
      | Verify Tag Presence in Section | Salary     | Assigned  |
    And user "click" on "Assign" button in "Create Item Page"
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                                                                                           | body | response code | response message | jsonPath |
      | application/json |       |       | Get  | searches/Default?query=%7B%20DataType(tags%3A%22Salary%22)%20%7B%20name%20definition%20stage%7D%20%7D&limit=0 |      | 200           |                  |          |
    Then Json response message should contains the following value
      | responseMessage                                                                                  |
      | "name" : "struct<city:string,state:string,street:string,country:string,postalcode:string>"       |
      | "definition" : "STRUCT<city:STRING,state:STRING,street:STRING,country:STRING,postalcode:STRING>" |
      | "stage" : "BigData"                                                                              |
    And user enters the search text "struct<city:string,state:string,street:string,country:string,postalcode:string>" and clicks on search
    And user performs "facet selection" in "DataType" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "struct<city:string,state:string,street:string,country:string,postalcode:string>" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     | Section |
      | Click      | Add Tag Button |         |
    And User performs following actions in the "Assign a Tag" popup
      | Actiontype                        | ActionItem | Section  |
      | Remove tagged item in the Section | Salary     | Assigned |
      | Verify Tag Absence in Section     | Salary     | Assigned |
    And user "click" on "Assign" button in "Assign a Business Application popup"

  #7268711#
  @MLP-30211 @webtest @regression @positive
  Scenario:MLP-30211:SC#4_Verify Single tags filter with File Metadata
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "users.json" and clicks on search
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "users.json" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     | Section |
      | Click      | Add Tag Button |         |
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem      | Section   |
      | Tag Selection                  | Account balance | Available |
      | Verify Tag Presence in Section | Account balance | Assigned  |
    And user "click" on "Assign" button in "Create Item Page"
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                                                                                                                                    | body | response code | response message | jsonPath |
      | application/json |       |       | Get  | searches/Default?query=%7B%20File(tags%3A%22Account%20balance%22)%20%7B%20name%20mimeType%20fileSize%20group%20permission%20createdBy%7D%20%7D&limit=0 |      | 200           |                  |          |
    Then Json response message should contains the following value
      | responseMessage                 |
      | "fileSize" : 424                |
      | "createdBy" : "facebook"        |
      | "name" : "users.json"           |
      | "permission" : "rw-r--r--"      |
      | "mimeType" : "application/json" |
      | "group" : "facebook"            |
    And user enters the search text "users.json" and clicks on search
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "users.json" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     | Section |
      | Click      | Add Tag Button |         |
    And User performs following actions in the "Assign a Tag" popup
      | Actiontype                        | ActionItem      | Section  |
      | Remove tagged item in the Section | Account balance | Assigned |
      | Verify Tag Absence in Section     | Account balance | Assigned |
    And user "click" on "Assign" button in "Assign a Business Application popup"

  #7268712#
  @MLP-30211 @webtest @regression @positive
  Scenario:MLP-30211:SC#5_Verify Single tags filter with Directory Metadata
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "/user/hive/warehouse/exportcustomeraddressdataset.db" and clicks on search
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "/user/hive/warehouse/exportcustomeraddressdataset.db" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     | Section |
      | Click      | Add Tag Button |         |
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem | Section   |
      | Tag Selection                  | Wage       | Available |
      | Verify Tag Presence in Section | Wage       | Assigned  |
    And user "click" on "Assign" button in "Create Item Page"
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                                                                                                      | body | response code | response message | jsonPath |
      | application/json |       |       | Get  | searches/Default?query=%7B%20Directory(tags%3A%22Wage%22)%20%7B%20name%20group%20createdBy%20permission%7D%20%7D&limit=0 |      | 200           |                  |          |
    Then Json response message should contains the following value
      | responseMessage                                                 |
      | "createdBy" : "root"                                            |
      | "name" : "/user/hive/warehouse/exportcustomeraddressdataset.db" |
      | "permission" : "rwxrwxrwx"                                      |
      | "group" : "hive"                                                |
    And user enters the search text "/user/hive/warehouse/exportcustomeraddressdataset.db" and clicks on search
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "/user/hive/warehouse/exportcustomeraddressdataset.db" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     | Section |
      | Click      | Add Tag Button |         |
    And User performs following actions in the "Assign a Tag" popup
      | Actiontype                        | ActionItem | Section  |
      | Remove tagged item in the Section | Wage       | Assigned |
      | Verify Tag Absence in Section     | Wage       | Assigned |
    And user "click" on "Assign" button in "Assign a Business Application popup"

  #7268717#
  @MLP-30211 @webtest @regression @positive
  Scenario:MLP-30211:SC#6_Verify Single tags filter with Field Metadata
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "_c22" and clicks on search
    And user performs "facet selection" in "Field" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "_c22" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     | Section |
      | Click      | Add Tag Button |         |
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem | Section   |
      | Tag Selection                  | Salary     | Available |
      | Verify Tag Presence in Section | Salary     | Assigned  |
    And user "click" on "Assign" button in "Create Item Page"
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                                                                              | body | response code | response message | jsonPath |
      | application/json |       |       | Get  | searches/Default?query=%7B%20Field(tags%3A%22Salary%22)%20%7B%20name%20dataType%7D%20%7D&limit=0 |      | 200           |                  |          |
    Then Json response message should contains the following value
      | responseMessage        |
      | "dataType" : "boolean" |
      | "name" : "_c22"        |
    And user enters the search text "_c22" and clicks on search
    And user performs "facet selection" in "Field" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "_c22" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     | Section |
      | Click      | Add Tag Button |         |
    And User performs following actions in the "Assign a Tag" popup
      | Actiontype                        | ActionItem | Section  |
      | Remove tagged item in the Section | Salary     | Assigned |
      | Verify Tag Absence in Section     | Salary     | Assigned |
    And user "click" on "Assign" button in "Assign a Business Application popup"

  #7268728#
  @MLP-30211 @webtest @regression @positive
  Scenario:MLP-30211:SC#7_Verify Single tags filter with DataDomain Metadata
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Portugal" and clicks on search
    And user performs "facet selection" in "DataDomain" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Portugal" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     | Section |
      | Click      | Add Tag Button |         |
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem | Section   |
      | Tag Selection                  | Wage       | Available |
      | Verify Tag Presence in Section | Wage       | Assigned  |
    And user "click" on "Assign" button in "Create Item Page"
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                                                                              | body | response code | response message | jsonPath |
      | application/json |       |       | Get  | searches/Default?query=%7B%20DataDomain(tags%3A%22Wage%22)%20%7B%20name%20stage%7D%20%7D&limit=0 |      | 200           |                  |          |
    Then Json response message should contains the following value
      | responseMessage     |
      | "stage" : "BigData" |
      | "name" : "Portugal" |
    And user enters the search text "Portugal" and clicks on search
    And user performs "facet selection" in "DataDomain" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Portugal" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     | Section |
      | Click      | Add Tag Button |         |
    And User performs following actions in the "Assign a Tag" popup
      | Actiontype                        | ActionItem | Section  |
      | Remove tagged item in the Section | Wage       | Assigned |
      | Verify Tag Absence in Section     | Wage       | Assigned |
    And user "click" on "Assign" button in "Assign a Business Application popup"

  #7268735#
  @MLP-30211 @webtest @regression @positive
  Scenario:MLP-30211:SC#8_Verify Single tags filter with DataBase Metadata
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "exportcustomeraddressdataset" and clicks on search
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "exportcustomeraddressdataset" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     | Section |
      | Click      | Add Tag Button |         |
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem | Section   |
      | Tag Selection                  | Salary     | Available |
      | Verify Tag Presence in Section | Salary     | Assigned  |
    And user "click" on "Assign" button in "Create Item Page"
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                                                                                               | body | response code | response message | jsonPath |
      | application/json |       |       | Get  | searches/Default?query=%7B%20Database(tags%3A%22Salary%22)%20%7B%20name%20location%20storageType%7D%20%7D&limit=0 |      | 200           |                  |          |
    Then Json response message should contains the following value
      | responseMessage                                                     |
      | "name" : "exportcustomeraddressdataset"                             |
      | "storageType" : "rbd/hive"                                          |
      | "location" : "/user/hive/warehouse/exportcustomeraddressdataset.db" |
    And user enters the search text "exportcustomeraddressdataset" and clicks on search
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "exportcustomeraddressdataset" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     | Section |
      | Click      | Add Tag Button |         |
    And User performs following actions in the "Assign a Tag" popup
      | Actiontype                        | ActionItem | Section  |
      | Remove tagged item in the Section | Salary     | Assigned |
      | Verify Tag Absence in Section     | Salary     | Assigned |
    And user "click" on "Assign" button in "Assign a Business Application popup"

  #7268737#
  @MLP-30211 @webtest @regression @positive
  Scenario:MLP-30211:SC#9_Verify Single tags filter with Function Metadata
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "accountingToMarketplace" and clicks on search
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "accountingToMarketplace" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     | Section |
      | Click      | Add Tag Button |         |
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem | Section   |
      | Tag Selection                  | Salary     | Available |
      | Verify Tag Presence in Section | Salary     | Assigned  |
    And user "click" on "Assign" button in "Create Item Page"
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                                                                                               | body | response code | response message | jsonPath |
      | application/json |       |       | Get  | searches/Default?query=%7B%20Function(tags%3A%22Salary%22)%20%7B%20name%20shortName%20parameters%7D%20%7D&limit=0 |      | 200           |                  |          |
    Then Json response message should contains the following value
      | responseMessage                         |
      | "name" : "accountingToMarketplace"      |
      | "shortName" : "accountingToMarketplace" |
      | "parameters" : "[]"                     |
    And user enters the search text "accountingToMarketplace" and clicks on search
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "accountingToMarketplace" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     | Section |
      | Click      | Add Tag Button |         |
    And User performs following actions in the "Assign a Tag" popup
      | Actiontype                        | ActionItem | Section  |
      | Remove tagged item in the Section | Salary     | Assigned |
      | Verify Tag Absence in Section     | Salary     | Assigned |
    And user "click" on "Assign" button in "Assign a Business Application popup"

  #7268743#
  @MLP-30211 @webtest @regression @positive
  Scenario:MLP-30211:SC#10_Verify Single tags filter with Execution Metadata
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "test_user@1971-01-18T12:00:39Z" and clicks on search
    And user performs "facet selection" in "Execution" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "test_user@1971-01-18T12:00:39Z" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     | Section |
      | Click      | Add Tag Button |         |
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem | Section   |
      | Tag Selection                  | Salary     | Available |
      | Verify Tag Presence in Section | Salary     | Assigned  |
    And user "click" on "Assign" button in "Create Item Page"
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                                                                              | body | response code | response message | jsonPath |
      | application/json |       |       | Get  | searches/Default?query=%7B%20Execution(tags%3A%22Salary%22)%20%7B%20name%20user%7D%20%7D&limit=0 |      | 200           |                  |          |
    Then Json response message should contains the following value
      | responseMessage                           |
      | "name" : "test_user@1971-01-18T12:00:39Z" |
      | "user" : "test_user"                      |
    And user enters the search text "test_user@1971-01-18T12:00:39Z" and clicks on search
    And user performs "facet selection" in "Execution" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "test_user@1971-01-18T12:00:39Z" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     | Section |
      | Click      | Add Tag Button |         |
    And User performs following actions in the "Assign a Tag" popup
      | Actiontype                        | ActionItem | Section  |
      | Remove tagged item in the Section | Salary     | Assigned |
      | Verify Tag Absence in Section     | Salary     | Assigned |
    And user "click" on "Assign" button in "Assign a Business Application popup"

  #7268750#
  @MLP-30211 @webtest @regression @positive
  Scenario:MLP-30211:SC#11_Verify Single tags filter with Operation Metadata
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "fromsample_07pvsinsertoverwritetablesample_08select*wherepvs.sal_F73754AB6D9FB25C8BF751CB2F7DB82B" and clicks on search
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "fromsample_07pvsinsertoverwritetablesample_08select*wherepvs.sal_F73754AB6D9FB25C8BF751CB2F7DB82B" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     | Section |
      | Click      | Add Tag Button |         |
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem | Section   |
      | Tag Selection                  | Salary     | Available |
      | Verify Tag Presence in Section | Salary     | Assigned  |
    And user "click" on "Assign" button in "Create Item Page"
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                                                                                  | body | response code | response message | jsonPath |
      | application/json |       |       | Get  | searches/Default?query=%7B%20Operation(tags%3A%22Salary%22)%20%7B%20name%20mimeType%7D%20%7D&limit=0 |      | 200           |                  |          |
    Then Json response message should contains the following value
      | responseMessage                                                                                              |
      | "name" : "fromsample_07pvsinsertoverwritetablesample_08select*wherepvs.sal_F73754AB6D9FB25C8BF751CB2F7DB82B" |
      | "mimeType" : "text/hql"                                                                                      |
    And user enters the search text "fromsample_07pvsinsertoverwritetablesample_08select*wherepvs.sal_F73754AB6D9FB25C8BF751CB2F7DB82B" and clicks on search
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "fromsample_07pvsinsertoverwritetablesample_08select*wherepvs.sal_F73754AB6D9FB25C8BF751CB2F7DB82B" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     | Section |
      | Click      | Add Tag Button |         |
    And User performs following actions in the "Assign a Tag" popup
      | Actiontype                        | ActionItem | Section  |
      | Remove tagged item in the Section | Salary     | Assigned |
      | Verify Tag Absence in Section     | Salary     | Assigned |
    And user "click" on "Assign" button in "Assign a Business Application popup"

  #7268754#
  @MLP-30211 @webtest @regression @positive
  Scenario:MLP-30211:SC#12_Verify Single tags filter with Service Metadata
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "HIVE" and clicks on search
    And user performs "facet selection" in "Service" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "HIVE" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     | Section |
      | Click      | Add Tag Button |         |
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem | Section   |
      | Tag Selection                  | Salary     | Available |
      | Verify Tag Presence in Section | Salary     | Assigned  |
    And user "click" on "Assign" button in "Create Item Page"
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                                                                                             | body | response code | response message | jsonPath |
      | application/json |       |       | Get  | searches/Default?query=%7B%20Service(tags%3A%22Salary%22)%20%7B%20name%20definition%20location%7D%20%7D&limit=0 |      | 200           |                  |          |
    Then Json response message should contains the following value
      | responseMessage                                    |
      | "name" : "HIVE"                                    |
      | "definition" : "Hive data warehouse"               |
      | "location" : "hdfs://sandbox.hortonworks.com:8020" |
    And user enters the search text "HIVE" and clicks on search
    And user performs "facet selection" in "Service" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "HIVE" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     | Section |
      | Click      | Add Tag Button |         |
    And User performs following actions in the "Assign a Tag" popup
      | Actiontype                        | ActionItem | Section  |
      | Remove tagged item in the Section | Salary     | Assigned |
      | Verify Tag Absence in Section     | Salary     | Assigned |
    And user "click" on "Assign" button in "Assign a Business Application popup"

  #7268758#
  @MLP-30211 @webtest @regression @positive
  Scenario:MLP-30211:SC#13_Verify Single tags filter with Cluster Metadata
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Cluster 1" and clicks on search
    And user performs "facet selection" in "Cluster" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Cluster 1" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     | Section |
      | Click      | Add Tag Button |         |
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem | Section   |
      | Tag Selection                  | Salary     | Available |
      | Verify Tag Presence in Section | Salary     | Assigned  |
    And user "click" on "Assign" button in "Create Item Page"
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                                                                     | body | response code | response message | jsonPath |
      | application/json |       |       | Get  | searches/Default?query=%7B%20Cluster(tags%3A%22Salary%22)%20%7B%20name%7D%20%7D&limit=0 |      | 200           |                  |          |
    Then Json response message should contains the following value
      | responseMessage      |
      | "name" : "Cluster 1" |
    And user enters the search text "Cluster 1" and clicks on search
    And user performs "facet selection" in "Cluster" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Cluster 1" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     | Section |
      | Click      | Add Tag Button |         |
    And User performs following actions in the "Assign a Tag" popup
      | Actiontype                        | ActionItem | Section  |
      | Remove tagged item in the Section | Salary     | Assigned |
      | Verify Tag Absence in Section     | Salary     | Assigned |
    And user "click" on "Assign" button in "Assign a Business Application popup"

  #7268763#
  @MLP-30211 @webtest @regression @positive
  Scenario:MLP-30211:SC#14_Verify Single tags filter with DataPackage Metadata
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Cluster Demo" and clicks on search
    And user performs "facet selection" in "DataPackage" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Cluster Demo" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     | Section |
      | Click      | Add Tag Button |         |
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem | Section   |
      | Tag Selection                  | Salary     | Available |
      | Verify Tag Presence in Section | Salary     | Assigned  |
    And user "click" on "Assign" button in "Create Item Page"
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                                                                                 | body | response code | response message | jsonPath |
      | application/json |       |       | Get  | searches/Default?query=%7B%20DataPackage(tags%3A%22Salary%22)%20%7B%20name%20stage%7D%20%7D&limit=0 |      | 200           |                  |          |
    Then Json response message should contains the following value
      | responseMessage         |
      | "stage" : "BigData"     |
      | "name" : "Cluster Demo" |
    And user enters the search text "Cluster Demo" and clicks on search
    And user performs "facet selection" in "DataPackage" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Cluster Demo" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     | Section |
      | Click      | Add Tag Button |         |
    And User performs following actions in the "Assign a Tag" popup
      | Actiontype                        | ActionItem | Section  |
      | Remove tagged item in the Section | Salary     | Assigned |
      | Verify Tag Absence in Section     | Salary     | Assigned |
    And user "click" on "Assign" button in "Assign a Business Application popup"

  #7268781#
  @MLP-30211 @webtest @regression @positive
  Scenario:MLP-30211:SC#15_Verify Single tags filter with Configuration Metadata
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "hive connection" and clicks on search
    And user performs "facet selection" in "Configuration" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "hive connection" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     | Section |
      | Click      | Add Tag Button |         |
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem | Section   |
      | Tag Selection                  | Salary     | Available |
      | Verify Tag Presence in Section | Salary     | Assigned  |
    And user "click" on "Assign" button in "Create Item Page"
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                                                                                        | body | response code | response message | jsonPath |
      | application/json |       |       | Get  | searches/Default?query=%7B%20Configuration(tags%3A%22Salary%22)%20%7B%20name%20parameters%7D%20%7D&limit=0 |      | 200           |                  |          |
    Then Json response message should contains the following value
      | responseMessage                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
      | "name" : "hive connection"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
      | "parameters" : "  <configuration>          <property>       <name>ambari.hive.db.schema.name</name>       <value>hive</value>     </property>          <property>       <name>atlas.cluster.name</name>       <value>Sandbox</value>     </property>          <property>       <name>atlas.hook.hive.maxThreads</name>       <value>1</value>     </property>          <property>       <name>atlas.hook.hive.minThreads</name>       <value>1</value>     </property>          <property>       <name>atlas.rest.address</name>       <value>http://sandbox.hortonworks.com:21000</value>     </property>          <property>       <name>datanucleus.autoCreateSchema</name>       <value>false</value>     </property>          <property>       <name>datanucleus.cache.level2.type</name>       <value>none</value>     </property>          <property>       <name>datanucleus.fixedDatastore</name>       <value>true</value>     </property>          <property>       <name>hive.auto.convert.join</name>       <value>true</value>     </property>          <property>       <name>hive.auto.convert.join.noconditionaltask</name>       <value>true</value>     </property>          <property>       <name>hive.auto.convert.join.noconditionaltask.size</name>       <value>286331153</value>     </property>          <property>       <name>hive.auto.convert.sortmerge.join</name>       <value>true</value>     </property>          <property>       <name>hive.auto.convert.sortmerge.join.to.mapjoin</name>       <value>false</value>     </property>          <property>       <name>hive.cbo.enable</name>       <value>true</value>     </property>          <property>       <name>hive.cli.print.header</name>       <value>false</value>     </property>          <property>       <name>hive.cluster.delegation.token.store.class</name>       <value>org.apache.hadoop.hive.thrift.ZooKeeperTokenStore</value>     </property>          <property>       <name>hive.cluster.delegation.token.store.zookeeper.connectString</name>       <value>sandbox.hortonworks.com:2181</value>     </property>          <property>       <name>hive.cluster.delegation.token.store.zookeeper.znode</name>       <value>/hive/cluster/delegation</value>     </property>          <property>       <name>hive.compactor.abortedtxn.threshold</name>       <value>1000</value>     </property>          <property>       <name>hive.compactor.check.interval</name>       <value>300s</value>     </property>          <property>       <name>hive.compactor.delta.num.threshold</name>       <value>10</value>     </property>          <property>       <name>hive.compactor.delta.pct.threshold</name>       <value>0.1f</value>     </property>          <property>       <name>hive.compactor.initiator.on</name>       <value>true</value>     </property>          <property>       <name>hive.compactor.worker.threads</name>       <value>0</value>     </property>          <property>       <name>hive.compactor.worker.timeout</name>       <value>86400s</value>     </property>          <property>       <name>hive.compute.query.using.stats</name>       <value>true</value>     </property>          <property>       <name>hive.conf.restricted.list</name>       <value>hive.security.authenticator.manager,hive.security.authorization.manager,hive.users.in.admin.role</value>     </property>          <property>       <name>hive.convert.join.bucket.mapjoin.tez</name>       <value>false</value>     </property>          <property>       <name>hive.default.fileformat</name>       <value>TextFile</value>     </property>          <property>       <name>hive.default.fileformat.managed</name>       <value>TextFile</value>     </property>          <property>       <name>hive.enforce.bucketing</name>       <value>false</value>     </property>          <property>       <name>hive.enforce.sorting</name>       <value>true</value>     </property>          <property>       <name>hive.enforce.sortmergebucketmapjoin</name>       <value>true</value>     </property>          <property>       <name>hive.exec.compress.intermediate</name>       <value>false</value>     </property>          <property>       <name>hive.exec.compress.output</name>       <value>false</value>     </property>          <property>       <name>hive.exec.dynamic.partition</name>       <value>true</value>     </property>          <property>       <name>hive.exec.dynamic.partition.mode</name>       <value>strict</value>     </property>          <property>       <name>hive.exec.failure.hooks</name>       <value>org.apache.hadoop.hive.ql.hooks.ATSHook</value>     </property>          <property>       <name>hive.exec.max.created.files</name>       <value>100000</value>     </property>          <property>       <name>hive.exec.max.dynamic.partitions</name>       <value>5000</value>     </property>          <property>       <name>hive.exec.max.dynamic.partitions.pernode</name>       <value>2000</value>     </property>          <property>       <name>hive.exec.orc.compression.strategy</name>       <value>SPEED</value>     </property>          <property>       <name>hive.exec.orc.default.compress</name>       <value>ZLIB</value>     </property>          <property>       <name>hive.exec.orc.default.stripe.size</name>       <value>67108864</value>     </property>          <property>       <name>hive.exec.orc.encoding.strategy</name>       <value>SPEED</value>     </property>          <property>       <name>hive.exec.parallel</name>       <value>false</value>     </property>          <property>       <name>hive.exec.parallel.thread.number</name>       <value>8</value>     </property>          <property>       <name>hive.exec.post.hooks</name>       <value>org.apache.hadoop.hive.ql.hooks.ATSHook,org.apache.atlas.hive.hook.HiveHook,org.apache.atlas.hive.hook.HiveHook,com.asg.monitor.HiveHook</value>     </property>          <property>       <name>hive.exec.pre.hooks</name>       <value>org.apache.hadoop.hive.ql.hooks.ATSHook</value>     </property>          <property>       <name>hive.exec.reducers.bytes.per.reducer</name>       <value>67108864</value>     </property>          <property>       <name>hive.exec.reducers.max</name>       <value>1009</value>     </property>          <property>       <name>hive.exec.scratchdir</name>       <value>/tmp/hive</value>     </property>          <property>       <name>hive.exec.submit.local.task.via.child</name>       <value>true</value>     </property>          <property>       <name>hive.exec.submitviachild</name>       <value>false</value>     </property>          <property>       <name>hive.execution.engine</name>       <value>tez</value>     </property>          <property>       <name>hive.fetch.task.aggr</name>       <value>false</value>     </property>          <property>       <name>hive.fetch.task.conversion</name>       <value>more</value>     </property>          <property>       <name>hive.fetch.task.conversion.threshold</name>       <value>1073741824</value>     </property>          <property>       <name>hive.limit.optimize.enable</name>       <value>true</value>     </property>          <property>       <name>hive.limit.pushdown.memory.usage</name>       <value>0.04</value>     </property>          <property>       <name>hive.map.aggr</name>       <value>true</value>     </property>          <property>       <name>hive.map.aggr.hash.force.flush.memory.threshold</name>       <value>0.9</value>     </property>          <property>       <name>hive.map.aggr.hash.min.reduction</name>       <value>0.5</value>     </property>          <property>       <name>hive.map.aggr.hash.percentmemory</name>       <value>0.5</value>     </property>          <property>       <name>hive.mapjoin.bucket.cache.size</name>       <value>10000</value>     </property>          <property>       <name>hive.mapjoin.optimized.hashtable</name>       <value>true</value>     </property>          <property>       <name>hive.mapred.reduce.tasks.speculative.execution</name>       <value>false</value>     </property>          <property>       <name>hive.merge.mapfiles</name>       <value>true</value>     </property>          <property>       <name>hive.merge.mapredfiles</name>       <value>false</value>     </property>          <property>       <name>hive.merge.orcfile.stripe.level</name>       <value>true</value>     </property>          <property>       <name>hive.merge.rcfile.block.level</name>       <value>true</value>     </property>          <property>       <name>hive.merge.size.per.task</name>       <value>256000000</value>     </property>          <property>       <name>hive.merge.smallfiles.avgsize</name>       <value>16000000</value>     </property>          <property>       <name>hive.merge.tezfiles</name>       <value>false</value>     </property>          <property>       <name>hive.metastore.authorization.storage.checks</name>       <value>false</value>     </property>          <property>       <name>hive.metastore.cache.pinobjtypes</name>       <value>Table,Database,Type,FieldSchema,Order</value>     </property>          <property>       <name>hive.metastore.client.connect.retry.delay</name>       <value>5s</value>     </property>          <property>       <name>hive.metastore.client.socket.timeout</name>       <value>1800s</value>     </property>          <property>       <name>hive.metastore.connect.retries</name>       <value>24</value>     </property>          <property>       <name>hive.metastore.execute.setugi</name>       <value>true</value>     </property>          <property>       <name>hive.metastore.failure.retries</name>       <value>24</value>     </property>          <property>       <name>hive.metastore.kerberos.keytab.file</name>       <value>/etc/security/keytabs/hive.service.keytab</value>     </property>          <property>       <name>hive.metastore.kerberos.principal</name>       <value>hive/_HOST@EXAMPLE.COM</value>     </property>          <property>       <name>hive.metastore.pre.event.listeners</name>       <value>org.apache.hadoop.hive.ql.security.authorization.AuthorizationPreEventListener</value>     </property>          <property>       <name>hive.metastore.sasl.enabled</name>       <value>false</value>     </property>          <property>       <name>hive.metastore.schema.verification</name>       <value>false</value>     </property>          <property>       <name>hive.metastore.schema.verification.record.version</name>       <value>false</value>     </property>          <property>       <name>hive.metastore.server.max.threads</name>       <value>100000</value>     </property>          <property>       <name>hive.metastore.uris</name>       <value>thrift://10.33.6.152:9083</value>     </property>          <property>       <name>hive.metastore.warehouse.dir</name>       <value>/apps/hive/warehouse</value>     </property>          <property>       <name>hive.optimize.bucketmapjoin</name>       <value>true</value>     </property>          <property>       <name>hive.optimize.bucketmapjoin.sortedmerge</name>       <value>false</value>     </property>          <property>       <name>hive.optimize.constant.propagation</name>       <value>true</value>     </property>          <property>       <name>hive.optimize.index.filter</name>       <value>true</value>     </property>          <property>       <name>hive.optimize.metadataonly</name>       <value>true</value>     </property>          <property>       <name>hive.optimize.null.scan</name>       <value>true</value>     </property>          <property>       <name>hive.optimize.reducededuplication</name>       <value>true</value>     </property>          <property>       <name>hive.optimize.reducededuplication.min.reducer</name>       <value>4</value>     </property>          <property>       <name>hive.optimize.sort.dynamic.partition</name>       <value>false</value>     </property>          <property>       <name>hive.orc.compute.splits.num.threads</name>       <value>10</value>     </property>          <property>       <name>hive.orc.splits.include.file.footer</name>       <value>false</value>     </property>          <property>       <name>hive.prewarm.enabled</name>       <value>false</value>     </property>          <property>       <name>hive.prewarm.numcontainers</name>       <value>3</value>     </property>          <property>       <name>hive.security.authenticator.manager</name>       <value>org.apache.hadoop.hive.ql.security.ProxyUserAuthenticator</value>     </property>          <property>       <name>hive.security.authorization.enabled</name>       <value>true</value>     </property>          <property>       <name>hive.security.authorization.manager</name>       <value>org.apache.hadoop.hive.ql.security.authorization.plugin.sqlstd.SQLStdConfOnlyAuthorizerFactory</value>     </property>          <property>       <name>hive.security.metastore.authenticator.manager</name>       <value>org.apache.hadoop.hive.ql.security.HadoopDefaultMetastoreAuthenticator</value>     </property>          <property>       <name>hive.security.metastore.authorization.auth.reads</name>       <value>true</value>     </property>          <property>       <name>hive.security.metastore.authorization.manager</name>       <value>org.apache.hadoop.hive.ql.security.authorization.StorageBasedAuthorizationProvider</value>     </property>          <property>       <name>hive.server2.allow.user.substitution</name>       <value>true</value>     </property>          <property>       <name>hive.server2.authentication</name>       <value>NONE</value>     </property>          <property>       <name>hive.server2.authentication.spnego.keytab</name>       <value>HTTP/_HOST@EXAMPLE.COM</value>     </property>          <property>       <name>hive.server2.authentication.spnego.principal</name>       <value>/etc/security/keytabs/spnego.service.keytab</value>     </property>          <property>       <name>hive.server2.enable.doAs</name>       <value>false</value>     </property>          <property>       <name>hive.server2.logging.operation.enabled</name>       <value>true</value>     </property>          <property>       <name>hive.server2.logging.operation.log.location</name>       <value>/tmp/hive/operation_logs</value>     </property>          <property>       <name>hive.server2.max.start.attempts</name>       <value>5</value>     </property>          <property>       <name>hive.server2.support.dynamic.service.discovery</name>       <value>true</value>     </property>          <property>       <name>hive.server2.table.type.mapping</name>       <value>CLASSIC</value>     </property>          <property>       <name>hive.server2.tez.default.queues</name>       <value>default</value>     </property>          <property>       <name>hive.server2.tez.initialize.default.sessions</name>       <value>false</value>     </property>          <property>       <name>hive.server2.tez.sessions.per.default.queue</name>       <value>1</value>     </property>          <property>       <name>hive.server2.thrift.http.path</name>       <value>cliservice</value>     </property>          <property>       <name>hive.server2.thrift.http.port</name>       <value>10001</value>     </property>          <property>       <name>hive.server2.thrift.max.worker.threads</name>       <value>500</value>     </property>          <property>       <name>hive.server2.thrift.port</name>       <value>10000</value>     </property>          <property>       <name>hive.server2.thrift.sasl.qop</name>       <value>auth</value>     </property>          <property>       <name>hive.server2.transport.mode</name>       <value>binary</value>     </property>          <property>       <name>hive.server2.use.SSL</name>       <value>false</value>     </property>          <property>       <name>hive.server2.zookeeper.namespace</name>       <value>hiveserver2</value>     </property>          <property>       <name>hive.smbjoin.cache.rows</name>       <value>10000</value>     </property>          <property>       <name>hive.stats.autogather</name>       <value>true</value>     </property>          <property>       <name>hive.stats.dbclass</name>       <value>fs</value>     </property>          <property>       <name>hive.stats.fetch.column.stats</name>       <value>true</value>     </property>          <property>       <name>hive.stats.fetch.partition.stats</name>       <value>true</value>     </property>          <property>       <name>hive.support.concurrency</name>       <value>true</value>     </property>          <property>       <name>hive.tez.auto.reducer.parallelism</name>       <value>true</value>     </property>          <property>       <name>hive.tez.container.size</name>       <value>1024</value>     </property>          <property>       <name>hive.tez.cpu.vcores</name>       <value>-1</value>     </property>          <property>       <name>hive.tez.dynamic.partition.pruning</name>       <value>true</value>     </property>          <property>       <name>hive.tez.dynamic.partition.pruning.max.data.size</name>       <value>104857600</value>     </property>          <property>       <name>hive.tez.dynamic.partition.pruning.max.event.size</name>       <value>1048576</value>     </property>          <property>       <name>hive.tez.input.format</name>       <value>org.apache.hadoop.hive.ql.io.HiveInputFormat</value>     </property>          <property>       <name>hive.tez.java.opts</name>       <value>-server -Xmx200m -Djava.net.preferIPv4Stack=true</value>     </property>          <property>       <name>hive.tez.log.level</name>       <value>INFO</value>     </property>          <property>       <name>hive.tez.max.partition.factor</name>       <value>2.0</value>     </property>          <property>       <name>hive.tez.min.partition.factor</name>       <value>0.25</value>     </property>          <property>       <name>hive.tez.smb.number.waves</name>       <value>0.5</value>     </property>          <property>       <name>hive.txn.manager</name>       <value>org.apache.hadoop.hive.ql.lockmgr.DbTxnManager</value>     </property>          <property>       <name>hive.txn.max.open.batch</name>       <value>1000</value>     </property>          <property>       <name>hive.txn.timeout</name>       <value>300</value>     </property>          <property>       <name>hive.user.install.directory</name>       <value>/user/</value>     </property>          <property>       <name>hive.users.in.admin.role</name>       <value>hue,hive</value>     </property>          <property>       <name>hive.vectorized.execution.enabled</name>       <value>true</value>     </property>          <property>       <name>hive.vectorized.execution.reduce.enabled</name>       <value>false</value>     </property>          <property>       <name>hive.vectorized.groupby.checkinterval</name>       <value>4096</value>     </property>          <property>       <name>hive.vectorized.groupby.flush.percent</name>       <value>0.1</value>     </property>          <property>       <name>hive.vectorized.groupby.maxentries</name>       <value>100000</value>     </property>          <property>       <name>hive.zookeeper.client.port</name>       <value>2181</value>     </property>          <property>       <name>hive.zookeeper.namespace</name>       <value>hive_zookeeper_namespace</value>     </property>          <property>       <name>hive.zookeeper.quorum</name>       <value>sandbox.hortonworks.com:2181</value>     </property>          <property>       <name>hive_metastore_user_passwd</name>       <value>hive</value>     </property>          <property>       <name>javax.jdo.option.ConnectionDriverName</name>       <value>com.mysql.jdbc.Driver</value>     </property>          <property>       <name>javax.jdo.option.ConnectionURL</name>       <value>jdbc:mysql://10.33.6.152/hive?createDatabaseIfNotExist=true</value>     </property>          <property>       <name>javax.jdo.option.ConnectionUserName</name>       <value>root</value>     </property>        </configuration> " |
    And user enters the search text "hive connection" and clicks on search
    And user performs "facet selection" in "Configuration" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "hive connection" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     | Section |
      | Click      | Add Tag Button |         |
    And User performs following actions in the "Assign a Tag" popup
      | Actiontype                        | ActionItem | Section  |
      | Remove tagged item in the Section | Salary     | Assigned |
      | Verify Tag Absence in Section     | Salary     | Assigned |
    And user "click" on "Assign" button in "Assign a Business Application popup"

  #7268787#
  @MLP-30211 @webtest @regression @positive
  Scenario:MLP-30211:SC#16_Verify Single tags filter with Project Metadata
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "LineageDemo" and clicks on search
    And user performs "facet selection" in "Project" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "LineageDemo" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     | Section |
      | Click      | Add Tag Button |         |
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem | Section   |
      | Tag Selection                  | Salary     | Available |
      | Verify Tag Presence in Section | Salary     | Assigned  |
    And user "click" on "Assign" button in "Create Item Page"
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                                                                     | body | response code | response message | jsonPath |
      | application/json |       |       | Get  | searches/Default?query=%7B%20Project(tags%3A%22Salary%22)%20%7B%20name%7D%20%7D&limit=0 |      | 200           |                  |          |
    Then Json response message should contains the following value
      | responseMessage        |
      | "name" : "LineageDemo" |
    And user enters the search text "LineageDemo" and clicks on search
    And user performs "facet selection" in "Project" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "LineageDemo" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     | Section |
      | Click      | Add Tag Button |         |
    And User performs following actions in the "Assign a Tag" popup
      | Actiontype                        | ActionItem | Section  |
      | Remove tagged item in the Section | Salary     | Assigned |
      | Verify Tag Absence in Section     | Salary     | Assigned |
    And user "click" on "Assign" button in "Assign a Business Application popup"

  #7268791#
  @MLP-30211 @webtest @regression @positive
  Scenario:MLP-30211:SC#17_Validation on Statistics field item
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "marketplaceToLoyalty" and clicks on search
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "marketplaceToLoyalty" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     | Section |
      | Click      | Add Tag Button |         |
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem | Section   |
      | Tag Selection                  | Salary     | Available |
      | Verify Tag Presence in Section | Salary     | Assigned  |
    And user "click" on "Assign" button in "Create Item Page"
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                                                                                          | body | response code | response message | jsonPath |
      | application/json |       |       | Get  | searches/Default?query=%7B%20Function(tags%3A%22Salary%22)%20%7B%20name%20shortName%20arity%7D%20%7D&limit=0 |      | 200           |                  |          |
    Then Json response message should contains the following value
      | responseMessage                      |
      | "arity" : 0                          |
      | "name" : "marketplaceToLoyalty"      |
      | "shortName" : "marketplaceToLoyalty" |
    And user enters the search text "marketplaceToLoyalty" and clicks on search
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "marketplaceToLoyalty" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     | Section |
      | Click      | Add Tag Button |         |
    And User performs following actions in the "Assign a Tag" popup
      | Actiontype                        | ActionItem | Section  |
      | Remove tagged item in the Section | Salary     | Assigned |
      | Verify Tag Absence in Section     | Salary     | Assigned |
    And user "click" on "Assign" button in "Assign a Business Application popup"

  #7268795#
  @MLP-30211 @webtest @regression @positive
  Scenario:MLP-30211:SC#18_Multiple tags with Table Metadata
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "ice_supply" and clicks on search
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ice_supply" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     | Section |
      | Click      | Add Tag Button |         |
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem  | Section   |
      | Tag Selection                  | Salary      | Available |
      | Verify Tag Presence in Section | Salary      | Assigned  |
      | Tag Selection                  | Full Name   | Available |
      | Verify Tag Presence in Section | Full Name   | Assigned  |
      | Tag Selection                  | Middle Name | Available |
      | Verify Tag Presence in Section | Middle Name | Assigned  |
    And user "click" on "Assign" button in "Create Item Page"
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                                                                                                                                                                                              | body | response code | response message | jsonPath |
      | application/json |       |       | Get  | searches/Default?query=%7B%20Table(tags%3A%5B%22Salary%22%22Full%20Name%22%22Middle%20Name%22%5D)%20%7B%20name%20location%20storageType%20createdBy%20filesCount%20inputType%20%20asg_createdby%7D%20%7D&limit=0 |      | 200           |                  |          |
    Then Json response message should contains the following value
      | responseMessage                                          |
      | "filesCount" : 4                                         |
      | "createdBy" : "root"                                     |
      | "asg_createdby" : "Service"                              |
      | "name" : "ice_supply"                                    |
      | "storageType" : "external"                               |
      | "location" : "/user/hive/warehouse/ice_supply"           |
      | "inputType" : "org.apache.hadoop.mapred.TextInputFormat" |
    And user enters the search text "ice_supply" and clicks on search
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ice_supply" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     | Section |
      | Click      | Add Tag Button |         |
    And User performs following actions in the "Assign a Tag" popup
      | Actiontype                        | ActionItem  | Section  |
      | Remove tagged item in the Section | Salary      | Assigned |
      | Verify Tag Absence in Section     | Salary      | Assigned |
      | Remove tagged item in the Section | Full Name   | Assigned |
      | Verify Tag Absence in Section     | Full Name   | Assigned |
      | Remove tagged item in the Section | Middle Name | Assigned |
      | Verify Tag Absence in Section     | Middle Name | Assigned |
    And user "click" on "Assign" button in "Assign a Business Application popup"

  #7268800#
  @MLP-30211 @webtest @regression @positive
  Scenario:MLP-30211:SC#19_Multiple tags with Column Metadata
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "settle" and clicks on search
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "settle" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     | Section |
      | Click      | Add Tag Button |         |
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem  | Section   |
      | Tag Selection                  | Salary      | Available |
      | Verify Tag Presence in Section | Salary      | Assigned  |
      | Tag Selection                  | Full Name   | Available |
      | Verify Tag Presence in Section | Full Name   | Assigned  |
      | Tag Selection                  | Middle Name | Available |
      | Verify Tag Presence in Section | Middle Name | Assigned  |
    And user "click" on "Assign" button in "Create Item Page"
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                                                                                                                         | body | response code | response message | jsonPath |
      | application/json |       |       | Get  | searches/Default?query=%7B%20Column(tags%3A%5B%22Salary%22%22Full%20Name%22%22Middle%20Name%22%5D)%20%7B%20name%20dataType%7D%20%7D&limit=0 |      | 200           |                  |          |
    Then Json response message should contains the following value
      | responseMessage      |
      | "dataType" : "float" |
      | "name" : "settle"    |
    And user enters the search text "settle" and clicks on search
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "settle" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     | Section |
      | Click      | Add Tag Button |         |
    And User performs following actions in the "Assign a Tag" popup
      | Actiontype                        | ActionItem  | Section  |
      | Remove tagged item in the Section | Salary      | Assigned |
      | Verify Tag Absence in Section     | Salary      | Assigned |
      | Remove tagged item in the Section | Full Name   | Assigned |
      | Verify Tag Absence in Section     | Full Name   | Assigned |
      | Remove tagged item in the Section | Middle Name | Assigned |
      | Verify Tag Absence in Section     | Middle Name | Assigned |
    And user "click" on "Assign" button in "Assign a Business Application popup"

  #7268802#
  @MLP-30211 @webtest @regression @positive
  Scenario:MLP-30211:SC#20_Multiple tags with SourceTree Metadata
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "LineageTest.sql" and clicks on search
    And user performs "facet selection" in "SourceTree" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "LineageTest.sql" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     | Section |
      | Click      | Add Tag Button |         |
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem | Section   |
      | Tag Selection                  | Salary     | Available |
      | Verify Tag Presence in Section | Salary     | Assigned  |
      | Tag Selection                  | Gender     | Available |
      | Verify Tag Presence in Section | Gender     | Assigned  |
      | Tag Selection                  | Wage       | Available |
      | Verify Tag Presence in Section | Wage       | Assigned  |
    And user "click" on "Assign" button in "Create Item Page"
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                                                                                                                             | body | response code | response message | jsonPath |
      | application/json |       |       | Get  | searches/Default?query=%7B%20SourceTree(tags%3A%5B%22Salary%22%22Gender%22%22Wage%22%5D)%20%7B%20importCount%20unresolvedCount%7D%20%7D&limit=0 |      | 200           |                  |          |
    Then Json response message should contains the following value
      | responseMessage       |
      | "unresolvedCount" : 4 |
      | "importCount" : 0     |
    And user enters the search text "LineageTest.sql" and clicks on search
    And user performs "facet selection" in "SourceTree" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "LineageTest.sql" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     | Section |
      | Click      | Add Tag Button |         |
    And User performs following actions in the "Assign a Tag" popup
      | Actiontype                        | ActionItem | Section  |
      | Remove tagged item in the Section | Salary     | Assigned |
      | Verify Tag Absence in Section     | Salary     | Assigned |
      | Remove tagged item in the Section | Gender     | Assigned |
      | Verify Tag Absence in Section     | Gender     | Assigned |
      | Remove tagged item in the Section | Wage       | Assigned |
      | Verify Tag Absence in Section     | Wage       | Assigned |
    And user "click" on "Assign" button in "Assign a Business Application popup"

  #7268803#
  @MLP-30211 @webtest @regression @positive
  Scenario:MLP-30211:SC#21_Multiple tags with field Metadata
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "_c22" and clicks on search
    And user performs "facet selection" in "Field" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "_c22" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     | Section |
      | Click      | Add Tag Button |         |
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem  | Section   |
      | Tag Selection                  | Salary      | Available |
      | Verify Tag Presence in Section | Salary      | Assigned  |
      | Tag Selection                  | Full Name   | Available |
      | Verify Tag Presence in Section | Full Name   | Assigned  |
      | Tag Selection                  | Middle Name | Available |
      | Verify Tag Presence in Section | Middle Name | Assigned  |
    And user "click" on "Assign" button in "Create Item Page"
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                                                                                                                                                                                                    | body | response code | response message | jsonPath |
      | application/json |       |       | Get  | searches/Default?query=%7B%20Field(tags%3A%5B%22Salary%22%22Full%20Name%22%22Middle%20Name%22%5D)%20%7B%20name%20dataType%20maxValue%20minValue%20notNullPercentage%20uniqueAmount%20uniquePercentage%7D%20%7D&limit=0 |      | 200           |                  |          |
    Then Json response message should contains the following value
      | responseMessage           |
      | "uniquePercentage" : 8    |
      | "minValue" : "false"      |
      | "maxValue" : "true"       |
      | "dataType" : "boolean"    |
      | "name" : "_c22"           |
      | "uniqueAmount" : 2        |
      | "notNullPercentage" : 100 |
    And user enters the search text "_c22" and clicks on search
    And user performs "facet selection" in "Field" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "_c22" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     | Section |
      | Click      | Add Tag Button |         |
    And User performs following actions in the "Assign a Tag" popup
      | Actiontype                        | ActionItem  | Section  |
      | Remove tagged item in the Section | Salary      | Assigned |
      | Verify Tag Absence in Section     | Salary      | Assigned |
      | Remove tagged item in the Section | Full Name   | Assigned |
      | Verify Tag Absence in Section     | Full Name   | Assigned |
      | Remove tagged item in the Section | Middle Name | Assigned |
      | Verify Tag Absence in Section     | Middle Name | Assigned |
    And user "click" on "Assign" button in "Assign a Business Application popup"