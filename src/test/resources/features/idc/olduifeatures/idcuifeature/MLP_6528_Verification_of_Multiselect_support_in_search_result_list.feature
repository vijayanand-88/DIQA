@MLP-6528
Feature: MLP-6528 Verification of Multiselection support in the search result list

  @webtest @MLP-6528 @positive @UI-DataSet @regression
  Scenario: MLP-6528 Verification of My Access column
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user selects the "BigData" from the Catalog
    And user selects the "Business Glossary" from the Catalog
    And user verifies Header menu button is disabled
      | buttonName           |
      | Assign/Unassign Tags |

  @webtest @MLP-6528 @positive @UI-DataSet @regression
  Scenario: MLP-6528 Verification of selecting a multiple items in a different page
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
#    And user enters the search text "customers" and clicks on search
    And user selects the "DataDomain" from the Type
    And user enable first item checkbox from item search results
    And user clicks on next button in the pagination
    And user enable first item checkbox from item search results
    And user creates a dataset with name "SaleDataSets" and description "Sale Dataset description"
    And user clicks on home button
    When user clicks On DataSet Dashboard And navigates to The "SALEDATASETS" Dataset "Data" Tab
    And user "click" on "Header checkbox" button
    And user "click" on "Order List"
    And user "verify displayed" for "2ITEMS REQUESTED FOR ACCESS" in the ORDER LIST panel
    And user get the ID for data set "SaleDataSets" from below query
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | DataSets   | V_DataSet | ID         | name         |
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call to DELETE "datasets/DataSets.DataSet:::"

  @webtest @MLP-6528 @positive @UI-DataSet @regression
  Scenario: MLP-6528 Verification of Select All checkbox for items count < 2500
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user verifies the items count is "less than" "2500" in search view
    And user "verify displayed" for "select All checkbox" in search view

#  @webtest @MLP-6528 @positive @UI-DataSet @regression
#  Scenario: MLP-6528 Verification of retaining the selection
#    Given user deletes primary key constraint for deleting tag "QAAUTOMATION TAG"
#    And user deletes the created tag "QAAUTOMATION TAG"
#    When User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user selects "BigData" catalog from catalog list
#    And user enters the search text "customers" and clicks on search
#    And user selects the "DataDomain" from the Type
#    And user enable first item checkbox from item search results
#    And user clicks on next button in the pagination
#    And user enable first item checkbox from item search results
#    And user assigns new tag to the selected Item
#    And user refreshes the application
#    And user checks the child checkbox "QAAUTOMATION TAG" in Tags
#    Then user verifies "2" items found

