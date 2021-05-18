@MLP-2342
Feature: MLP-2342 - Verification of setting license date using service


  @MLP-2342 @MLP-9443 @regression @positive
  Scenario: Verification of setting license with expire date in the future
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
      | Content-Type  | application/json               |
      | Accept        | application/json               |
    And supply payload with file name "idc/MLP-2342_ExpiryDate_Future.json"
    When user makes a REST Call for PUT request with url "settings/license"
    And Status code 204 must be returned
    Then user makes a REST Call for Get request with url "settings/license"
    And response returns with the following items
      | description | searchItems | expectedResults |
      | Status Code |             | 200             |
    And user compares the following value from response using json path
      | jsonValues                   | jsonPath                       |
      | 2019-12-31T11:34:02.834+0000 | $..[?(@.feature=='IDP')].until |


  @MLP-2342 @regression @positive
  Scenario: Verification of setting license containing signature is wrong
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
      | Content-Type  | application/json               |
      | Accept        | application/json               |
    And supply payload with file name "idc/MLP-2342_ExpiryDate_Signature.json"
    When user makes a REST Call for PUT request with url "settings/license"
    And Status code 403 must be returned
    And response message contains value "License update refused"


#  @MLP-2342 @regression @negative
#  Scenario: Verification of setting license with expireDate missing
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#      | Content-Type  | application/json                   |
#      | Accept        | application/json                   |
#    And supply payload with file name "idc/MLP-2342_ExpiryDate_Missing.json"
#    When user makes a REST Call for PUT request with url "settings/license"
#    Then Status code 204 must be returned
#    And user makes a REST Call for Get request with url "settings/license"
#    And response returns with the following items
#      | description                    | searchItems | expectedResults                   |
#      | Status Code                    |             | 200                               |
#      | ResponseBody_ReturnSingleValue | expireDate  | 2019-06-01                        |
#      | ResponseBody_ReturnSingleValue | info        | Test license - expireDate missing |
#
#  @MLP-2342 @regression @negative
#  Scenario: Verification of setting license with corrupted key
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#      | Content-Type  | application/json                   |
#      | Accept        | application/json                   |
#    And supply payload with file name "idc/MLP-2342_ExpiryDate_Corrupted.json"
#    When user makes a REST Call for PUT request with url "settings/license"
#    Then Status code 400 must be returned
#    And response message contains value "Test license - corrupted JSON"

  @MLP-2342 @regression @negative
  Scenario: Verification of setting license with expire date using TestInfo
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdEd1ZXN0VXNlcjpHdWVzdFVzZXI= |
      | Content-Type  | application/json                       |
      | Accept        | application/json                       |
    And supply payload with file name "idc/MLP-2342_ExpiryDate_Future.json"
    When user makes a REST Call for PUT request with url "settings/license"
    Then Status code 403 must be returned
    And response message contains value "Access to the specified resource has been forbidden"

  @MLP-2342 @regression @negative
  Scenario: Verification of getting license with expire date using TestInfo
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdEd1ZXN0VXNlcjpHdWVzdFVzZXI= |
      | Content-Type  | application/json                       |
      | Accept        | application/json                       |
    And supply payload with file name "idc/MLP-2342_ExpiryDate_Future.json"
    When user makes a REST Call for Get request with url "settings/license"
    Then Status code 403 must be returned
    And response message contains value "Access to the specified resource has been forbidden"

  @MLP-2342 @regression @negative
  Scenario: Verification of setting license with expire date using TestData
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdEd1ZXN0VXNlcjpHdWVzdFVzZXI= |
      | Content-Type  | application/json                       |
      | Accept        | application/json                       |
    And supply payload with file name "idc/MLP-2342_ExpiryDate_Future.json"
    When user makes a REST Call for PUT request with url "settings/license"
    Then Status code 403 must be returned
    And response message contains value "Access to the specified resource has been forbidden"

  @MLP-2342 @regression @negative
  Scenario: Verification of getting license with expire date using TestData
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdEd1ZXN0VXNlcjpHdWVzdFVzZXI= |
      | Content-Type  | application/json                       |
      | Accept        | application/json                       |
    And supply payload with file name "idc/MLP-2342_ExpiryDate_Future.json"
    When user makes a REST Call for Get request with url "settings/license"
    Then Status code 403 must be returned
    And response message contains value "Access to the specified resource has been forbidden"

  @MLP-2342 @regression @positive
  Scenario: Verification of setting license with expire date in the past
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
      | Content-Type  | application/json               |
      | Accept        | application/json               |
    And supply payload with file name "idc/MLP-2342_ExpiryDate_Past.json"
    When user makes a REST Call for PUT request with url "settings/license"
    And Status code 204 must be returned
    Then user makes a REST Call for Get request with url "settings/license"
    And response returns with the following items
      | description | searchItems | expectedResults |
      | Status Code |             | 200             |
    And user compares the following value from response using json path
      | jsonValues                   | jsonPath                       |
      | 2019-01-21T11:34:02.834+0000 | $..[?(@.feature=='IDP')].until |


  @MLP-2342 @regression @negative
  Scenario Outline: Login Scenario - To verify setting license with expire date in past should return error for all services
    Given user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>" and body "<body>" for "TestSystemUser" user
    When Status code 401 must be returned
    Then response message contains value "License denied for feature IDP"

    Examples:
      | contentType         | acceptType       | type   | url                                                                                                                               | body                                                        |
      | application/json    | application/json | Get    | extensions/analyzers/status/InternalNode/linker/SimilarityLinker/*                                                                |                                                             |
      | application/json    | application/json | Post   | extensions/analyzers/status/InternalNode/linker/SimilarityLinker/*                                                                |                                                             |
      | application/json    | application/json | Delete | extensions/analyzers/status/InternalNode/linker/SimilarityLinker/*                                                                |                                                             |
      | application/json    | application/json | Put    | extensions/analyzers/status/InternalNode/linker/SimilarityLinker/*                                                                | idc/Example.json                                            |
      | application/json    | application/json | Post   | extensions/analyzers/stop/InternalNode/linker/SimilarityLinker/*                                                                  |                                                             |
      | application/json    | application/json | Get    | extensions/analyzers/status/Cluster%20Demo                                                                                        |                                                             |
      | application/json    | application/json | Put    | extensions/analyzers/status/Cluster%20Demo                                                                                        | idc/Example.json                                            |
      | application/json    | application/json | Get    | extensions/analyzers/callback/Cluster%20Demo                                                                                      |                                                             |
      | application/json    | application/json | Put    | extensions/analyzers/callback/Cluster%20Demo                                                                                      | idc/Example.json                                            |
      | application/json    | application/json | Delete | extensions/analyzers/callback/Cluster%20Demo                                                                                      |                                                             |
      | application/json    | application/json | Delete | extensions/analyzers/Test                                                                                                         |                                                             |
      | application/json    | application/json | Post   | extensions/analyzers/start/InternalNode/linker/SimilarityLinker/*                                                                 | idc/Example.json                                            |
      | application/json    | application/json | Post   | extensions/analyzers/result/InternalNode/linker/SimilarityLinker/*                                                                | idc/Example.json                                            |
      | application/json    | application/json | Get    | settings/analyzers/GitCollector?raw=false                                                                                         |                                                             |
      | application/json    | application/json | Put    | settings/analyzers/GitCollector                                                                                                   |                                                             |
      | application/json    | application/json | Delete | settings/analyzers/GitCollector                                                                                                   |                                                             |
      | application/json    | application/json | Get    | settings/analyzers                                                                                                                |                                                             |
      | application/json    | application/json | Get    | settings/analyzers/recent/1                                                                                                       |                                                             |
      | application/json    | application/json | Get    | settings/analysis                                                                                                                 |                                                             |
      | application/json    | application/json | Post   | settings/analysis                                                                                                                 | idc/Example.json                                            |
      | application/json    | application/json | Get    | settings/user?path=com%2Fasg%2Fdis%2Fplatform%2Fsecurity.json                                                                     |                                                             |
      | application/json    | application/json | Put    | settings?path=com%2Fasg%2Fdis%2Fplatform%2Fouter_roles.json                                                                       | idc/Example.json                                            |
      | application/json    | application/json | Delete | settings?path=com%2Fasg%2Fdis%2Fplatform%2Fouter_roles.json                                                                       |                                                             |
      | application/json    | application/json | Get    | settings/user?path=com%2Fasg%2Fdis%2Fplatform%2Fsecurity.json                                                                     |                                                             |
      | application/json    | application/json | Put    | settings/user?path=com%2Fasg%2Fdis%2Fplatform%2Fsecurity.json                                                                     | idc/Example.json                                            |
      | application/json    | application/json | Delete | settings/user?path=com%2Fasg%2Fdis%2Fplatform%2Fouter_roles.json                                                                  |                                                             |
      | application/json    | application/json | Get    | settings/catalogs/BigData                                                                                                         |                                                             |
      | application/json    | application/json | Put    | settings/catalogs/BigData                                                                                                         | idc/Example.json                                            |
      | application/json    | application/json | Delete | settings/catalogs/BigData?deleteData=true                                                                                         |                                                             |
      | application/json    | application/json | Get    | settings/catalogs/images/BigData                                                                                                  |                                                             |
      | application/json    | application/json | Get    | settings/catalogs/images                                                                                                          |                                                             |
      | application/json    | application/json | Get    | settings/catalogs/recent/1                                                                                                        |                                                             |
      | application/json    | application/json | Get    | settings/catalogs                                                                                                                 |                                                             |
      | application/json    | application/json | Post   | settings/catalogs                                                                                                                 | idc/MLP-1667_CreateCatalog.json                             |
      | application/json    | application/json | Get    | settings/components                                                                                                               |                                                             |
      | application/json    | application/json | Get    | settings/components/WelcomePage                                                                                                   |                                                             |
      | application/json    | application/json | Put    | settings/components/WelcomePage                                                                                                   | idc/Example.json                                            |
      | application/json    | application/json | Delete | settings/components/WelcomePage                                                                                                   |                                                             |
      | application/json    | application/json | Get    | settings/components/itemviews                                                                                                     |                                                             |
      | application/json    | application/json | Get    | settings/diagram/Test                                                                                                             |                                                             |
      | application/json    | application/json | Put    | settings/diagram/Test                                                                                                             | idc/Example.json                                            |
      | application/json    | application/json | Delete | settings/diagram/Test                                                                                                             |                                                             |
      | application/json    | application/json | Get    | settings/diagram                                                                                                                  |                                                             |
      | application/json    | application/json | Get    | settings/license/getEULA                                                                                                          |                                                             |
      | application/json    | application/json | Post   | settings/license/acceptEULA                                                                                                       | idc/Example.txt                                             |
      | application/json    | application/json | Get    | settings/listviews?name=defaultListView                                                                                           |                                                             |
      | application/json    | application/json | Post   | settings/listviews?name=test                                                                                                      | idc/Example.json                                            |
      | application/json    | application/json | Delete | settings/listviews?name=defaultListView                                                                                           |                                                             |
      | application/json    | application/json | Get    | settings/listviews/all                                                                                                            |                                                             |
      | application/json    | application/json | Get    | settings/queries/query                                                                                                            |                                                             |
      | application/json    | application/json | Put    | settings/queries/query                                                                                                            | idc/Example.json                                            |
      | application/json    | application/json | Delete | settings/queries/query                                                                                                            |                                                             |
      | application/json    | application/json | Get    | settings/queries                                                                                                                  |                                                             |
      | application/json    | application/json | Get    | settings/queries/types                                                                                                            |                                                             |
      | application/json    | application/json | Get    | settings/schemas/list                                                                                                             |                                                             |
      | application/json    | application/json | Get    | settings/schemas?schemaname=http%3A%2F%2Fwww.asg.com%2FBigData%2F10.1.0&techdescription=false&noImport=false                      |                                                             |
      | application/json    | application/json | Get    | settings/searches/fields/BigData?namesOnly=false                                                                                  |                                                             |
      | application/json    | application/json | Get    | settings/searches/fields?namesOnly=false                                                                                          |                                                             |
      | application/json    | application/json | Get    | settings/searches/fields/BigData/id?namesOnly=false                                                                               |                                                             |
      | application/json    | application/json | Get    | settings/searches                                                                                                                 |                                                             |
      | application/json    | application/json | Put    | settings/searches                                                                                                                 | idc/Example.json                                            |
      | application/json    | application/json | Get    | settings/socialnotifiers/hipchat                                                                                                  |                                                             |
      | application/json    | application/json | Put    | settings/socialnotifiers/hipchat                                                                                                  |                                                             |
      | application/json    | application/json | Delete | settings/socialnotifiers/hipchat                                                                                                  |                                                             |
      | application/json    | application/json | Get    | settings/socialnotifiers                                                                                                          |                                                             |
      | application/json    | application/json | Post   | settings/socialnotifiers                                                                                                          | idc/Example.json                                            |
      | application/json    | application/json | Post   | settings/tagtemplates/Testcheck                                                                                                   | idc/Example.json                                            |
      | application/json    | application/json | Delete | settings/tagtemplates/Testcheck                                                                                                   |                                                             |
      | application/json    | application/json | Get    | settings/tagtemplates                                                                                                             |                                                             |
      | application/json    | application/json | Post   | settings/tagtemplates                                                                                                             | idc/MLP-938_create_cluster_Cluster_Test.json                |
      | application/json    | application/json | Get    | settings/theme                                                                                                                    |                                                             |
      | application/json    | application/json | Get    | settings/theme/schemaview                                                                                                         |                                                             |
      | application/json    | application/json | Put    | settings/theme/schemaview                                                                                                         | idc/Example.json                                            |
      | application/json    | application/json | Delete | settings/theme/schemaview                                                                                                         |                                                             |
      | application/json    | application/json | Get    | health                                                                                                                            |                                                             |
      | application/json    | application/json | Get    | settings/preferences                                                                                                              |                                                             |
      | application/json    | application/json | Get    | settings/preferences/form                                                                                                         |                                                             |
      | application/json    | application/json | Post   | settings/preferences/form                                                                                                         |                                                             |
      | application/json    | application/json | Get    | settings/qualitymetrics                                                                                                           |                                                             |
      | application/json    | application/json | Post   | settings/qualitymetrics                                                                                                           | idc/Example.json                                            |
      | application/json    | application/json | Get    | settings/notifications                                                                                                            |                                                             |
      | application/json    | application/json | Post   | settings/notifications                                                                                                            | idc/Example.json                                            |
      | application/json    | application/json | Put    | settings/notifications/definitions                                                                                                | idc/MLP-1101_Verification_of_Item_Created_Notification.json |
      | application/json    | application/json | Delete | settings/notifications/definitions/Test                                                                                           |                                                             |
      | application/json    | application/json | Get    | statistics/requests                                                                                                               |                                                             |
      | application/json    | application/json | Get    | statistics/responses                                                                                                              |                                                             |
      | application/json    | application/json | Get    | statistics/uris                                                                                                                   |                                                             |
      | application/json    | application/json | Get    | dashboards/widgets                                                                                                                |                                                             |
      | application/json    | application/json | Get    | dashboards/QuickStart                                                                                                             |                                                             |
      | application/json    | application/json | Put    | dashboards/New                                                                                                                    | idc/Example.json                                            |
      | application/json    | application/json | Delete | dashboards/New                                                                                                                    |                                                             |
      | application/json    | application/json | Get    | dashboards                                                                                                                        |                                                             |
      | application/json    | application/json | Post   | dashboards                                                                                                                        | idc/Example.json                                            |
      | application/json    | application/json | Post   | dashboards/TestCheck/widgets                                                                                                      | idc/Example.json                                            |
      | application/json    | application/json | Delete | dashboards/Test/Test/1                                                                                                            |                                                             |
      | application/json    | application/json | Get    | dashboards/1/image                                                                                                                |                                                             |
      | application/json    | application/json | Get    | dashboards/AnalysisHistoryLog/charts                                                                                              |                                                             |
      | application/json    | application/json | Get    | dashboards/AnalysisHistoryLog/widgets                                                                                             |                                                             |
      | application/json    | application/json | Get    | navmenu                                                                                                                           |                                                             |
      | application/json    | application/json | Put    | quicklinks/1                                                                                                                      | idc/MLP-1104_update_quicklink.json                          |
      | application/json    | application/json | Get    | quicklinks/1                                                                                                                      |                                                             |
      | application/json    | application/json | Get    | quicklinks?widget=1                                                                                                               |                                                             |
      | application/json    | application/json | Post   | quicklinks                                                                                                                        | idc/MLP-1104_quicklink_singlewidget.json                    |
      | application/json    | application/json | Post   | components/BigData/types                                                                                                          | idc/Example.json                                            |
      | application/json    | application/json | Get    | components/BigData/types/Column                                                                                                   |                                                             |
      | application/json    | application/json | Get    | components/BigData/item/BigData.Table%3A%3A%3A1/attributes                                                                        |                                                             |
      | application/json    | application/json | Get    | components/BigData/BigData.Table%3A%3A%3A1/workflows                                                                              |                                                             |
      | application/json    | application/json | Get    | components/Test                                                                                                                   |                                                             |
      | application/json    | application/json | Get    | components/BigData/items/Table/relations                                                                                          |                                                             |
      | application/json    | application/json | Get    | components/BigData/definition/Test/1                                                                                              |                                                             |
      | application/json    | application/json | Get    | components/BigData/definition/Test                                                                                                |                                                             |
      | application/json    | application/json | Get    | components/BigData/item/BigData.Table%3A%3A%3A1                                                                                   |                                                             |
      | application/json    | application/json | Get    | components/BigData/item/BigData.Table%3A%3A%3A1/history                                                                           |                                                             |
      | application/json    | application/json | Get    | components/BigData/item/BigData.Table%3A%3A%3A1/comparechanges                                                                    |                                                             |
      | application/json    | application/json | Get    | components/BigData/items/Table/relations                                                                                          |                                                             |
      | application/json    | application/json | Get    | diagrams/Test                                                                                                                     |                                                             |
      | application/json    | application/json | Post   | components/itemlist?catalogname=Test&query=*%3A*&offset=0&limit=10&limitFacets=10&advanced=false                                  | idc/Example.json                                            |
      | application/json    | application/json | Get    | components/itemlist/specialattributes                                                                                             |                                                             |
      | application/json    | application/json | Get    | edges/Test/1                                                                                                                      |                                                             |
      | application/json    | application/json | Put    | edges/Test/1                                                                                                                      | idc/Example.json                                            |
      | application/json    | application/json | Delete | edges/Test/1                                                                                                                      |                                                             |
      | application/json    | application/json | Post   | edges/Test/delete                                                                                                                 | idc/Example.json                                            |
      | application/json    | application/json | Post   | edges/Test                                                                                                                        | idc/Example.json                                            |
      | application/json    | application/json | Post   | edges/Test/list                                                                                                                   | idc/Example.json                                            |
      | application/json    | application/json | Put    | items/Test/Test.Table%3A%3A%3A1                                                                                                   | idc/Example.json                                            |
      | application/json    | application/json | Delete | items/Test/Test.Table%3A%3A%3A1                                                                                                   |                                                             |
      | application/json    | application/json | Post   | items/Test/delete                                                                                                                 | idc/Example.json                                            |
      | application/json    | application/json | Post   | items/Test/Test.Table%3A%3A%3A1?allowUpdate=false                                                                                 | idc/Example.json                                            |
      | application/json    | application/json | Post   | items/Test/Test.Table%3A%3A%3A1/type?allowUpdate=false                                                                            | idc/Example.json                                            |
      | application/json    | application/json | Post   | items/Test/root?allowUpdate=true                                                                                                  | idc/MLP-1105_postreq_allowupdate_true.json                  |
      | application/json    | application/json | Post   | items/Test                                                                                                                        | idc/Example.json                                            |
      | application/json    | application/json | Get    | items/Test/Test.Table%3A%3A%3A1                                                                                                   |                                                             |
      | application/json    | application/json | Post   | items/Test/env?dir=%3C-%3E&limit=0                                                                                                | idc/Example.json                                            |
      | application/json    | application/json | Get    | items/Test/Test.Table%3A%3A%3A1/env?dir=%3C-%3E&limit=0                                                                           |                                                             |
      | application/json    | application/json | Get    | items/Test/relations?limit=0                                                                                                      |                                                             |
      | text/plain          | application/json | Post   | searches?allowwrite=false                                                                                                         | idc/PlainTextExample.txt                                    |
      | application/json    | application/json | Get    | searches/BigData/list/Table?limit=0                                                                                               |                                                             |
      | application/json    | application/json | Get    | searches/Test/query/querylist?limit=0                                                                                             |                                                             |
      | application/json    | application/json | Post   | searches/Test/query/querylist?limit=0                                                                                             | idc/Example.json                                            |
      | application/json    | application/json | Get    | searches/Test/query/Test/1?limit=0                                                                                                |                                                             |
      | application/json    | application/json | Get    | searches/BigData?query=T&limit=0                                                                                                  |                                                             |
      | application/json    | application/json | Post   | searches/BigData?query=T&limit=0                                                                                                  | idc/Example.json                                            |
      | application/json    | application/json | Get    | searches/fulltext/autosuggest?input=Test&limit=10                                                                                 |                                                             |
      | application/json    | application/json | Get    | searches/fulltext/BigData?query=*%3A*&advanced=false&limit=10&offset=0                                                            |                                                             |
      | application/json    | application/json | Post   | searches/fulltext/Test?query=*%3A*&advanced=false&limit=10&offset=0                                                               | idc/Example.json                                            |
      | application/json    | application/json | Get    | searches/fulltext/autosuggest/BigData?input=test&limit=10                                                                         |                                                             |
      | application/json    | application/json | Get    | searches/fulltext/autosuggest/BigData/Table?input=T&limit=10                                                                      |                                                             |
      | application/json    | application/json | Get    | searches/fulltext?query=*%3A*&advanced=false&limit=10&offset=0                                                                    |                                                             |
      | application/json    | application/json | Post   | searches/fulltext?query=*%3A*&advanced=false&limit=10&offset=0&limitFacets=10                                                     | idc/Example.json                                            |
      | application/json    | application/json | Post   | searches/fulltext/synchronize/Test?limit=0&maxSeconds=0&hoursUntilNext=48&force=false                                             |                                                             |
      | application/json    | application/json | Delete | searches/fulltext/synchronize/Test?force=false                                                                                    |                                                             |
      | application/json    | application/json | Post   | searches/fulltext/synchronize?limit=0&maxSeconds=0&hoursUntilNext=48&force=false                                                  |                                                             |
      | application/json    | application/json | Delete | searches/fulltext/synchronize?limit=0&maxSeconds=0&hoursUntilNext=48&force=false                                                  |                                                             |
      | application/json    | application/json | Get    | comments/BigData/BigData.Table%3A%3A%3A1                                                                                          |                                                             |
      | application/json    | application/json | Post   | comments/Test/Test.Table%3A%3A%3A1                                                                                                | idc/Example.json                                            |
      | application/json    | application/json | Put    | comments/Test/Test.Comment%3A%3A%3A3                                                                                              | idc/Example.json                                            |
      | application/json    | application/json | Delete | comments/Test/Test.Comment%3A%3A%3A3                                                                                              |                                                             |
      | application/json    | application/json | Get    | comments/preview/BigData/BigData.Table%3A%3A%3A1                                                                                  |                                                             |
      | application/json    | application/json | Get    | ratings/BigData/BigData.Table%3A%3A%3A1?limit=10&order=date&reverse=true                                                          |                                                             |
      | application/json    | application/json | Delete | ratings/Test/Test.Table%3A%3A%3A1?limit=10&order=date&reverse=true                                                                |                                                             |
      | application/json    | application/json | Post   | ratings/Test/Test.Table%3A%3A%3A1/1                                                                                               |                                                             |
      | application/json    | application/json | Post   | recommendations/update/Test                                                                                                       |                                                             |
      | application/json    | application/json | Delete | recommendations/update/Test                                                                                                       |                                                             |
      | application/json    | application/json | Get    | recommendations/items/Test                                                                                                        |                                                             |
      | application/json    | application/json | Get    | recommendations/items/Test/Test.Table%3A%3A%3A1                                                                                   |                                                             |
      | application/json    | application/json | Get    | recommendations/items/Test/Test.Table%3A%3A%3A1                                                                                   |                                                             |
      | application/json    | application/json | Get    | queries/models/BigData/properties                                                                                                 |                                                             |
      | application/json    | application/json | Post   | queries/models/properties?catalogNames=Test                                                                                       | idc/Example.json                                            |
      | application/json    | application/json | Get    | queries/models/catalogs                                                                                                           |                                                             |
      | application/json    | application/json | Get    | queries/models/types                                                                                                              |                                                             |
      | application/json    | application/json | Get    | queries/models/BigData/types                                                                                                      |                                                             |
      | application/json    | application/json | Get    | queries/steps                                                                                                                     |                                                             |
      | application/json    | application/json | Get    | queries/models/BigData/relations/out                                                                                              |                                                             |
      | application/json    | application/json | Get    | queries/models/BigData/relations/in                                                                                               |                                                             |
      | application/json    | application/json | Get    | queries/models/BigData/relations/both                                                                                             |                                                             |
      | application/json    | application/json | Post   | queries/models/BigData/values/appliedTo                                                                                           | idc/Example.json                                            |
      | application/json    | application/json | Post   | queries/models/labels                                                                                                             | idc/Example.json                                            |
      | application/json    | application/json | Get    | models/BigData/types?withInstances=true&withProperties=false                                                                      |                                                             |
      | application/json    | application/json | Get    | models/BigData/relationtypes?withNsaClassifiers=false                                                                             |                                                             |
      | application/json    | application/json | Post   | schemes/itemviews                                                                                                                 | idc/Example.json                                            |
      | application/json    | application/json | Get    | schemes/itemviews/itemView_Table                                                                                                  |                                                             |
      | application/json    | application/json | Put    | schemes/itemviews/itemView_Test                                                                                                   | idc/Example.json                                            |
      | application/json    | application/json | Delete | schemes/itemviews/itemView_Test                                                                                                   |                                                             |
      | application/json    | application/json | Post   | schemes/analyzers/EDIBus                                                                                                          | idc/Example.json                                            |
      | application/json    | application/json | Post   | schemes/analyzers/EDIBus                                                                                                          | idc/Example.json                                            |
      | application/json    | application/json | Get    | schemes/analyzers/EDIBus/EDIBus                                                                                                   |                                                             |
      | application/json    | application/json | Put    | schemes/analyzers/EDIBus/EDIBus                                                                                                   | idc/Example.json                                            |
      | application/json    | application/json | Delete | schemes/analyzers/EDIBus/EDIBus                                                                                                   |                                                             |
#      | application/json    | application/json | Get    | schemes/Test                                                                                                                      |                                                             |
      | application/json    | application/json | Post   | schemes/read/1                                                                                                                    | idc/Example.json                                            |
      | application/json    | application/json | Post   | schemes/save                                                                                                                      | idc/Example.json                                            |
      | application/json    | application/json | Get    | themes/schemaview?index=-1                                                                                                        |                                                             |
      | application/json    | application/json | Get    | schemes/1                                                                                                                         |                                                             |
      | application/json    | application/json | Post   | schemes/1                                                                                                                         | idc/Example.json                                            |
      | application/json    | application/json | Get    | events/types                                                                                                                      |                                                             |
      | application/json    | application/json | Delete | workflows/definitions/tagapproval                                                                                                 |                                                             |
      | application/json    | application/json | Get    | workflows/settings                                                                                                                |                                                             |
      | application/json    | application/json | Put    | workflows/settings                                                                                                                | idc/Example.json                                            |
      | application/json    | application/json | Delete | workflows/settings                                                                                                                |                                                             |
      | application/json    | application/json | Get    | workflows/instances/803/variables                                                                                                 |                                                             |
      | application/json    | application/json | Get    | workflows/definitions?limit=0                                                                                                     |                                                             |
      | application/xml     | application/json | Post   | workflows/definitions                                                                                                             | idc/TestXMLWorkflow.xml                                     |
#      | multipart/form-data | application/json | Post   | workflows/instances/803/Test                                                                                                      | idc/TestXMLWorkflow.xml                                     |
#      | application/json    | application/json | Post   | workflows/definitions                                                                                                             |                                                             |
      | multipart/form-data | application/json | Post   | workflows/deployments/Test                                                                                                        | idc/TestXMLWorkflow.xml                                     |
      | application/xml     | application/json | Put    | workflows/deployments/Test                                                                                                        | idc/TestXMLWorkflow.xml                                     |
      | application/json    | application/json | Delete | workflows/deployments/Test                                                                                                        |                                                             |
      | application/json    | application/json | Post   | workflows/definitions/Test/start                                                                                                  | idc/Example.json                                            |
      | application/json    | application/json | Get    | workflows/definitions/tagapproval/form                                                                                            |                                                             |
      | application/json    | application/json | Get    | workflows/definitions/tagapproval/instances                                                                                       |                                                             |
      | application/json    | application/json | Get    | workflows/instances/803                                                                                                           |                                                             |
      | application/json    | application/json | Get    | workflows/instances/803/history                                                                                                   |                                                             |
      | application/json    | application/json | Get    | workflows/instances/803/history/variables                                                                                         |                                                             |
      | application/json    | application/json | Post   | workflows/instances/803/stop                                                                                                      |                                                             |
      | application/json    | application/json | Get    | workflows/definitions/tagapproval/history                                                                                         |                                                             |
      | application/json    | application/json | Get    | workflows/tasks/803/form                                                                                                          |                                                             |
      | application/json    | application/json | Post   | workflows/tasks/803/submit                                                                                                        | idc/Example.json                                            |
      | application/json    | application/json | Get    | workflows/tasks/user                                                                                                              |                                                             |
      | application/json    | application/json | Get    | workflows/definitions                                                                                                             |                                                             |
      | application/xml     | application/json | Put    | workflows/deployments/Test                                                                                                        | idc/TestXMLWorkflow.xml                                     |
      | application/json    | application/json | Delete | workflows/deployments/Test                                                                                                        |                                                             |
      | application/json    | application/json | Get    | extensions/bundles/TestPlugin                                                                                                     |                                                             |
      | application/json    | application/json | Delete | extensions/bundles/TestPlugin                                                                                                     |                                                             |
      | application/json    | application/json | Get    | extensions/bundles                                                                                                                |                                                             |
      | multipart/form-data | application/json | Post   | extensions/bundles                                                                                                                | osgibundle/Osgi1-0.0.1.jar                                  |
      | application/json    | application/json | Get    | extensions/bundles/TestPlugin/com.asg.idc.Osgi1                                                                                   |                                                             |
      | application/json    | application/json | Delete | extensions/bundles/TestPlugin/com.asg.idc.Osgi1                                                                                   |                                                             |
      | application/json    | application/json | Get    | extensions/bundles/TestPlugin/com.asg.idc.Osgi1/LATEST                                                                            |                                                             |
      | application/json    | application/json | Delete | extensions/bundles/TestPlugin/com.asg.idc.Osgi1/0.0.1                                                                             |                                                             |
      | application/json    | application/json | Get    | extensions/bundles/TestPlugin/com.asg.idc.Osgi1/0.0.1/schemes                                                                     |                                                             |
      | application/json    | application/json | Get    | extensions/bundles/TestPlugin/com.asg.idc.Osgi1/0.0.1.SNAPSHOT/plugins/OService1/scheme                                           |                                                             |
      | application/xml     | application/json | Post   | import/tagtemplates?prependType=true                                                                                              | idc/MLP-1866_Verification_of_allowedRootTagDefault.xml      |
      | application/xml     | application/json | Post   | import/Test?isRnx=false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&streamStartItemCount=50000 |                                                             |
      | application/json    | application/json | Get    | import/spreadsheets?catalogname=BigData                                                                                           |                                                             |
      | application/json    | application/json | Get    | import/spreadsheets/New.Import%3A%3A%3A2                                                                                          |                                                             |
      | application/json    | application/json | Delete | import/spreadsheets/New.Import%3A%3A%3A2                                                                                          |                                                             |
      | application/json    | application/json | Delete | import/spreadsheets/New.Import%3A%3A%3A2/content                                                                                  |                                                             |
      | application/json    | application/json | Put    | import/spreadsheets                                                                                                               | idc/BusinessItems.xlsx                                      |
      | multipart/form-data | application/json | Post   | import/spreadsheets/New/content                                                                                                   | idc/Example.json                                            |
      | application/json    | application/json | Get    | import/spreadsheets/BigData/bystatus?statuses=STARTED                                                                             |                                                             |
      | application/json    | application/json | Get    | import/spreadsheets/New.Import%3A%3A%3A2/columns?sheetName=Sheet1&containsColumnHeader=true                                       |                                                             |
      | multipart/form-data | application/json | Post   | uploads/Test?databaseName=piidata&tableName=person_info&clusterName=New%20Cluster%20&allowUpdate=false&sheetName=Person%20Data    | datasetupload/Person_Data.xlsx                              |
      | application/json    | application/json | Delete | uploads/Test?databaseName=piidata&tableName=person_info&clusterName=New%20Cluster%20&allowUpdate=false&sheetName=Person%20Data    |                                                             |
      | application/json    | application/json | Post   | uploads/Test/updatestatus?id=ExcelUpload.UploadData%3A%3A%3A1&status=NEW&message=Test                                             |                                                             |
      | application/json    | application/json | Get    | uploads/BigData/uploaddatabystatus?statuses=NEW                                                                                   |                                                             |
      | application/json    | application/json | Delete | uploads/Test/contentbyid?id=ExcelUpload.UploadData%3A%3A%3A1                                                                      |                                                             |
      | application/json    | application/json | Get    | uploads/Test/uploaddata?databaseName=piidata&tableName=person_family_info&clusterName=New%20Cluster                               |                                                             |
      | application/json    | application/json | Get    | lineages/diagrams/Test/Test                                                                                                       |                                                             |
      | application/json    | application/json | Delete | lineages/diagrams/Test/Test                                                                                                       |                                                             |
      | application/json    | application/json | Get    | lineages/diagrams/Test?offset=0&limit=10                                                                                          |                                                             |
      | application/json    | application/json | Post   | lineages/diagrams/Test?offset=0&limit=10                                                                                          | idc/Example.json                                            |
#      | application/json    | application/json | Post   | lineages/BigData/zoom?dir=-%3E                                                                                                    | idc/Example.json                                            |
      | application/json    | application/json | Post   | lineages/Test/hops                                                                                                                | idc/Example.json                                            |
      | application/json    | application/json | Post   | lineages/Test?dir=-%3E                                                                                                            | idc/Example.json                                            |
      | application/json    | application/json | Get    | models/BigData/types?withInstances=true&withProperties=false                                                                      |                                                             |
      | application/json    | application/json | Get    | models/Test/relationtypes?withNsaClassifiers=false                                                                                |                                                             |
      | application/json    | application/json | Post   | mobile/Test                                                                                                                       |                                                             |
      | application/json    | application/json | Get    | notifications                                                                                                                     |                                                             |
      | application/json    | application/json | Post   | notifications                                                                                                                     | idc/Example.json                                            |
      | application/json    | application/json | Delete | notifications                                                                                                                     | idc/Example.json                                            |
      | application/json    | application/json | Get    | notifications/public.Notification%3A%3A%3A17                                                                                      |                                                             |
      | application/json    | application/json | Post   | notifications/public.Notification%3A%3A%3A171                                                                                     |                                                             |
      | application/json    | application/json | Delete | notifications/public.Notification%3A%3A%3A171                                                                                     |                                                             |
      | application/json    | application/json | Post   | notifications/dismiss/public.Notification%3A%3A%3A171?action=Test                                                                 |                                                             |
      | application/json    | application/json | Post   | notifications/dismiss                                                                                                             | idc/Example.json                                            |
      | application/json    | application/json | Get    | accesses/BigData/BigData.Column%3A%3A%3A1?recursive=false                                                                         |                                                             |
      | application/json    | application/json | Put    | accesses/BigData/BigData.Column%3A%3A%3A1?recursive=false                                                                         | idc/Example.json                                            |
      | application/json    | application/json | Delete | accesses/BigData/BigData.Column%3A%3A%3A1?recursive=false                                                                         |                                                             |
      | application/json    | application/json | Post   | accesses/BigData?recursive=false&operation=SET                                                                                    | idc/Example.json                                            |
      | application/json    | application/json | Get    | users                                                                                                                             |                                                             |
      | application/json    | application/json | Get    | users/permissions                                                                                                                 |                                                             |
#      | application/json         | application/json         | Get    | users/outerroles                                                                                                                                     |                                                             |
      | application/json    | application/json | Get    | users/roles                                                                                                                       |                                                             |
      | application/json    | application/json | Get    | users/usergroups                                                                                                                  |                                                             |
      | application/json    | application/json | Get    | users/token                                                                                                                       |                                                             |
      | application/json    | application/json | Get    | users/profile                                                                                                                     |                                                             |
      | application/json    | application/json | Get    | users/tenant                                                                                                                      |                                                             |
      | application/json    | application/json | Get    | users/catalogs                                                                                                                    |                                                             |
      | application/json    | application/json | Get    | users/permissions/tenant                                                                                                          |                                                             |
      | application/json    | application/json | Get    | users/permissions/catalog/BigData                                                                                                 |                                                             |
      | application/json    | application/json | Get    | users/roles/tenant                                                                                                                |                                                             |
#      | application/json    | application/json | Post   | users/roles/tenant                                                                                                                | idc/Example.json                                            |
      | application/json    | application/json | Get    | users/roles/catalog/BigData                                                                                                       |                                                             |
      | application/json    | application/json | Get    | users/ratings/BigData?userName=TestService&limit=10&order=date&reverse=true                                                       |                                                             |
      | application/json    | application/json | Get    | users/license?feature=IDA                                                                                                         |                                                             |
      | application/json    | application/json | Get    | encrypt?connectionName=TestService&connectionPassword=TestService                                                                 |                                                             |
#      | application/json         | application/json         | Get    | innerroles                                                                                                                                           |                                                             |
#      | application/json         | application/json         | Get    | permissionmappings                                                                                                                                   |                                                             |
#      | application/json         | application/json         | Put    | permissionmappings                                                                                                                                   | idc/Example.json                                            |
#      | application/json         | application/json         | Delete | permissionmappings                                                                                                                                   |                                                             |
#      | application/json         | application/json         | Get    | permissionmappings/tenant                                                                                                                            |                                                             |
#      | application/json         | application/json         | Put    | permissionmappings/tenant                                                                                                                            | idc/Example.json                                            |
#      | application/json         | application/json         | Delete | permissionmappings/tenant                                                                                                                            |                                                             |
#      | application/json         | application/json         | Get    | permissionmappings/catalog/Test                                                                                                                      |                                                             |
#      | application/json         | application/json         | Put    | permissionmappings/catalog/Test                                                                                                                      | idc/Example.json                                            |
#      | application/json         | application/json         | Delete | permissionmappings/catalog/Test                                                                                                                      |                                                             |
      | application/json    | application/json | Get    | permissions                                                                                                                       |                                                             |
      | application/json    | application/json | Get    | rolemappings                                                                                                                      |                                                             |
      | application/json    | application/json | Post   | rolemappings                                                                                                                      | idc/Example.json                                            |
      | application/json    | application/json | Put    | rolemappings                                                                                                                      | idc/Example.json                                            |
      | application/json    | application/json | Delete | rolemappings                                                                                                                      |                                                             |
      | application/json    | application/json | Get    | rolemappings/tenant                                                                                                               |                                                             |
      | application/json    | application/json | Post   | rolemappings/tenant                                                                                                               | idc/Example.json                                            |
      | application/json    | application/json | Put    | rolemappings/tenant                                                                                                               | idc/Example.json                                            |
      | application/json    | application/json | Delete | rolemappings/tenant                                                                                                               |                                                             |
      | application/json    | application/json | Get    | rolemappings/catalog/Test                                                                                                         |                                                             |
      | application/json    | application/json | Post   | rolemappings/catalog/Test                                                                                                         | idc/Example.json                                            |
      | application/json    | application/json | Put    | rolemappings/catalog/Test                                                                                                         | idc/Example.json                                            |
      | application/json    | application/json | Delete | rolemappings/catalog/Test                                                                                                         |                                                             |
      | application/json    | application/json | Get    | roles                                                                                                                             |                                                             |
      | application/json    | application/json | Post   | roles                                                                                                                             | idc/Example.json                                            |
      | application/json    | application/json | Get    | roles/CATALOG_ADMIN                                                                                                               |                                                             |
      | application/json    | application/json | Put    | roles/CATALOG_ADMIN                                                                                                               | idc/Example.json                                            |
      | application/json    | application/json | Delete | roles/CATALOG_ADMIN                                                                                                               |                                                             |
      | application/json    | application/json | Get    | roles/tenant/CATALOG_ADMIN                                                                                                        |                                                             |
      | application/json    | application/json | Put    | roles/tenant/CATALOG_ADMIN                                                                                                        | idc/Example.json                                            |
      | application/json    | application/json | Delete | roles/tenant/CATALOG_ADMIN                                                                                                        |                                                             |
      | application/json    | application/json | Get    | roles/catalog/BigData/CATALOG_ADMIN                                                                                               |                                                             |
      | application/json    | application/json | Get    | roles/catalog/BigData                                                                                                             |                                                             |
      | application/json    | application/json | Get    | usergroups/users/TestSystem                                                                                                       |                                                             |
      | application/json    | application/json | Get    | usergroups                                                                                                                        |                                                             |
      | application/json    | application/json | Post   | usergroups/users                                                                                                                  | idc/Example.json                                            |
      | application/json    | application/json | Post   | usergroups/userdetails                                                                                                            | idc/Example.json                                            |
      | application/json    | application/json | Post   | usergroups/cache?cacheexpiry=10000                                                                                                |                                                             |
      | application/json    | application/json | Delete | usergroups/cache                                                                                                                  |                                                             |
      | application/json    | application/json | Get    | usergroups/System                                                                                                                 |                                                             |
      | application/json    | application/json | Post   | tags/Test/tags                                                                                                                    | idc/MLP-1758_create_tag.json                                |
      | application/json    | application/json | Get    | tags/BigData/tags/BigData                                                                                                         |                                                             |
      | application/json    | application/json | Put    | tags/Test/tags/BigData                                                                                                            | idc/Example.json                                            |
      | application/json    | application/json | Get    | tags/BigData/list                                                                                                                 |                                                             |
      | application/json    | application/json | Get    | tags/BigData/tags/ids/BigData.Tag%3A%3A%3A1                                                                                       |                                                             |
      | application/json    | application/json | Put    | tags/Test/tags/BigData/SUGGESTED                                                                                                  |                                                             |
      | application/json    | application/json | Delete | tags/Test/tags/BigData                                                                                                            |                                                             |
      | application/json    | application/json | Get    | tags/BigData/BigData/items?subtags=true&limit=0&offset=0                                                                          |                                                             |
      | application/json    | application/json | Get    | tags/BigData/items?subtags=true&limit=0&offset=0                                                                                  |                                                             |
      | application/json    | application/json | Get    | tags/BigData/BigData/subtags                                                                                                      |                                                             |
      | application/json    | application/json | Get    | tags/Test/structures                                                                                                              |                                                             |
      | application/json    | application/json | Post   | tags/Test/structures                                                                                                              | idc/Example.json                                            |
      | application/json    | application/json | Get    | tags/BigData/assignments                                                                                                          |                                                             |
      | application/json    | application/json | Post   | tags/Test/assignments                                                                                                             | idc/Example.json                                            |
      | application/json    | application/json | Post   | tags/Test/structures/BigData?keepOld=true                                                                                         | idc/Example.json                                            |
      | application/json    | application/json | Get    | settings?path=com%2Fasg%2Fdis%2Fplatform%2Farea.json                                                                              |                                                             |
#      | application/json         | application/json         | Get    | export/hive/BigData                                                                                                                                  |                                                             |
#      | application/octet-stream | application/octet-stream | Post   | export/hive/BigData?xmlFileOutput=Test.xml                                                                                                           |                                                             |
#      | application/xml | application/xml | Get  | export/BigData?xmlSchemaUri=http%3A%2F%2Frochade.asg.com%2FBROWSER_BG%2F1.00.0&Rochade-Conversion=true |      |
      | application/json    | application/json | Get    | datasets/DataSets.DataSet%3A%3A%3A2                                                                                               |                                                             |
      | application/json    | application/json | Post   | datasets/DataSets.DataSet%3A%3A%3A2                                                                                               | idc/Example.json                                            |
      | application/json    | application/json | Put    | datasets/DataSets.DataSet%3A%3A%3A2                                                                                               | idc/Example.json                                            |
      | application/json    | application/json | Delete | datasets/DataSets.DataSet%3A%3A%3A2                                                                                               |                                                             |
      | application/json    | application/json | Get    | datasets                                                                                                                          |                                                             |
      | application/json    | application/json | Post   | datasets                                                                                                                          | idc/Example.json                                            |
      | application/json    | application/json | Post   | datasets/DataSets.DataSet%3A%3A%3A2/actions                                                                                       | idc/Example.json                                            |
      | application/json    | application/json | Post   | datasets/DataSets.DataSet%3A%3A%3A2/actions/run                                                                                   | idc/Example.json                                            |
      | application/json    | application/json | Get    | datasets/BigData/query?query=*%3A*&offset=0&limitFacets=10                                                                        |                                                             |
      | application/json    | application/json | Get    | datasets/DataSets.DataSet%3A%3A%3A2/details/DataSets.OrderRequest%3A%3A%3A1/workflows                                             |                                                             |
      | application/json    | application/json | Post   | datasets/dataelements                                                                                                             | idc/Example.json                                            |
      | application/json    | application/json | Get    | datasets/DataSets.DataSet%3A%3A%3A2/orders/DataSets.OrderRequest%3A%3A%3A1                                                        |                                                             |
      | application/json    | application/json | Delete | datasets/DataSets.DataSet%3A%3A%3A2/orders/DataSets.OrderRequest%3A%3A%3A1                                                        |                                                             |
      | application/json    | application/json | Get    | datasets/DataSets.DataSet%3A%3A%3A2/details/DataSets.OrderDetail%3A%3A%3A1/comments                                               |                                                             |
      | application/json    | application/json | Post   | datasets/DataSets.DataSet%3A%3A%3A2/orders/DataSets.OrderRequest%3A%3A%3A1/details/DataSets.OrderDetail%3A%3A%3A1?action=APPROVED |                                                             |
      | application/json    | application/json | Get    | datasets/DataSets.DataSet%3A%3A%3A2/notebooks/views                                                                               |                                                             |
      | application/json    | application/json | Post   | datasets/DataSets.DataSet%3A%3A%3A2/notebooks                                                                                     | idc/Example.json                                            |
      | application/json    | application/json | Put    | datasets/DataSets.DataSet%3A%3A%3A2/notebooks/DataSets.Notebook%3A%3A%3A6                                                         | idc/Example.json                                            |
      | application/json    | application/json | Post   | datasets/DataSets.DataSet%3A%3A%3A2/dataelements?operation=ADD                                                                    | idc/Example.json                                            |
      | application/json    | application/json | Post   | datasets/notebooks/Test                                                                                                           | idc/Example.json                                            |
      | application/json    | application/json | Get    | datasets/dataaccess/BigData.Table%3A%3A%3A1                                                                                       |                                                             |
      | application/json    | application/json | Get    | datasets/datasample/BigData.Table%3A%3A%3A1                                                                                       |                                                             |
      | application/json    | application/json | Post   | recipes/execute                                                                                                                   | idc/Example.json                                            |
      | application/json    | application/json | Post   | recipes/DataSets.Recipe%3A%3A%3A1/execute                                                                                         | idc/Example.json                                            |
      | application/json    | application/json | Get    | recipes/directives                                                                                                                |                                                             |
      | application/json    | application/json | Get    | recipes/DataSets.Recipe%3A%3A%3A1                                                                                                 |                                                             |
      | application/json    | application/json | Put    | recipes/DataSets.Recipe%3A%3A%3A1                                                                                                 | idc/Example.json                                            |
      | application/json    | application/json | Delete | recipes/DataSets.Recipe%3A%3A%3A1                                                                                                 |                                                             |
      | application/json    | application/json | Get    | recipes                                                                                                                           |                                                             |
      | application/json    | application/json | Post   | recipes                                                                                                                           | idc/Example.json                                            |
      | application/json    | application/json | Get    | settings/issues/JiraConnector                                                                                                     |                                                             |
      | application/json    | application/json | Put    | settings/issues/JiraConnector                                                                                                     | idc/Example.json                                            |
      | application/json    | application/json | Delete | settings/issues/JiraConnector                                                                                                     |                                                             |
      | application/json    | application/json | Get    | settings/issues                                                                                                                   |                                                             |
      | application/json    | application/json | Get    | settings/issues/recent/1                                                                                                          |                                                             |
      | application/json    | application/json | Get    | issues/BigData/BigData.Table%3A%3A%3A1                                                                                            |                                                             |
      | application/json    | application/json | Get    | issues/oauth                                                                                                                      |                                                             |

  @MLP-2342 @regression @negative
  Scenario Outline: Login Scenario - To verify setting license with expire date in past should return error code alone for below services
    Given user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>" and body "<body>" for "TestSystemUser" user
    When Status code 401 must be returned
    Examples:
      | contentType     | acceptType      | type | url                                                                                                    | body |
      | application/xml | application/xml | Get  | export/BigData?xmlSchemaUri=http%3A%2F%2Frochade.asg.com%2FBROWSER_BG%2F1.00.0&Rochade-Conversion=true |      |


  @MLP-2342 @regression @negative
  Scenario Outline: Login Scenario - To verify setting license with expire date in past should return error code as XML response
    Given user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>" and body "<body>" for "TestSystemUser" user
    When Status code 401 must be returned
    Then Verify XML response message contains value
      | License denied for feature IDP |
    Examples:
      | contentType     | acceptType      | type | url                                                                                                                                                  | body |
      | application/xml | application/xml | Get  | export/BigData/query/queryDiagramIn/BigData.Column%3A%3A%3A1?xmlSchemaUri=http%3A%2F%2Frochade.asg.com%2FBROWSER_BG%2F1.00.0&Rochade-Conversion=true |      |
      | application/xml | application/xml | Get  | workflows/definitions/tagapproval                                                                                                                    |      |

#  @MLP-2342 @regression @positive
#  Scenario: Verification of setting license with default expire date
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
#      | Content-Type  | application/json               |
#      | Accept        | application/json               |
#    When supply payload with file name "idc/MLP-2342_ExpiryDate.json"
#    Then user makes a REST Call for PUT request with url "settings/license"
#    And Status code 204 must be returned

  @MLP-9443 @regression @positive
  Scenario:Verification of setting license with expire date to 2019-12-31
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
      | Content-Type  | application/json               |
      | Accept        | application/json               |
    And supply payload with file name "idc/MLP-2342_ExpiryDate_Future.json"
    When user makes a REST Call for PUT request with url "settings/license"
    And Status code 204 must be returned
    Then user makes a REST Call for Get request with url "settings/license"
    And response returns with the following items
      | description | searchItems | expectedResults |
      | Status Code |             | 200             |
    And user compares the following value from response using json path
      | jsonValues                   | jsonPath                       |
      | 2019-12-31T11:34:02.834+0000 | $..[?(@.feature=='IDP')].until |

