@MLP-14171
Feature:MLP-14171: As a admin user i should see the list of data sources and list of credentials

  ##6832641##
  @MLP-14171 @regression @positive @webtest
  Scenario:MLP-14171: Verification of GET service for Manage Data Sources and Manage Credentials
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "settings/analyzers/GitCollectorDataSource/SampleDataSource"
    And user makes a REST Call for DELETE request with url "settings/credentials/SampleCredential"
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Source page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute              |
      | Data Source Type | GitCollectorDataSource |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute                                                 |
      | Name      | SampleDataSource                                          |
      | Label     | SampleDataSource                                          |
      | URL       | https://source-team.asg.com/scm/di/pythonanalyzerdemo.git |
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute      |
      | Credential | Add credential |
    And user "enter text" in Add Data Source Page
      | fieldName       | attribute        |
      | Credential Name | SampleCredential |
    And user "enter credentials" for "GitCollectorDataSource" in "Add Data Source" Page
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute |
      | Deployment | LocalNode |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user "click" on "Save" button in "Add Data Sources pop up"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for Get request with url "settings/analyzers/plugins?plugintype=datasource"
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues | jsonPath                                          |
      | datasource | $..['GitCollectorDataSource'][-1:].['pluginType'] |
    And user makes a REST Call for Get request with url "settings/credentials?credentialtype=basic"
    And Status code 200 must be returned
    And response message contains value "SampleCredential"