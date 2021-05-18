@MLP-14658
Feature:MLP-14658: This feature is to verify  Add Filter in manage credentials and data source page

  ##6832651##6832652##6832654##6832655##6832656##6832657##7248362
  @MLP-14658 @webtest @regression @positive @e2e
  Scenario:SC#1:MLP-14658 : Add Filter in data source page
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                     | body                                                                          | response code | response message | jsonPath | endpointType | itemName |
      | application/json | raw   | false | Delete | settings/analyzers/GitCollectorDataSource/TestGitDS1    |                                                                               |               |                  |          |              |          |
      |                  |       |       | Delete | settings/analyzers/GitCollectorDataSource/TestGitDS     |                                                                               |               |                  |          |              |          |
      |                  |       |       | Delete | settings/analyzers/PostgreSQLDBCataloger/TestPostgresDS |                                                                               |               |                  |          |              |          |
      |                  |       |       | Put    | settings/analyzers/GitCollectorDataSource/TestGitDS     | idc/IDx_DataSource_Credentials_Payloads/MLP-14658_GitCollectorDS_Config.json  | 204           |                  |          |              |          |
      |                  |       |       | Put    | settings/analyzers/GitCollectorDataSource/TestGitDS1    | idc/IDx_DataSource_Credentials_Payloads/MLP-14658_GitCollectorDS1_Config.json | 204           |                  |          |              |          |
      |                  |       |       | Put    | settings/analyzers/PostgreSQLDBCataloger/TestPostgresDS | idc/IDx_DataSource_Credentials_Payloads/MLP-14658_PostgresDS_Config.json      | 204           |                  |          |              |          |
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Data Sources" in "Landing page"
    And user "click" on "Filter Icon" button in "Manage Data Sources Page"
    And user "select DS filter dropdown" in "Manage DataSource popup"
      | fieldName | actionItem             |
      | Type      | GitCollectorDataSource |
    And user "verifies presence" of following "DataSource list" in "Manage DataSource" page
      | TestGitDS  |
      | TestGitDS1 |
    And user "verifies presence" of following "DataSource all are same" in "Manage DataSource" page
      | GitCollectorDataSource |
    And user "select DS filter dropdown" in "Manage DataSource popup"
      | fieldName | actionItem            |
      | Type      | PostgreSQLDBCataloger |
    And user "verifies presence" of following "DataSource list" in "Manage DataSource" page
      | TestPostgresDS |
    And user "select DS filter dropdown" in "Manage DataSource popup"
      | fieldName | actionItem |
      | Type      | All        |
    And user "verifies presence" of following "DataSource list" in "Manage DataSource" page
      | TestGitDS      |
      | TestGitDS1     |
      | TestPostgresDS |
    And user refreshes the application
    And user "verifies sorting order" of following "Data sources are in decending order" in "Manage DataSource" page
      |  |
    And user "click" on "Sort Icon" button in "Manage Data Sources Page for Data Source"
    And user "verifies sorting order" of following "Data sources are in ascending order" in "Manage DataSource" page
      |  |

    ##6832651##6832652##6832654##6832655##6832656##6832657##7248358
  @MLP-14658 @webtest @regression @positive @e2e
  Scenario:SC#2:MLP-14658 : Add Filter in Credentials page
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                      | body                                                                                       | response code | response message | jsonPath | endpointType | itemName |
      | application/json | raw   | false | Delete | settings/credentials/TestGitCredential                   |                                                                                            |               |                  |          |              |          |
      |                  |       |       | Delete | settings/credentials/TestGitCredential1                  |                                                                                            |               |                  |          |              |          |
      |                  |       |       | Delete | settings/credentials/TestCredential_AWS                  |                                                                                            |               |                  |          |              |          |
      |                  |       |       | Put    | settings/credentials/TestGitCredential                   | idc/IDx_DataSource_Credentials_Payloads/MLP-14658_Username_Pasword_Credential_Config.json  | 200           |                  |          |              |          |
      |                  |       |       | Put    | settings/credentials/TestGitCredential1                  | idc/IDx_DataSource_Credentials_Payloads/MLP-14658_Username_Pasword1_Credential_Config.json | 200           |                  |          |              |          |
      |                  |       |       | Put    | settings/credentials/TestCredential_AWS?allowUpdate=true | idc/IDx_DataSource_Credentials_Payloads/MLP-14658_AWS_Credential_Config.json               | 200           |                  |          |              |          |
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Credentials" in "Landing page"
    And user "click" on "Filter Icon" button in "Manage Data Sources Page"
    And user "select DS filter dropdown" in "Manage Credentials popup"
      | fieldName | actionItem        |
      | Type      | Username/Password |
    And user "verifies presence" of following "Credentials list" in "Manage Credentials" page
      | TestGitCredential |
    And user "verifies presence" of following "Credentials all are same" in "Manage Credentials" page
      | Username/Password |
    And user "select DS filter dropdown" in "Manage Credentials popup"
      | fieldName | actionItem |
      | Type      | AWS        |
    And user "verifies presence" of following "Credentials list" in "Manage Credentials" page
      | TestCredential_AWS |
    And user "select DS filter dropdown" in "Manage Credentials popup"
      | fieldName | actionItem |
      | Type      | All        |
    And user "verifies presence" of following "Credentials list" in "Manage Credentials" page
      | TestGitCredential  |
      | TestCredential_AWS |
    And user refreshes the application
    And user "verifies sorting order" of following "Credentials are in decending order" in "Manage DataSource" page
      |  |
    And user "click" on "Sort Icon" button in "Manage Credentials Page for Data Source"
    And user "verifies sorting order" of following "Credentials are in ascending order" in "Manage DataSource" page
      |  |

    @e2e
  Scenario:Delete the plugin configs
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                     | body | response code | response message | jsonPath | endpointType | itemName |
      | application/json | raw   | false | Delete | settings/analyzers/GitCollectorDataSource/TestGitDS1    |      |               |                  |          |              |          |
      |                  |       |       | Delete | settings/analyzers/GitCollectorDataSource/TestGitDS     |      |               |                  |          |              |          |
      |                  |       |       | Delete | settings/analyzers/PostgreSQLDBCataloger/TestPostgresDS |      |               |                  |          |              |          |
      |                  |       |       | Delete | settings/credentials/TestGitCredential                  |      |               |                  |          |              |          |
      |                  |       |       | Delete | settings/credentials/TestGitCredential1                 |      |               |                  |          |              |          |
      |                  |       |       | Delete | settings/credentials/TestCredential_AWS                 |      |               |                  |          |              |          |