#@MLP-2348
#Feature: MLP-2348: Web Data coneector tableau simulation
#  Decription: The starting of simulator, connection and some data extraction can be part of automated test suite.
#  Please create a test case and add to suite. We need to ensure that web connector is not broken by any chances.
#
#  @MLP-2348 @webtest @webdataconnector @sanity @regression @positive
#  Scenario:MLP-2348: verification of Web Data Connector simulator connection
#    Given User launch browser and traverse to Web Data Connector of tableau simulator
#    When User enters the web data connector URL for tableau simulator
#    And User clicks on start interactive phase button
#    And user navigates to Authorization window and enters Admin credentials and catalog name
#    Then User should be able to see the list of tables from postgres
#
#    @MLP-2348 @webtest @webdataconnector @sanity @regression @positive
#      Scenario: MLP-2348: Verification of table content for Web Data Connector simulator connection
#      Given User launch browser and traverse to Web Data Connector of tableau simulator
#      When User enters the web data connector URL for tableau simulator
#      And User clicks on start interactive phase button
#      And user navigates to Authorization window and enters Admin credentials and catalog name
#      And User should be able to see the list of tables from postgres
#      And User clicks on fetch table data button for Database table
#      And User should be able to view the data items from the Database table
#      Then items data count from  simulator should match databases item count from postgres database
#        | description | schemaName | tableName  | columnName | criteriaName |
#        | SELECT      | BigData    | V_Database | *          |              |
#
#      @MLP-2348 @webtest @webdataconnector @sanity @regression @positive
#      Scenario: MLP-2348: Verification of table content for Web Data Connector simulator connection for Data Sample Table
#        Given User launch browser and traverse to Web Data Connector of tableau simulator
#        When User enters the web data connector URL for tableau simulator
#        And User clicks on start interactive phase button
#        And user navigates to Authorization window and enters Admin credentials and catalog name
#        And User should be able to see the list of tables from postgres
#        And User clicks on fetch table data button for Data Sample table
#        And User should be able to view the data items from the Data Sample table
#        Then items data count from  simulator should match Data Sample item count from postgres database
#          | description | schemaName | tableName    | columnName | criteriaName |
#          | SELECT      | BigData    | V_DataSample | *          |              |
#
#  @MLP-2348 @webtest @webdataconnector @sanity @regression @positive
#  Scenario: MLP-2348: Verification of table content for Web Data Connector simulator connection for Directories Table
#    Given User launch browser and traverse to Web Data Connector of tableau simulator
#    When User enters the web data connector URL for tableau simulator
#    And User clicks on start interactive phase button
#    And user navigates to Authorization window and enters Admin credentials and catalog name
#    And User should be able to see the list of tables from postgres
#    And User clicks on fetch table data button for Directory table
#    And User should be able to view the data items from the Directory table
#    Then items data count from  simulator should match Diretory item count from postgres database
#      | description | schemaName | tableName   | columnName | criteriaName |
#      | SELECT      | BigData    | V_Directory | *          |              |
#
