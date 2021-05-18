@MLP-12926 @MLP-12929 @MLP-26136 @MLP-16993
Feature:MLP-12926: This feature is to verify whether as an IDA Admin at first login to have the default view of all my administration functions so that I can rapidly configure for processing
  MLP-12929 As an IDA Admin, I want a licensing button to popup at 1st login so that I can ensure that I am covered under my prescribed EULA and the install for my products (ID*) will not continue unless accepted

  ##6780292##6780294##6780295##6780299##6780300##
  @MLP-12926 @MLP-12929 @webtest @regression @positive
  Scenario: SC1#:MLP-12926_MLP-12929: Verification of licensing button pops up when user logins for first time
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/IDx_DataSource_Credentials_Payloads/MLP-12929_SingleParam_false.json"
    When user makes a REST Call for POST request with url "settings/eula/accept"
    And Status code 204 must be returned
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user verifies "License panel" is "displayed" in "License page"
    And user "click" on "EXIT" button in "License page"
    And logout must be success and display login page
    When user enter credentials for "System Administrator1" role
    And user verifies "License panel" is "displayed" in "License page"
    And user "click" on "AGREE" button in "License page"
    And user performs following actions in the sidebar
      | actionType         | actionItem       |
      | verifies displayed | Settings Icon    |
    And user verifies "Welcome message under settings icon" is "displayed" in "Welcome page"

  ##7161511##7161515##7161523##7161525##7161526##7161746##7161527##
  @MLP-26136 @webtest @regression @positive
  Scenario:SC2#:MLP-26136: Verification of licensing button pops up when user logins for first time
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "verify presence" on "Sidebar Link" for "Capture and Import Data Icon" in "Landing page"
    And user "click" on "Capture And Import Data Icon" button in "Landing page"
    And user verifies "Capture and Import Data page" is "displayed"
    And user "verify sidebar menu items" of following "Data Capture" in "Landing" page
      | Manage Configurations |
      | Manage Pipelines      |
      | Manage Credentials    |
      | Manage Data Sources   |
      | Manage Bundles        |
    And user "verify presence" on "Capture and Import Data Link" for "Excel Importer" in "Landing page"
    And user "click" on "Sidebar Link" for "Admin" in "Landing page"
    And user "verify absence of sidebar menu items" of following "Data Capture" in "Landing" page
      | Manage Configurations |
      | Manage Pipelines      |
      | Manage Credentials    |
      | Manage Data Sources   |
      | Manage Bundles        |
    And user "click" on "Capture and Import Data Link" for "Manage Pipelines" in "Landing page"
    And user "verifies presence" of following "Landed page Title is Bold" in "" page
      | Manage Pipelines |
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user "verifies presence" of following "Landed page Title is Bold" in "" page
      | Manage Configurations |
    And user "click" on "Capture and Import Data Link" for "Manage Credentials" in "Landing page"
    And user "verifies presence" of following "Landed page Title is Bold" in "" page
      | Manage Credentials |
    And user "click" on "Capture and Import Data Link" for "Manage Bundles" in "Landing page"
    And user "verifies presence" of following "Landed page Title is Bold" in "" page
      | Manage Bundles |
    And user "click" on "Capture and Import Data Link" for "Manage Data Sources" in "Landing page"
    And user "verifies presence" of following "Landed page Title is Bold" in "" page
      | Manage Data Sources |

      ##6910114##
  @MLP-16993 @webtest @regression @positive
  Scenario:SC#1:MLP-16993: To verify the "Beta" word is added to next to Data intelligence  application
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user verifies "BETA" is "displayed" in "Welcome page"
