#Feature: MLP-13224 This feature is about license functionality to ensure it works fine
#
#  ##6783840##
#  @MLP-13224 @webtest @regression @positive #descoped
#  Scenario:MLP-13224_Verification of error message during login when IDP and IDA is disabled and IDC enabled
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
#      | Content-Type  | application/json               |
#      | Accept        | application/json               |
#    And supply payload with file name "idc/MLP-13224_IDCEnabled.json"
#    When user makes a REST Call for PUT request with url "settings/license"
#    And Status code 204 must be returned
#    Then user makes a REST Call for Get request with url "settings/license"
#    And Status code 200 must be returned
#    And user compares the following value from response using json path
#      | jsonValues | jsonPath                         |
#      | true       | $..[?(@.feature=='IDC')].enabled |
#      | false      | $..[?(@.feature=='IDP')].enabled |
#      | false      | $..[?(@.feature=='IDA')].enabled |
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And Error message should be displayed as "License denied for feature IDP"
#
#  ##6783841## #descoped
#  @MLP-13224 @webtest @regression @positive
#  Scenario:MLP-13224_Verification of expiring the IDP feature using until parameter with past date
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
#      | Content-Type  | application/json               |
#      | Accept        | application/json               |
#    And supply payload with file name "idc/MLP-2342_ExpiryDate_Past.json"
#    When user makes a REST Call for PUT request with url "settings/license"
#    And Status code 204 must be returned
#    Then user makes a REST Call for Get request with url "settings/license"
#    And response returns with the following items
#      | description | searchItems | expectedResults |
#      | Status Code |             | 200             |
#    And user compares the following value from response using json path
#      | jsonValues                   | jsonPath                       |
#      | 2019-01-21T11:34:02.834+0000 | $..[?(@.feature=='IDP')].until |
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And Error message should be displayed as "License denied for feature IDP"
#
#  ##6783842## #descoped
#  @MLP-13224 @webtest @regression @positive
#  Scenario:MLP-13224_Verification of licensing when IDP and IDA is enabled and IDC disabled
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
#      | Content-Type  | application/json               |
#      | Accept        | application/json               |
#    And supply payload with file name "idc/MLP-13224_IDCDisabled.json"
#    When user makes a REST Call for PUT request with url "settings/license"
#    And Status code 204 must be returned
#    Then user makes a REST Call for Get request with url "settings/license"
#    And Status code 200 must be returned
#    And user compares the following value from response using json path
#      | jsonValues | jsonPath                         |
#      | false      | $..[?(@.feature=='IDC')].enabled |
#      | true       | $..[?(@.feature=='IDP')].enabled |
#      | true       | $..[?(@.feature=='IDA')].enabled |
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And user validate Plugin Manager widget is displayed
#    And user clicks on logout button
#
#
#    ##6783843## #descoped
#  @MLP-13224 @webtest @regression @positive
#  Scenario:MLP-13224_Verification of Local file collector[IDL] feature disabled
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
#      | Content-Type  | application/json               |
#      | Accept        | application/json               |
#    And supply payload with file name "idc/MLP-13224_IDLDisabled.json"
#    When user makes a REST Call for PUT request with url "settings/license"
#    And Status code 204 must be returned
#    Then user makes a REST Call for Get request with url "settings/license"
#    And Status code 200 must be returned
#    And user compares the following value from response using json path
#      | jsonValues | jsonPath                         |
#      | false      | $..[?(@.feature=='IDL')].enabled |
#    Then user makes a REST Call for Get request with url "users/license?feature=IDL"
#    And Status code 200 must be returned
#    And response message contains value "false"
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And user clicks on Plugin Manager in Administration dashboard
#    And user "verify not displayed" plugin "LocalFileCollector" in "plugin list" of Plugin Manager page
#    And user clicks on logout button
#
#  ##6783844## #descoped
#  @MLP-13224 @webtest @regression @positive
#  Scenario:MLP-13224_Verification of Local file collector[IDL] feature removed
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
#      | Content-Type  | application/json               |
#      | Accept        | application/json               |
#    And supply payload with file name "idc/MLP-13224_IDLRemoved.json"
#    When user makes a REST Call for PUT request with url "settings/license"
#    And Status code 204 must be returned
#    Then user makes a REST Call for Get request with url "settings/license"
#    And Status code 200 must be returned
#    And user compares the following value from response using json path
#      | jsonValues | jsonPath                         |
#      | false      | $..[?(@.feature=='IDL')].enabled |
#    Then user makes a REST Call for Get request with url "users/license?feature=IDL"
#    And Status code 200 must be returned
#    And response message contains value "false"
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And user clicks on Plugin Manager in Administration dashboard
#    And user "verify not displayed" plugin "LocalFileCollector" in "plugin list" of Plugin Manager page
#    And user clicks on logout button
#
#  ##6783845###descoped
#  @MLP-13224 @webtest @regression @positive
#  Scenario:MLP-13224_Verification of Local file collector[IDL] feature enabled
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
#      | Content-Type  | application/json               |
#      | Accept        | application/json               |
#    And supply payload with file name "idc/MLP-13224_IDLEnabled.json"
#    When user makes a REST Call for PUT request with url "settings/license"
#    And Status code 204 must be returned
#    Then user makes a REST Call for Get request with url "settings/license"
#    And Status code 200 must be returned
#    And user compares the following value from response using json path
#      | jsonValues | jsonPath                         |
#      | true       | $..[?(@.feature=='IDL')].enabled |
#    Then user makes a REST Call for Get request with url "users/license?feature=IDL"
#    And Status code 200 must be returned
#    And response message contains value "true"
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And user clicks on Plugin Manager in Administration dashboard
#    And user click on Analysis plugin label and navigate to "LocalFileCollector" from the available plugin list in Plugin Manager
#    And user clicks on logout button
#
    #descoped
#  @MLP-13224 @regression @positive
#  Scenario:MLP-13224_Verification of setting the license to default
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
#      | Content-Type  | application/json               |
#      | Accept        | application/json               |
#    And supply payload with file name "idc/MLP-2342_ExpiryDate_Future.json"
#    When user makes a REST Call for PUT request with url "settings/license"
#    And Status code 204 must be returned
#    Then user makes a REST Call for Get request with url "settings/license"
#    And response returns with the following items
#      | description | searchItems | expectedResults |
#      | Status Code |             | 200             |
#    And user compares the following value from response using json path
#      | jsonValues                   | jsonPath                       |
#      | 2019-12-31T11:34:02.834+0000 | $..[?(@.feature=='IDP')].until |