#  @webtest @MLP-6528 @positive @UI-DataSet @regression
#  Scenario: MLP-6528 Verification of Uploading JDBC-9.8.0-jar-with-dependencies jar
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Content-Type  | multipart/form-data                |
#      | Accept        | application/json                   |
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#    When user makes a REST Call for DELETE request with url "extensions/bundles/Analysis/com.asg.dis.analysis.JDBC"
#    And user attaches/upload file "pluginbundle/JDBC-9.9.0-20190301.062850-33-jar-with-dependencies.jar" to request
#    And user makes a REST Call for POST request with url "extensions/bundles"
#    And Status code 200 must be returned
#    Then "com.asg.dis.analysis.JDBC-9.9.0.SNAPSHOT" osgi bundle should be uploaded to bundle table
#      | description | schemaName | tableName | columnName | criteriaName | firstColName | secColName |
#      | SELECT      | public     | V_Bundle  | *          | name,version | version      | plugins    |

  @webtest @MLP-6528 @positive @UI-DataSet @regression
  Scenario: MLP-6528 Verification of Uploading Oracle jar
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When user makes a REST Call for DELETE request with url "extensions/bundles/JDBC/oracle.jdbc.OracleDriver"
    And user attaches/upload file "ojdbc7-12.1.0.2.jar" to request from the repository "com\oracle\jdbc\ojdbc7\12.1.0.2\" location
    When user makes a REST Call for POST request with url "extensions/bundles"
    And Status code 200 must be returned
    Then "oracle.jdbc.OracleDriver-12.1.0.2-0" osgi bundle should be uploaded to bundle table
      | description | schemaName | tableName | columnName | criteriaName | firstColName | secColName |
      | SELECT      | public     | V_Bundle  | *          | name,version | version      | plugins    |

  @webtest @MLP-6528 @positive @regression @pluginManager
  Scenario: MLP-6528  Verification of plugin configuration for Oracle jar in JDBC Cataloger
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Administration" dashboard
    And User "click" on "CATALOG MANAGER" link on the Dashboard page
    And user creates a catalog with name "Oracle" and save it in Catalog manager page
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
    And supply payload with file name "/idc/new_JDBC_Cataloger_Configuration.json"
    When user makes a REST Call for PUT request with url "settings/analyzers/JDBCCataloger" with the following query param
      | raw | false |
    And Status code 204 must be returned
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                            | body | response code | response message |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JDBCCataloger/JDBCCataloger |      | 200           | IDLE             |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                                                                           | body | response code | response message |
      |        |       |       | Post | extensions/analyzers/start/InternalNode/cataloger/JDBCCataloger/JDBCCataloger |      | 200           |                  |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                            | body | response code | response message |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JDBCCataloger/JDBCCataloger |      | 200           | IDLE             |

  @webtest @MLP-6528 @positive @UI-DataSet @regression
  Scenario: MLP-6528 Verification of run button for item types from Oracle database other than Table and column
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "Oracle" catalog from catalog list
    And user selects the "Schema" from the Type
    And user enable first item checkbox from item search results
    And user clicks on next button in the pagination
    And user enable first item checkbox from item search results
    And user creates a dataset with name "NonTableItems" and description "NonTableItems description"
    And user clicks on search icon
    And user selects the "Database" from the Type
    And user enable first item checkbox from item search results
    And user assigns "NonTableItems" dataset from the Assign data set panel
    And user clicks on home button
    When user clicks On DataSet Dashboard And navigates to The "NONTABLEITEMS" Dataset "Data" Tab
    And user "click" on "Header checkbox" button
    And user "click" on "Run button" in notebook
    And user "verify not displayed" for "Run button" for "TableauConnector" under Run Dataset actions panel
    And user get the ID for data set "NonTableItems" from below query
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | DataSets   | V_DataSet | ID         | name         |
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call to DELETE "datasets/DataSets.DataSet:::"

  @webtest @MLP-6528 @positive @UI-DataSet @regression
  Scenario: MLP-6528 Verification of select All checkbox
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user selects "Oracle" catalog from catalog list
    And user "click" for "select All checkbox" in search view
    And user creates a dataset with name "TestDataSets1" and description "Test Dataset description"
    And user clicks on home button
    When user clicks On DataSet Dashboard And navigates to The "TESTDATASETS1" Dataset "Data" Tab
    And user "click" on "Header checkbox" button
    And user "click" on "Order List"
    And user "verify displayed" for "1600ITEMS REQUESTED FOR ACCESS" in the ORDER LIST panel
    And user get the ID for data set "TestDataSets1" from below query
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | DataSets   | V_DataSet | ID         | name         |
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call to DELETE "datasets/DataSets.DataSet:::"

  @webtest @MLP-6528 @positive @UI-DataSet @regression
  Scenario: MLP-6528 Verification of select All checkbox for item count > 2500
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "All" catalog from catalog list
    And user verifies the items count is "greater than" "2500" in search view
    And user "verify not displayed" for "select All checkbox" in search view

  @webtest @MLP-6528 @positive @UI-DataSet @regression
  Scenario: MLP-6528 Verification of Select All check box with a facet option for items result < 2500
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "Oracle" catalog from catalog list
    And user selects the "Table" from the Type
    And user verifies the items count is "less than" "2500" in search view
    And user "verify displayed" for "select All checkbox" in search view

  @webtest @MLP-6528 @positive @UI-DataSet @regression
  Scenario: MLP-6528 Verification of Select All check box with a facet option for items result > 2500
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "All" catalog from catalog list
    And user selects the "Column" from the Type
    And user selects the "Table" from the Type
    And user selects the "File" from the Type
    And user verifies the items count is "greater than" "2500" in search view
    And user "verify not displayed" for "select All checkbox" in search view

  @webtest @MLP-6528 @positive @UI-DataSet @regression
  Scenario: MLP-6528 Verification of deleting the uploaded bundle from the bundle type
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for DELETE request with url "extensions/bundles/Analysis/com.asg.dis.analysis.JDBC"
    And Status code 204 must be returned
    And user makes a REST Call for DELETE request with url "settings/catalogs/Oracle?deleteData=true"
    Then Status code 204 must be returned
