Feature:Verification of OrcS3 Data Source Implementation
  Description: MLP-23146 - Orc S3 Data Source Implementation

  @precondition
  Scenario: MLP-23146:SC1#Update credential payload json for OrcS3
    Given User update the below "S3 Readonly credentials" in following files using json path
      | filePath                                                 | accessKeyPath | secretKeyPath |
      | ida/OrcS3Payloads/credentials/orcS3ValidCredentials.json | $..accessKey  | $..secretKey  |

  @sanity @positive
  Scenario Outline: Configure the Credentials for OrcS3Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                            | body                                                       | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/ValidOrcS3Credentials     | ida/OrcS3Payloads/Credentials/orcS3ValidCredentials.json   | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/IncorrectOrcS3Credentials | ida/OrcS3Payloads/Credentials/orcS3InvalidCredentials.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/EmptyOrcS3Credentials     | ida/OrcS3Payloads/Credentials/orcS3EmptyCredentials.json   | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/ValidOrcS3Credentials     |                                                            | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/IncorrectOrcS3Credentials |                                                            | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/EmptyOrcS3Credentials     |                                                            | 200           |                  |          |

 ##7109637##
  @positive @regression @sanity @webtest @MLP-23146
  Scenario:SC01#Verify Datasource Test Connection for the OrcS3DataSource should be successful when Valid Credentials are used
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem                                         |
      | click      | Settings Icon                                      |
      | click      | Manage Data Sources                                |
      | click      | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute       |
      | Data Source Type | OrcS3DataSource |
      | Plugin version   | LATEST          |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute       |
      | Name      | OrcS3DataSource |
      | Label     | OrcS3DataSource |
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute                 |
      | Region     | us-east-1                 |
      | Credential | ValidOrcS3Credentials |
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute |
      | Deployment | LocalNode |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And sync the test execution for "30" seconds
    And user verifies "Successful datasource connection" is "displayed" in "Add Data Sources Page"
    And user "click" on "Save" button in "Add Data Sources Page"

##7109648##
  @webtest @MLP-23146 @negative @regression
  Scenario:SC02#Verify OrcS3DataSource connection is unsuccessful when Invalid AWS credentials/Empty credentials are used.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem                                         |
      | click      | Settings Icon                                      |
      | click      | Manage Data Sources                                |
      | click      | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute             |
      | Data Source Type | OrcS3DataSource |
      | Plugin version   | LATEST                |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute                                                            |
      | Name      | OrcS3DataSource_InvalidDataSource                                          |
      | Label     | OrcS3DataSource_InvalidDataSource                                          |
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute                     |
      | Region     | us-east-1                 |
      | Credential | IncorrectOrcS3Credentials |
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute |
      | Deployment | LocalNode |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "No connection with data source - Error retrieving bucket list" is "displayed" in "Add Data Sources Page"
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute                 |
      | Credential | EmptyOrcS3Credentials |
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute |
      | Deployment | LocalNode |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "No connection with data source - Error retrieving bucket list" is "displayed" in "Add Data Sources Page"
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"



    ##7109648##
  @MLP-23146 @positive @sanity @webtest
  Scenario:SC03# Verify proper error message is shown if mandatory fields are not filled in OrcS3DataSource plugin configuration
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem                                         |
      | click      | Settings Icon                                      |
      | click      | Manage Data Sources                                |
      | click      | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute             |
      | Type      | OrcS3DataSource |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute |
      | Name      | A         |
    And user press "BACK_SPACE" key using key press event
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"



  ##7110703##
  @MLP-23146 @webtest @positive @regression @sanity
  Scenario: SC#04-Verify captions text in OrcS3DataSource
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem                                         |
      | mouse hover | Settings Icon                                      |
      | click       | Settings Icon                                      |
      | click       | Manage Data Sources                                |
      | click       | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute             |
      | Data Source Type | OrcS3DataSource |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                 |
      | Plugin version        |
      | Label                 |
      | Region*                  |
      | Credential*           |
      | Deployment*           |


  @sanity @positive @regression
  Scenario Outline: Delete Credentials,DataSource for Orc S3
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                              | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ValidOrcS3Credentials     |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/IncorrectOrcS3Credentials |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/EmptyOrcS3Credentials     |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/OrcS3DataSource     |      | 204           |                  |          |



