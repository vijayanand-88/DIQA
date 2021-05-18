@MLP-12926 @MLP-12926
Feature:MLP-12926: This feature is to verify whether as an IDA Admin at first login to have the default view of all my administration functions so that I can rapidly configure for processing
  MLP-12929 As an IDA Admin, I want a licensing button to popup at 1st login so that I can ensure that I am covered under my prescribed EULA and the install for my products (ID*) will not continue unless accepted

  ##6780296##6780297##
  @MLP-12929 @regression @positive
  Scenario:MLP-12929: Verification of Configuration and Service calls to check whether covered under EULA
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/IDx_DataSource_Credentials_Payloads/MLP-12929_SingleParam_false.json"
    When user makes a REST Call for POST request with url "settings/eula/accept"
    And Status code 204 must be returned
    When user makes a REST Call for Get request with url "settings/eula"
    Then Status code 200 must be returned
    And response message contains value "This is a sample eulaText"
    And supply payload with file name "idc/IDx_DataSource_Credentials_Payloads/MLP-12929_SingleParam_true.json"
    When user makes a REST Call for POST request with url "settings/eula/accept"
    And Status code 204 must be returned
    When user makes a REST Call for Get request with url "settings/eula"
    Then Status code 200 must be returned
    And response message contains value ""

    ##6780301##
  @MLP-12926 @regression @positive
  Scenario:MLP-12926: Verification of Configuration and Service calls to check whether covered under EULA
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    When supply payload with file name "idc/IDx_DataSource_Credentials_Payloads/MLP-12926_LandingPage.json"
    And user makes a REST Call for PUT request with url "settings/landing?role=SYSTEM_ADMIN"
    And Status code 200 must be returned
    And user makes a REST Call for Get request with url "settings/landing?role=SYSTEM_ADMIN"
    And Status code 200 must be returned
    And response of user groups should match with "idc/IDx_DataSource_Credentials_Payloads/MLP-12926_LandingPage.json"
    And user makes a REST Call for DELETE request with url "settings/landing?role=SYSTEM_ADMIN"
    And Status code 200 must be returned
    And response of user groups should match with "idc/IDx_DataSource_Credentials_Payloads/MLP-12926_LandingPage.json"
    And supply payload with file name "idc/IDx_DataSource_Credentials_Payloads/MLP-12926_Default_LandingPage.json"
    And user makes a REST Call for PUT request with url "settings/landing?role=SYSTEM_ADMIN"
    And Status code 200 must be returned
    And user makes a REST Call for Get request with url "settings/landing?role=SYSTEM_ADMIN"
    And Status code 200 must be returned
    And response of user groups should match with "idc/IDx_DataSource_Credentials_Payloads/MLP-12926_Default_LandingPage.json"
