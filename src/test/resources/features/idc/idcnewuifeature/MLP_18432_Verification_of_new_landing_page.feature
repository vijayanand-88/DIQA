@MLP-18432
Feature:MLP-18432 : This feature is to verify Change flow in Landing screen

  ##6967252##6967253##6967254##
  @MLP-18432 @webtest @regression @positive
  Scenario: SC1#:18432: Verification of licensing button pops up when user logins for first time
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/IDx_DataSource_Credentials_Payloads/MLP-12929_SingleParam_false.json"
    When user makes a REST Call for POST request with url "settings/eula/accept"
    And Status code 204 must be returned
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user verifies "License panel" is "displayed" in "License page"
    And user "click" on "AGREE" button in "License page"
    And user verifies "Create new Business Application" is "displayed" in "Welcome page"
    And user verifies "Import Business Application via Excel file" is "displayed" in "Welcome page"
    And user "click" on "Create new Business Application" button in "Welcome page"
    Then user verifies the "Create" pop up is "displayed"

    ##6967255## ##Bug - MLP-26451
  @MLP-18432 @webtest @regression @positive
  Scenario: SC2#:18432: Verification of licensing button pops up when user logins for first time
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/IDx_DataSource_Credentials_Payloads/MLP-12929_SingleParam_false.json"
    When user makes a REST Call for POST request with url "settings/eula/accept"
    And Status code 204 must be returned
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user verifies "License panel" is "displayed" in "License page"
    And user "click" on "AGREE" button in "License page"
    And user verifies "Import Business Application via Excel file" is "displayed" in "Welcome page"
    And user "click" on "Import Business Application via Excel file" button in "Welcome page"
    Then user verifies the "Excel Importer" pop up is "displayed"
