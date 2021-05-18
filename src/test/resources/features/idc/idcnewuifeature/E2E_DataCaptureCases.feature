@e2e
Feature: This feature is to verify end to end cases of Data capture

  #7248349
  @webtest @positive @e2e
  Scenario:SC#1: Verify uploading a new bundle
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for Get request with url "/health" and store value of json path"$.version"
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Bundles" in "Landing page"
    And user "click" on "Add Bundles Button" button in "Manage Bundles page"
    And user "click" on "BROWSE FILES" button in "Add Bundle popup"
    And user upload file
      | Method         | Action          |
      | setAutoDelay   | 1000            |
      | selectOSGIFile | Osgi1-0.0.1.jar |
      | setAutoDelay   | 1000            |
      | keyPress       | CONTROL         |
      | keyPress       | V               |
      | keyRelease     | CONTROL         |
      | keyRelease     | V               |
      | setAutoDelay   | 1000            |
      | keyPress       | ENTER           |
      | keyRelease     | ENTER           |
    And user "click" on "Save" button in "Add Bundle Popup"
    And user "verifies presence" of following "Bundles list" in "Manage Bundles" page
      | com.asg.idc.Osgi1 |

    #7248353#7248356
  @webtest @positive @e2e
  Scenario:SC#2: Verify adding,editing and deleting a credential
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Credentials" in "Landing page"
    And user "click" on "Add Credentials Button in Manage Credentials Page" button in "Manage Data Source page"
    And user "select dropdown" in Add Credentials Page
      | fieldName | attribute         |
      | Type      | Username/Password |
    And user "enter text" in Add Credentials Page
      | fieldName | attribute        |
      | Name      | TestCredential11 |
    And user "enter credentials" for "GitCollectorDataSource" in "Add Credential" Page
    And user "click" on "Save" button in "Add Credential pop up"
    And user "verifies presence" of following "Credentials list" in "Manage Credentials" page
      | TestGitCredential |
    And user "click configuration menu buttons" in "Manage Credentials" Page
      | fieldName           | option           |
      | Edit the credential | TestCredential11 |
    And user "click" on "Save" button in "Edit Credential pop up"
    And user "verifies presence" of following "Credentials list" in "Manage Credentials" page
      | TestCredential11 |
    And user "click configuration menu buttons" in "Manage Credentials" Page
      | fieldName             | option           |
      | Delete the credential | TestCredential11 |
    And user "click" on "Confirm" button in "Manage Tags Page"
    And user "verifies presence" of following "Credentials list" in "Manage Credentials" page
      | TestCredential11 |
    And user makes a REST Call for DELETE request with url "settings/credentials/TestCredential11"

    #7248360 #7248360
  @webtest @positive @e2e
  Scenario:SC#3: Verify adding,editing,cloning and deleting a DataSource
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Data Sources" in "Landing page"
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Source page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute              |
      | Data Source Type | GitCollectorDataSource |
      | Credential       | Add credential         |
    And user "enter text" in Add Data Source Page
      | fieldName       | attribute                                                 |
      | Name            | AutomationQADS                                            |
      | Label           | AutomationQADS                                            |
      | URL             | https://source-team.asg.com/scm/di/pythonanalyzerdemo.git |
      | Credential Name | SampleCredential                                          |
      | User Name       | becubic_build                                             |
      | Password        | laguna-2012                                               |
    And user verifies "Save button" is "enabled" in "Add dataSourece popup"
    And user "select dropdown" in Add Data Source Page
      | fieldName | attribute |
      | Node      | LocalNode |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user "click" on "Save" button in "Add Data Source pop up"
    And user "click configuration menu buttons" in "Manage Credentials" Page
      | fieldName            | option         |
      | Edit the data source | AutomationQADS |
    And user "Verifies popup" is "displayed" for "Edit Data Source"
    And user "enter text" in Add Data Source Page
      | fieldName | attribute                                                  |
      | URL       | https://source-team.asg.com/scm/di/pythonanalyzerdemo1.git |
    And user "click" on "Save" button in "Add Data Source pop up"
    And user "verifies presence" of following "DataSource list" in "Manage Data Sources" page
      | AutomationQADS |
    And user "click configuration menu buttons" in "Manage Credentials" Page
      | fieldName             | option         |
      | Clone the data source | AutomationQADS |
    And user "Verifies popup" is "displayed" for "Clone Data Source"
    And user "click" on "Save" button in "Add Data Source pop up"
    And user "verifies presence" of following "DataSource list" in "Manage Data Sources" page
      | AutomationQADS Copy |
    And user "click configuration menu buttons" in "Manage Credentials" Page
      | fieldName              | option         |
      | Delete the data source | AutomationQADS |
    And user "click" on "Confirm" button in "Manage Tags Page"
    And user makes a REST Call for DELETE request with url "settings/analyzers/GitCollector/AutomationQADS Copy"
    And user makes a REST Call for DELETE request with url "settings/credentials/SampleCredential"
