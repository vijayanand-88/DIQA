@MLP-4609
Feature:MLP-4609: cloudera_LineageCases

  @MLP-4609 @positive @regression @cloudera
  Scenario Outline: SC1#-Set the Credentials and DataSource for CNavigator
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                             | body                                                               | response code | response message     | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/ClouderaValidCredentials   | ida/cloudEraNavigatorPayloads/Credentials/Valid.json               | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/ClouderaInValidCredentials | ida/cloudEraNavigatorPayloads/Credentials/Invalid.json             | 200           |                      |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/CNavigatorDataSource         | ida/cloudEraNavigatorPayloads/DataSource/CNavigatorDataSource.json | 204           |                      |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/CNavigatorDataSource         |                                                                    | 200           | CNavigatorDataSource |          |

  @MLP-4610 @positive @regression @cloudera
  Scenario Outline:4609-SC1#-config the CNavigator plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                    | body                                                  | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CNavigatorCataloger | ida/cloudEraNavigatorPayloads/CloudEra_4609_Hive.json | 204           |                  |          |

  ##6035585##
  @MLP-4609 @webtest @positive @regression @cloudera
  Scenario:SC#1_MLP_4609_Verify the lineage appearing in cloudEraNavigator matches with IDC UI lineage for Hive operations(simple select query)
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                           | body | response code | response message | jsonPath                                       |
      | application/json |       |       | Get          | settings/analyzers/CNavigatorCataloger                                        |      | 200           | HiveQuery        |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HiveQuery |      | 200           | IDLE             | $.[?(@.configurationName=='HiveQuery')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                   | body | response code | response message | jsonPath                                       |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/HiveQuery  |      | 200           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/HiveQuery |      | 200           | IDLE             | $.[?(@.configurationName=='HiveQuery')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN4609SC1" and clicks on search
    And user performs "facet selection" in "CN4609SC1" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Database  |
      | Table     |
      | Column    |
      | Operation |
      | Execution |
      | Analysis  |
      | Service   |
      | Cluster   |
    And user enters the search text "select * from testlineage.lineagetable1_2195668" and clicks on search
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "select * from testlineage.lineagetable1_2195668" item from search results
    Then user performs click and verify in new window
      | Table              | value                                  | Action                 | RetainPrevwindow | indexSwitch |
      | Lineage Hops       | lineagetable1.address => VIEW/LOCAL    | verify widget contains |                  |             |
      | Lineage Hops       | lineagetable1.age => VIEW/LOCAL        | verify widget contains |                  |             |
      | Lineage Hops       | lineagetable1.name => VIEW/LOCAL       | verify widget contains |                  |             |
      | uses               | address                                | verify widget contains |                  |             |
      | uses               | age                                    | verify widget contains |                  |             |
      | uses               | name                                   | verify widget contains |                  |             |
      | Runtime Executions | select * from testlineage.lineagetable | verify widget contains |                  |             |
    And user clicks on logout button

##6036178##
  @webtest @MLP-4609 @positive @regression @cloudera
  Scenario:SC#2_Verify the lineage appearing in cloudEraNavigator matches with IDC UI lineage for Hive operations(create table from another table)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "aaa" and clicks on search
    And user performs "facet selection" in "CN4609SC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "aaa" item from search results
    Then user performs click and verify in new window
      | Table   | value | Action                 | RetainPrevwindow | indexSwitch |
      | Columns | col_1 | verify widget contains |                  |             |
      | Columns | col_2 | verify widget contains |                  |             |
    And user enters the search text "create table testlineage.aaa as select * from testli..._2200502" and clicks on search
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "create table testlineage.aaa as select * from testli..._2200502" item from search results
    Then user performs click and verify in new window
      | Table              | value                                             | Action                 | RetainPrevwindow | indexSwitch |
      | Lineage Hops       | INPUT => aaa.col_1                                | verify widget contains |                  |             |
      | Lineage Hops       | INPUT => aaa.col_2                                | verify widget contains |                  |             |
      | uses               | col_1                                             | verify widget contains |                  |             |
      | uses               | col_2                                             | verify widget contains |                  |             |
      | Runtime Executions | create table testlineage.aaa as select * from tes | verify widget contains |                  |             |
    And user clicks on logout button

    ##6037875##
  @webtest @MLP-4609 @positive @regression @cloudera
  Scenario:SC#3_Verify the lineage appearing in cloudEraNavigator matches with IDC UI lineage for Hive operations(insert into table)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "lineagetable1" and clicks on search
    And user performs "facet selection" in "CN4609SC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "lineagetable1" item from search results
    Then user performs click and verify in new window
      | Table   | value   | Action                 | RetainPrevwindow | indexSwitch |
      | Columns | name    | verify widget contains |                  |             |
      | Columns | age     | verify widget contains |                  |             |
      | Columns | address | verify widget contains |                  |             |
    And user enters the search text "insert into table testlineage.lineagetable1 values('..._2195663" and clicks on search
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "insert into table testlineage.lineagetable1 values('..._2195663" item from search results
    Then user performs click and verify in new window
      | Table              | value                                              | Action                 | RetainPrevwindow | indexSwitch |
      | Lineage Hops       | INPUT => lineagetable1.address                     | verify widget contains |                  |             |
      | Lineage Hops       | INPUT => lineagetable1.age                         | verify widget contains |                  |             |
      | Lineage Hops       | INPUT => lineagetable1.name                        | verify widget contains |                  |             |
      | uses               | address                                            | verify widget contains |                  |             |
      | uses               | age                                                | verify widget contains |                  |             |
      | uses               | name                                               | verify widget contains |                  |             |
      | Runtime Executions | insert into table testlineage.lineagetable1 values | verify widget contains |                  |             |
      | Runtime Executions | insert into table testlineage.lineagetable1 values | verify widget contains |                  |             |
    And user clicks on logout button

##6039055##
  @webtest @MLP-4609 @positive @regression @cloudera
  Scenario:SC#4_Verify the lineage appearing in cloudEraNavigator matches with IDC UI lineage for Hive operations(insert overwrite table partition query)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "pageviews" and clicks on search
    And user performs "facet selection" in "CN4609SC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "pageviews" item from search results
    Then user performs click and verify in new window
      | Table   | value     | Action                 | RetainPrevwindow | indexSwitch |
      | Columns | userid    | verify widget contains |                  |             |
      | Columns | link      | verify widget contains |                  |             |
      | Columns | came_from | verify widget contains |                  |             |
    And user enters the search text "insert overwrite table testlineage.pageviews partiti..._2563786" and clicks on search
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "insert overwrite table testlineage.pageviews partiti..._2563786" item from search results
    Then user performs click and verify in new window
      | Table        | value                                           | Action                 | RetainPrevwindow | indexSwitch |
      | Lineage Hops | pageviewsource.came_from => pageviews.came_from | verify widget contains |                  |             |
      | Lineage Hops | pageviewsource.link => pageviews.link           | verify widget contains |                  |             |
      | Lineage Hops | pageviewsource.userid => pageviews.userid       | verify widget contains |                  |             |
    Then user performs click and verify in new window
      | Table        | value                                           | Action                       | RetainPrevwindow | indexSwitch | filePath                                                      | jsonPath   |
      | Lineage Hops | pageviewsource.came_from => pageviews.came_from | click and verify lineagehops | Yes              | 0           | ida/cloudEraNavigatorPayloads/DataSource/lineageMetadata.json | $.QATest8  |
      | Lineage Hops | pageviewsource.link => pageviews.link           | click and verify lineagehops | Yes              | 0           | ida/cloudEraNavigatorPayloads/DataSource/lineageMetadata.json | $.QATest9  |
      | Lineage Hops | pageviewsource.userid => pageviews.userid       | click and verify lineagehops | Yes              | 0           | ida/cloudEraNavigatorPayloads/DataSource/lineageMetadata.json | $.QATest10 |
    And user clicks on logout button

    ##6038516##
  @webtest @MLP-4609 @positive @regression @cloudera
  Scenario:SC#5_Verify the lineage appearing in cloudEraNavigator matches with IDC UI lineage for Hive operations(create table if not exists testlineage1.tblres as select * from testlineage.lineagetable1 where name = 'name3';)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tblres" and clicks on search
    And user performs "facet selection" in "CN4609SC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "tblres" item from search results
    Then user performs click and verify in new window
      | Table   | value   | Action                 | RetainPrevwindow | indexSwitch |
      | Columns | name    | verify widget contains |                  |             |
      | Columns | age     | verify widget contains |                  |             |
      | Columns | address | verify widget contains |                  |             |
    And user enters the search text "create table if not exists testlineage1.tblres as se..._2200515" and clicks on search
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "create table if not exists testlineage1.tblres as se..._2200515" item from search results
    Then user performs click and verify in new window
      | Table        | value                                   | Action                 | RetainPrevwindow | indexSwitch |
      | Lineage Hops | lineagetable1.address => tblres.address | verify widget contains |                  |             |
      | Lineage Hops | lineagetable1.age => tblres.age         | verify widget contains |                  |             |
      | Lineage Hops | lineagetable1.name => tblres.name       | verify widget contains |                  |             |
    Then user performs click and verify in new window
      | Table        | value                                   | Action                       | RetainPrevwindow | indexSwitch | filePath                                                      | jsonPath   |
      | Lineage Hops | lineagetable1.address => tblres.address | click and verify lineagehops | Yes              | 0           | ida/cloudEraNavigatorPayloads/DataSource/lineageMetadata.json | $.QATest11 |
      | Lineage Hops | lineagetable1.age => tblres.age         | click and verify lineagehops | Yes              | 0           | ida/cloudEraNavigatorPayloads/DataSource/lineageMetadata.json | $.QATest12 |
      | Lineage Hops | lineagetable1.name => tblres.name       | click and verify lineagehops | Yes              | 0           | ida/cloudEraNavigatorPayloads/DataSource/lineageMetadata.json | $.QATest13 |
    And user clicks on logout button

       ##6038494##
  @webtest @MLP-4609 @positive @regression @cloudera
  Scenario:SC#6_Verify the lineage appearing in cloudEraNavigator matches with IDC UI lineage for Hive operations(create table from multiple tables)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CREATE TABLE testlineage.to_tbl as SELECT col_1,col_..._2198435" and clicks on search
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "CREATE TABLE testlineage.to_tbl as SELECT col_1,col_..._2198435" item from search results
    Then user performs click and verify in new window
      | Table        | value                    | Action                 | RetainPrevwindow | indexSwitch |
      | Lineage Hops | tab1.col_1 => VIEW/LOCAL | verify widget contains |                  |             |
      | Lineage Hops | tab1.col_2 => VIEW/LOCAL | verify widget contains |                  |             |
      | Lineage Hops | tab2.col_1 => VIEW/LOCAL | verify widget contains |                  |             |
      | Lineage Hops | tab2.col_2 => VIEW/LOCAL | verify widget contains |                  |             |
    And user clicks on logout button

    ##6036046##
  @webtest @MLP-4609 @positive @regression @cloudera
  Scenario:SC#7_MLP-4609_Verify the cloudEraNavigator metadata attributes matches with IDC UI metadata attributes for Impala operations
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                  | body | response code | response message | jsonPath                                              |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/ImpalaOperations |      | 200           | IDLE             | $.[?(@.configurationName=='ImpalaOperations')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                          | body | response code | response message | jsonPath                                              |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/ImpalaOperations  |      | 200           |                  |                                                       |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/ImpalaOperations |      | 200           | IDLE             | $.[?(@.configurationName=='ImpalaOperations')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN4609SC7" and clicks on search
    And user performs "facet selection" in "CN4609SC7" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                                                          | Feature           | jsonPath        |
      | /entities?query=((sourceType:impala)AND(type:operation)AND(originalName:*testdatabase1*)) | CloudEraNavigator | $..originalName |
    And user clicks on logout button

  ##6036129##
  @webtest @MLP-4609 @positive @regression @cloudera
  Scenario:SC#8_MLP-4609_Verify the cloudEraNavigator metadata attributes matches with IDC UI metadata attributes for Impala execution
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN4609SC7" and clicks on search
    And user performs "facet selection" in "CN4609SC7" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Execution" attribute under "Metadata Type" facets in Item Search results page
    Then user compare list of Search results present in Search page and List present in CloudEra API
      | RESTAPI Endpoint                                                                                    | Feature           | jsonPath        |
      | /entities?query=((sourceType:impala)AND(type:operation_execution)AND(originalName:*testdatabase1*)) | CloudEraNavigator | $..originalName |
    And user clicks on logout button

##6039063##
  @webtest @MLP-4609 @positive @regression @cloudera
  Scenario:SC#9_MLP-4609_Verify the lineage appearing in cloudEraNavigator matches with IDC UI lineage for Impala operations(simple select query)
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                             | body | response code | response message | jsonPath                                         |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/ImpalaQuery |      | 200           | IDLE             | $.[?(@.configurationName=='ImpalaQuery')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                     | body | response code | response message | jsonPath                                         |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/ImpalaQuery  |      | 200           |                  |                                                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/ImpalaQuery |      | 200           | IDLE             | $.[?(@.configurationName=='ImpalaQuery')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN4609SC9" and clicks on search
    And user performs "facet selection" in "CN4609SC9" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "select * from default.employee where (id_col = ?) li..._9956118" item from search results
    Then user performs click and verify in new window
      | Table              | value                                    | Action                 | RetainPrevwindow | indexSwitch |
      | Lineage Hops       | employee.id => VIEW/LOCAL                | verify widget contains |                  |             |
      | Lineage Hops       | employee.id_col => VIEW/LOCAL            | verify widget contains |                  |             |
      | Lineage Hops       | employee.name => VIEW/LOCAL              | verify widget contains |                  |             |
      | Lineage Hops       | employee.salary => VIEW/LOCAL            | verify widget contains |                  |             |
      | Lineage Hops       | employee.year_join => VIEW/LOCAL         | verify widget contains |                  |             |
      | Runtime Executions | select * from default.employee where (id | verify widget contains |                  |             |
    And user clicks on logout button

##6039077##
  @webtest @MLP-4609 @positive @regression @cloudera
  Scenario:SC#10_MLP-4609_Verify the lineage appearing in cloudEraNavigator matches with IDC UI lineage for Impala operations(insert into table)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN4609SC9" and clicks on search
    And user performs "facet selection" in "CN4609SC9" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "insert into default.parquet_table select CAST(id as ..._3805547" item from search results
    Then user performs click and verify in new window
      | Table        | value                            | Action                 | RetainPrevwindow | indexSwitch |
      | Lineage Hops | employee.id => parquet_table.x   | verify widget contains |                  |             |
      | Lineage Hops | employee.name => parquet_table.y | verify widget contains |                  |             |
    Then user performs click and verify in new window
      | Table        | value                            | Action                       | RetainPrevwindow | indexSwitch | filePath                                                      | jsonPath   |
      | Lineage Hops | employee.id => parquet_table.x   | click and verify lineagehops | Yes              | 0           | ida/cloudEraNavigatorPayloads/DataSource/lineageMetadata.json | $.QATest14 |
      | Lineage Hops | employee.name => parquet_table.y | click and verify lineagehops | Yes              | 0           | ida/cloudEraNavigatorPayloads/DataSource/lineageMetadata.json | $.QATest15 |
    And user clicks on logout button

##6039066##
  @webtest @MLP-4609 @positive @regression @cloudera
  Scenario:SC#11_MLP-4609_Verify the lineage appearing in cloudEraNavigator matches with IDC UI lineage for Impala operations(create table from another table)
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                   | body | response code | response message | jsonPath                                               |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/ImpalaCreateQuery |      | 200           | IDLE             | $.[?(@.configurationName=='ImpalaCreateQuery')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                           | body | response code | response message | jsonPath                                               |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/ImpalaCreateQuery  |      | 200           |                  |                                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/ImpalaCreateQuery |      | 200           | IDLE             | $.[?(@.configurationName=='ImpalaCreateQuery')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN4609SC11" and clicks on search
    And user performs "facet selection" in "CN4609SC11" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "create table testlineage.aaa as select * from testli..._2337283" item from search results
    Then user performs click and verify in new window
      | Table              | value                                    | Action                 | RetainPrevwindow | indexSwitch |
      | Lineage Hops       | INPUT => aaa.col_1                       | verify widget contains |                  |             |
      | Lineage Hops       | INPUT => aaa.col_2                       | verify widget contains |                  |             |
      | Runtime Executions | create table testlineage.aaa as select * | verify widget contains |                  |             |
      | uses               | col_1                                    | verify widget contains |                  |             |
      | uses               | col_2                                    | verify widget contains |                  |             |


    ##6039080##
  @webtest @MLP-4609 @positive @regression @cloudera
  Scenario:SC#12_MLP-4609_Verify the lineage appearing in cloudEraNavigator matches with IDC UI lineage for Impala operations(create table from multiple tables)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN4609SC11" and clicks on search
    And user performs "facet selection" in "CN4609SC11" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "CREATE TABLE testlineage.to_tbl as SELECT col_1,col_..._2337279" item from search results
    Then user performs click and verify in new window
      | Table        | value                    | Action                 | RetainPrevwindow | indexSwitch |
      | Lineage Hops | tab1.col_1 => VIEW/LOCAL | verify widget contains |                  |             |
      | Lineage Hops | tab1.col_2 => VIEW/LOCAL | verify widget contains |                  |             |
      | Lineage Hops | tab2.col_1 => VIEW/LOCAL | verify widget contains |                  |             |
      | Lineage Hops | tab2.col_2 => VIEW/LOCAL | verify widget contains |                  |             |
    And user clicks on logout button

##6039091##
  @webtest @MLP-4609 @positive @regression @cloudera
  Scenario:SC#13_MLP-4609_Verify the lineage appearing in cloudEraNavigator matches with IDC UI lineage for Impala operations(create table if not exists testlineage1.tblres as select * from testlineage.lineagetable1 where name = 'name3';))
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN4609SC11" and clicks on search
    And user performs "facet selection" in "CN4609SC11" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "create table if not exists testlineage1.tblres as se..._2503004" item from search results
    Then user performs click and verify in new window
      | Table        | value                                   | Action                 | RetainPrevwindow | indexSwitch |
      | Lineage Hops | lineagetable1.address => tblres.address | verify widget contains |                  |             |
      | Lineage Hops | lineagetable1.age => tblres.age         | verify widget contains |                  |             |
      | Lineage Hops | lineagetable1.name => tblres.name       | verify widget contains |                  |             |
    Then user performs click and verify in new window
      | Table        | value                                   | Action                       | RetainPrevwindow | indexSwitch | filePath                                                      | jsonPath   |
      | Lineage Hops | lineagetable1.address => tblres.address | click and verify lineagehops | Yes              | 0           | ida/cloudEraNavigatorPayloads/DataSource/lineageMetadata.json | $.QATest11 |
      | Lineage Hops | lineagetable1.age => tblres.age         | click and verify lineagehops | Yes              | 0           | ida/cloudEraNavigatorPayloads/DataSource/lineageMetadata.json | $.QATest12 |
      | Lineage Hops | lineagetable1.name => tblres.name       | click and verify lineagehops | Yes              | 0           | ida/cloudEraNavigatorPayloads/DataSource/lineageMetadata.json | $.QATest13 |
    And user clicks on logout button


    ##6039098##
  @webtest @MLP-4609 @positive @regression @cloudera
  Scenario:SC#14_MLP-4609_Verify the lineage appearing in cloudEraNavigator matches with IDC UI lineage for Impala operations(insert overwrite table query)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN4609SC11" and clicks on search
    And user performs "facet selection" in "CN4609SC11" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "INSERT OVERWRITE table testlineage1.some_table SELEC..._2574065" item from search results
    Then user performs click and verify in new window
      | Table        | value                                | Action                 | RetainPrevwindow | indexSwitch |
      | Lineage Hops | table2.address => some_table.address | verify widget contains |                  |             |
      | Lineage Hops | table2.age => some_table.age         | verify widget contains |                  |             |
      | Lineage Hops | table2.empno => some_table.empno     | verify widget contains |                  |             |
      | Lineage Hops | table2.name => some_table.name       | verify widget contains |                  |             |
    Then user performs click and verify in new window
      | Table        | value                                | Action                       | RetainPrevwindow | indexSwitch | filePath                                                      | jsonPath   |
      | Lineage Hops | table2.address => some_table.address | click and verify lineagehops | Yes              | 0           | ida/cloudEraNavigatorPayloads/DataSource/lineageMetadata.json | $.QATest11 |
      | Lineage Hops | table2.age => some_table.age         | click and verify lineagehops | Yes              | 0           | ida/cloudEraNavigatorPayloads/DataSource/lineageMetadata.json | $.QATest12 |
      | Lineage Hops | table2.empno => some_table.empno     | click and verify lineagehops | Yes              | 0           | ida/cloudEraNavigatorPayloads/DataSource/lineageMetadata.json | $.QATest16 |
      | Lineage Hops | table2.name => some_table.name       | click and verify lineagehops | Yes              | 0           | ida/cloudEraNavigatorPayloads/DataSource/lineageMetadata.json | $.QATest13 |
    And user clicks on logout button


    ##6039099##
  @webtest @MLP-4609 @positive @regression @cloudera
  Scenario:SC#15_MLP-4609_Verify the lineage appearing in cloudEraNavigator matches with IDC UI lineage for Impala operations(insert overwrite table partition query)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN4609SC11" and clicks on search
    And user performs "facet selection" in "CN4609SC11" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "insert overwrite table testlineage.pageviews partiti..._2563780" item from search results
    Then user performs click and verify in new window
      | Table        | value                                           | Action                 | RetainPrevwindow | indexSwitch |
      | Lineage Hops | INPUT => pageviews.datestamp                    | verify widget contains |                  |             |
      | Lineage Hops | pageviewsource.came_from => pageviews.came_from | verify widget contains |                  |             |
      | Lineage Hops | pageviewsource.link => pageviews.link           | verify widget contains |                  |             |
      | Lineage Hops | pageviewsource.userid => pageviews.userid       | verify widget contains |                  |             |
    Then user performs click and verify in new window
      | Table        | value                                           | Action                       | RetainPrevwindow | indexSwitch | filePath                                                      | jsonPath   |
      | Lineage Hops | pageviewsource.came_from => pageviews.came_from | click and verify lineagehops | Yes              | 0           | ida/cloudEraNavigatorPayloads/DataSource/lineageMetadata.json | $.QATest8  |
      | Lineage Hops | pageviewsource.link => pageviews.link           | click and verify lineagehops | Yes              | 0           | ida/cloudEraNavigatorPayloads/DataSource/lineageMetadata.json | $.QATest9  |
      | Lineage Hops | pageviewsource.userid => pageviews.userid       | click and verify lineagehops | Yes              | 0           | ida/cloudEraNavigatorPayloads/DataSource/lineageMetadata.json | $.QATest10 |
    And user clicks on logout button

     ##6039096##
  @webtest @MLP-4609 @positive @regression @cloudera
  Scenario:SC#16_MLP-4609_Verify the lineage appearing in cloudEraNavigator matches with IDC UI lineage for Impala operations(select join query)
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                 | body | response code | response message | jsonPath                                             |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/ImpalaJoinQuery |      | 200           | IDLE             | $.[?(@.configurationName=='ImpalaJoinQuery')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                         | body | response code | response message | jsonPath                                             |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/ImpalaJoinQuery  |      | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/ImpalaJoinQuery |      | 200           | IDLE             | $.[?(@.configurationName=='ImpalaJoinQuery')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN4609SC16" and clicks on search
    And user performs "facet selection" in "CN4609SC16" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "select * from testdatabase1.employee e join testdata..._2339180" item from search results
    Then user performs click and verify in new window
      | Table        | value                             | Action                 | RetainPrevwindow | indexSwitch |
      | Lineage Hops | department.deptid => VIEW/LOCAL   | verify widget contains |                  |             |
      | Lineage Hops | department.deptname => VIEW/LOCAL | verify widget contains |                  |             |
      | Lineage Hops | department.empid => VIEW/LOCAL    | verify widget contains |                  |             |
      | Lineage Hops | employee.age => VIEW/LOCAL        | verify widget contains |                  |             |
      | Lineage Hops | employee.empid => VIEW/LOCAL      | verify widget contains |                  |             |
      | Lineage Hops | employee.name => VIEW/LOCAL       | verify widget contains |                  |             |
      | Lineage Hops | finance.deptid => VIEW/LOCAL      | verify widget contains |                  |             |
      | Lineage Hops | finance.financeid => VIEW/LOCAL   | verify widget contains |                  |             |
      | Lineage Hops | finance.financename => VIEW/LOCAL | verify widget contains |                  |             |
      | Lineage Hops | payroll.financeid => VIEW/LOCAL   | verify widget contains |                  |             |
      | Lineage Hops | payroll.payrollid => VIEW/LOCAL   | verify widget contains |                  |             |
      | Lineage Hops | payroll.payrollname => VIEW/LOCAL | verify widget contains |                  |             |
      | Lineage Hops | salary.payrollid => VIEW/LOCAL    | verify widget contains |                  |             |
      | Lineage Hops | salary.salary => VIEW/LOCAL       | verify widget contains |                  |             |
      | Lineage Hops | salary.salaryid => VIEW/LOCAL     | verify widget contains |                  |             |
    And user clicks on logout button

       ##6038521##
  @webtest @MLP-4609 @positive @regression @cloudera
  Scenario:SC#17_MLP-4609_Verify the lineage appearing in cloudEraNavigator matches with IDC UI lineage for Hive operations(select join query)
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                               | body | response code | response message | jsonPath                                           |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HiveJoinQuery |      | 200           | IDLE             | $.[?(@.configurationName=='HiveJoinQuery')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                       | body | response code | response message | jsonPath                                           |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/HiveJoinQuery  |      | 200           |                  |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/HiveJoinQuery |      | 200           | IDLE             | $.[?(@.configurationName=='HiveJoinQuery')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN4609SC17" and clicks on search
    And user performs "facet selection" in "CN4609SC17" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Type" section in item search results page
      | Database  |
      | Table     |
      | Column    |
      | Operation |
      | Execution |
      | Analysis  |
      | Service   |
      | Cluster   |
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "select * from testdatabase1.employee e join testdata..._1235403" item from search results
    Then user performs click and verify in new window
      | Table        | value                             | Action                 | RetainPrevwindow | indexSwitch |
      | Lineage Hops | department.deptid => VIEW/LOCAL   | verify widget contains |                  |             |
      | Lineage Hops | department.deptname => VIEW/LOCAL | verify widget contains |                  |             |
      | Lineage Hops | department.empid => VIEW/LOCAL    | verify widget contains |                  |             |
      | Lineage Hops | employee.age => VIEW/LOCAL        | verify widget contains |                  |             |
      | Lineage Hops | employee.empid => VIEW/LOCAL      | verify widget contains |                  |             |
      | Lineage Hops | employee.name => VIEW/LOCAL       | verify widget contains |                  |             |
    And user clicks on logout button

     ##6038972##
  @webtest @MLP-4609 @positive @regression @cloudera
  Scenario:SC#18_MLP-4609_Verify the lineage appearing in cloudEraNavigator matches with IDC UI lineage for Hive operations(insert overwrite table query)
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                    | body | response code | response message | jsonPath                                                |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HiveOverwriteQuery |      | 200           | IDLE             | $.[?(@.configurationName=='HiveOverwriteQuery')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                            | body | response code | response message | jsonPath                                                |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/HiveOverwriteQuery  |      | 200           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/HiveOverwriteQuery |      | 200           | IDLE             | $.[?(@.configurationName=='HiveOverwriteQuery')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "insert overwrite directory '?' select * from default..._1731068" and clicks on search
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "insert overwrite directory '?' select * from default..._1731068" item from search results
    Then user performs click and verify in new window
      | Table        | value                            | Action                 | RetainPrevwindow | indexSwitch |
      | Lineage Hops | employee.id => VIEW/LOCAL        | verify widget contains |                  |             |
      | Lineage Hops | employee.id_col => VIEW/LOCAL    | verify widget contains |                  |             |
      | Lineage Hops | employee.name => VIEW/LOCAL      | verify widget contains |                  |             |
      | Lineage Hops | employee.salary => VIEW/LOCAL    | verify widget contains |                  |             |
      | Lineage Hops | employee.year_join => VIEW/LOCAL | verify widget contains |                  |             |
    And user clicks on logout button

  @MLP-4609 @positive @regression @cloudera
  Scenario Outline: SC19-Delete the Credentials and Data Sources
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                             | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ClouderaValidCredentials   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ClouderaInValidCredentials |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CNavigatorDataSource         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CNavigatorCataloger          |      | 204           |                  |          |

  @MLP-4441 @sanity @positive
  Scenario:4609_SC#20:Delete cluster id
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | SingleItemDelete | Default | Cloudera QuickStart            | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/CNavigatorCataloger% | Analysis |       |       |