@MLP-15294
Feature:MLP-15294: This feature is to verify SAVE - As an IDA Admin, I was to be able save search

  ##6862104##6868611##6868845##6868846##6862103##6862105##6862106##6862107##6862108##6867801##6867802##
  @MLP-15294 @sanity @regression @quicklink @positive
  Scenario: Verification of getting searches that are specific to user including both private and public searches
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/IDX_Save_Search_Payloads/MLP-15294_testSearch_public.json"
    When user makes a REST Call for POST request with url "quicklinks?publiclink=true"
    Then Status code 200 must be returned
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/IDX_Save_Search_Payloads/MLP-15294_testSearch_private.json"
    And user makes a REST Call for POST request with url "quicklinks?publiclink=false"
    Then Status code 200 must be returned
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for Get request with url "quicklinks?publiclink=false"
    And user verifies whether the value is present in response using json path "$..['name']"
      | jsonValues        |
      | TestPrivateSearch |
      | TestPublicSearch  |

  ##6862109##6867805##6867806##
  @MLP-15294 @sanity @regression @quicklink @positive
  Scenario: Verification of updating a public search
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes REST call for Get "quicklinks?publiclink=true" and retrieves value from using jsonpath "*[?(@.name=='TestPublicSearch')].id"
    And supply payload with file name "idc/IDX_Save_Search_Payloads/MLP-15294_update_testSearch_public.json"
    When user makes a REST Call for "PUT" request with url "quicklinks/storedText?publiclink=true" and path ""
    Then Status code 204 must be returned
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for Get request with url "quicklinks?publiclink=false"
    And user verifies whether the value is present in response using json path "$..['name']"
      | jsonValues        |
      | TestPublicSearch1 |

  ##6862110##
  @MLP-15294 @sanity @regression @quicklink @positive
  Scenario: Verification of updating a search that is specific to a user
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes REST call for Get "quicklinks?publiclink=false" and retrieves value from using jsonpath "*[?(@.name=='TestPrivateSearch')].id"
    And supply payload with file name "idc/IDX_Save_Search_Payloads/MLP-15294_update_testSearch_private.json"
    When user makes a REST Call for "PUT" request with url "quicklinks/storedText?publiclink=false" and path ""
    Then Status code 204 must be returned
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for Get request with url "quicklinks?publiclink=false"
    And user verifies whether the value is present in response using json path "$..['name']"
      | jsonValues         |
      | TestPrivateSearch1 |

   ##6867808##
  @MLP-15294 @sanity @regression @quicklink @positive
  Scenario: Verification of deleting a public saved search with the public value as false
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes REST call for Get "quicklinks?publiclink=false" and retrieves value from using jsonpath "*[?(@.name=='TestPublicSearch1')].id"
    When user makes a REST Call for "DELETE" request with url "quicklinks/storedText?publiclink=false" and path ""
    Then Status code 404 must be returned
    And response message contains value "errorMessage"

  ##6867809##
  @MLP-15294 @sanity @regression @quicklink @positive
  Scenario: Verification of deleting a user specific saved search with the public value as true
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes REST call for Get "quicklinks?publiclink=false" and retrieves value from using jsonpath "*[?(@.name=='TestPrivateSearch1')].id"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "DELETE" request with url "quicklinks/storedText?publiclink=true" and path ""
    Then Status code 404 must be returned
    And response message contains value "errorMessage"

  ##6862112##
  @MLP-15294 @sanity @regression @quicklink @positive
  Scenario: Verification of deleting a search that is specific to a user
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes REST call for Get "quicklinks?publiclink=false" and retrieves value from using jsonpath "*[?(@.name=='TestPrivateSearch1')].id"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "DELETE" request with url "quicklinks/storedText?publiclink=false" and path ""
    Then Status code 204 must be returned

  ##6863325##
  @MLP-15294 @sanity @regression @quicklink @positive
  Scenario: Verification of getting the details of a saved search which is deleted for specific user
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for Get request with url "quicklinks?publiclink=false"
    Then Status code 200 must be returned
    Then response message should not have value "TestPrivateSearch1" for jsonpath "$..name"

  ##6867803##6862111##
  @MLP-15294 @sanity @regression @quicklink @positive
  Scenario: Verification of getting the details of a saved search which is already deleted for public user
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes REST call for Get "quicklinks?publiclink=false" and retrieves value from using jsonpath "*[?(@.name=='TestPublicSearch1')].id"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "DELETE" request with url "quicklinks/storedText?publiclink=true" and path ""
    Then Status code 204 must be returned
    And user makes a REST Call for Get request with url "quicklinks?publiclink=false"
    Then Status code 200 must be returned
    Then response message should not have value "TestPublicSearch1" for jsonpath "$..name"