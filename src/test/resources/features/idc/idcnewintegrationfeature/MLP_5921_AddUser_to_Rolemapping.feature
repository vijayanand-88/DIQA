#@MLP-5921
#Feature: MLP-5921: Verification of adding user to rolemapping at repository and catalog level
#
#  ##MLP-19513 - Bug for Adding Users and Groups

#  @MLP-5921 @positive @webtest @regression @rolemapping
#  Scenario:MLP-5921 Verification of roles for the users have more permissions than the role for the groups of the user and adding role mappings at repository level with user
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user makes a REST Call for DELETE request with url "roles/NewUserRole"
#    And supply payload with file name "idc\MLP-5921_CreateRole.json"
#    When user makes a REST Call for POST request with url "roles"
#    And Status code 204 must be returned
#    And supply payload with file name "idc\MLP-5921_AddRolemappings.json"
#    And user makes a REST Call for PUT request with url "rolemappings"
#    And Status code 204 must be returned
#    Then User launch browser and traverse to login page
#    And user enter credentials for "Information User" role
#    And user clicks on Administration widget
#    And user clicks on logout button
#    And user makes a REST Call for DELETE request with url "rolemappings?rolename=NewUserRole&usergroup=Guest%20Users"
#    And Status code 204 must be returned
#
#  @MLP-5921 @positive @regression @rolemapping
#  Scenario:MLP-5921 Verification of updating role mappings at repository level with user
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc\MLP-5921_AddNewRolemappings.json"
#    When user makes a REST Call for PUT request with url "rolemappings"
#    And Status code 204 must be returned
#    And supply payload with file name "idc\MLP-5921_AddRolemappingsUser.json"
#    When user makes a REST Call for POST request with url "rolemappings"
#    And Status code 204 must be returned
#    And user makes a REST Call for Get request with url "rolemappings?username=becubic_build"
#    And Status code 200 must be returned
#    And user compares the following value from response using json path
#      | jsonValues    | jsonPath    |
#      | NewUserRole   | $..['role'] |
#      | becubic_build | $..['user'] |
#
#
#  @MLP-5921 @positive @regression @rolemapping
#  Scenario:MLP-5921 Verification of getting role mappings at repository level with user
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user makes a REST Call for Get request with url "rolemappings?rolename=NewUserRole"
#    And Status code 200 must be returned
#    And user compares the following value from response using json path
#      | jsonValues    | jsonPath    |
#      | becubic_build | $..['user'] |
#
#
#  @MLP-5921 @positive @regression @rolemapping
#  Scenario:MLP-5921 Verification of deleting role mappings at repository level with user
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    When user makes a REST Call for DELETE request with url "rolemappings?username=becubic_build"
#    And Status code 204 must be returned
#    And user makes a REST Call for Get request with url "rolemappings?username=becubic_build"
#    And Status code 200 must be returned
#    And response message not contains value "becubic_build"
#
#
#  @MLP-5921 @positive @regression @rolemapping
#  Scenario:MLP-5921: Verification of updating rolemappings at catalog level with user
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user makes a REST Call for DELETE request with url "settings/catalogs/UserCatalog?deleteData=true"
#    And supply payload with file name "idc/MLP-5875_BecubicRoleMapping.json"
#    When user makes a REST Call for PUT request with url "rolemappings"
#    Then Status code 204 must be returned
#    And supply payload with file name "idc/MLP-5921_CreateCatalog.json"
#    And user makes a REST Call for POST request with url "/settings/catalogs"
#    And Status code 204 must be returned
#    And configure a new REST API for the service "IDC"
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic YmVjdWJpY19idWlsZDpsYWd1bmEtMjAxMg== |
#      | Content-Type  | application/json                           |
#      | Accept        | application/json                           |
#    And supply payload with file name "idc/MLP-5921_AddUserRolemappings.json"
#    And user makes a REST Call for POST request with url "rolemappings/catalog/UserCatalog"
#    And Status code 204 must be returned
#    And user makes a REST Call for Get request with url "rolemappings/catalog/UserCatalog"
#    And Status code 200 must be returned
#    And user compares the following value from response using json path
#      | jsonValues    | jsonPath    |
#      | becubic_build | $..['user'] |
#
#
#  @MLP-5921 @webtest @positive @regression @rolemapping
#  Scenario:MLP-5921: Verification of getting rolemappings at catalog level with user and Verification of role mapping at catalog level and repository level
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic YmVjdWJpY19idWlsZDpsYWd1bmEtMjAxMg== |
#      | Content-Type  | application/json                           |
#      | Accept        | application/json                           |
#    When user makes a REST Call for Get request with url "rolemappings/catalog/UserCatalog?rolename=NewUserRole"
#    And Status code 200 must be returned
#    And user compares the following value from response using json path
#      | jsonValues    | jsonPath    |
#      | becubic_build | $..['user'] |
#    Then user makes a REST Call for Get request with url "rolemappings/catalog/UserCatalog?username=becubic_build"
#    And Status code 200 must be returned
#    And user compares the following value from response using json path
#      | jsonValues  | jsonPath    |
#      | NewUserRole | $..['role'] |
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And user clicks on Administration widget
#    And User click on Subject Area Manager link on the Dashboard page
#    And deleted subject area "UserCatalog" should not be displayed in subject area management page
#    And user should be able logoff the IDC
#    And user clicks on sign in as a different user link
#    And user enter credentials for "Becubic User" role
#    And user clicks on Administration widget
#    And User click on Subject Area Manager link on the Dashboard page
#    And user clicks on mentioned catalog "UserCatalog" to be deleted
#    And user should be able logoff the IDC
#
#  @MLP-5921 @positive @regression @rolemapping
#  Scenario:MLP-5921: Verification of deleting rolemappings at catalog level with user
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic YmVjdWJpY19idWlsZDpsYWd1bmEtMjAxMg== |
#      | Content-Type  | application/json                           |
#      | Accept        | application/json                           |
#    When user makes a REST Call for DELETE request with url "rolemappings/catalog/UserCatalog?username=becubic_build"
#    And Status code 204 must be returned
#    Then user makes a REST Call for Get request with url "rolemappings/catalog/UserCatalog"
#    And Status code 200 must be returned
#    And response message not contains value "becubic_build"
#
#  @MLP-5921 @positive @regression @rolemapping
#  Scenario:MLP-5921: Verification of adding rolemappings at catalog level with user
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
#      | Content-Type  | application/json               |
#      | Accept        | application/json               |
#    And supply payload with file name "idc/MLP-5921_AddRolemappingsSystemUser.json"
#    And user makes a REST Call for PUT request with url "rolemappings/catalog/UserCatalog"
#    And Status code 204 must be returned
#    Then user makes a REST Call for Get request with url "rolemappings/catalog/UserCatalog"
#    And Status code 200 must be returned
#    And user compares the following value from response using json path
#      | jsonValues  | jsonPath    |
#      | TestSystem | $..['user'] |
#    When user makes a REST Call for DELETE request with url "rolemappings/catalog/UserCatalog"
#    And Status code 204 must be returned
#
#
#  @MLP-5921 @positive @regression @rolemapping
#  Scenario:MLP-5921 Verification of adding and updating role mappings at tenant level with user
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc\MLP-5921_AddNewRolemappings.json"
#    When user makes a REST Call for PUT request with url "rolemappings/tenant"
#    And Status code 204 must be returned
#    And configure a new REST API for the service "IDC"
#    When To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic YmVjdWJpY19idWlsZDpsYWd1bmEtMjAxMg== |
#      | Content-Type  | application/json                           |
#      | Accept        | application/json                           |
#    And supply payload with file name "idc\MLP-5921_AddRolemappingsUser.json"
#    And user makes a REST Call for POST request with url "rolemappings/tenant"
#    And Status code 204 must be returned
#    Then user makes a REST Call for Get request with url "rolemappings/tenant?rolename=NewUserRole"
#    And Status code 200 must be returned
#    And user compares the following value from response using json path
#      | jsonValues    | jsonPath    |
#      | becubic_build | $..['user'] |
#
#
#  @MLP-5921 @positive @regression @rolemapping
#  Scenario:MLP-5921 Verification of getting role mappings at tenant level with user
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic YmVjdWJpY19idWlsZDpsYWd1bmEtMjAxMg== |
#      | Content-Type  | application/json                           |
#      | Accept        | application/json                           |
#    When user makes a REST Call for Get request with url "rolemappings/tenant?rolename=NewUserRole"
#    And Status code 200 must be returned
#    And user compares the following value from response using json path
#      | jsonValues  | jsonPath    |
#      | NewUserRole | $..['role'] |
#
#
#  @MLP-5921 @positive @regression @rolemapping
#  Scenario:MLP-5921: Verification of deleting rolemappings at tenant level with user
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
#      | Content-Type  | application/json               |
#      | Accept        | application/json               |
#    When user makes a REST Call for DELETE request with url "rolemappings/tenant?username=becubic_build"
#    And Status code 204 must be returned
#    Then user makes a REST Call for Get request with url "rolemappings/catalog/UserCatalog"
#    And Status code 200 must be returned
#    And response message not contains value "becubic_build"
