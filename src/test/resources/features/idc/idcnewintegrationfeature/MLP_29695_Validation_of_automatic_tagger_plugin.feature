@MLP-29695:@MLP-30756
Feature: MLP-29695_MLP-30756: Validation of Automatic Tagger plugin

  @MLP-29695 @regression
  Scenario: Importing xml data
    Given Execute REST API with following parameters
      | Header          | Query | Param | type | url                                                                                                                                 | body                     | response code | response message | jsonPath |
      | application/xml |       |       | Post | import/Default?isRnx=true&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&streamStartItemCount=50000 | idc/MLP_29695/Sample.xml | 200           |                  |          |

#7246398#
  @MLP-29695 @regression
  Scenario:SC1#MLP-29695_Validating items are tagged based on GraphQL query after executing Automatic Tagger plugin
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                       | body                            | response code | response message | jsonPath                                          |
      | application/json |       |       | Put          | settings/analyzers/AutomaticTagger                                        | idc/MLP_29695/TableGraphQL.json | 204           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AutomaticTagger/TableAutoTag |                                 | 200           | IDLE             | $.[?(@.configurationName=='TableAutoTag')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/linker/AutomaticTagger/TableAutoTag  |                                 | 200           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AutomaticTagger/TableAutoTag |                                 | 200           | IDLE             | $.[?(@.configurationName=='TableAutoTag')].status |
    And Analysis log "linker/AutomaticTagger/TableAutoTag%" should display below info/error/warning
      | type | logValue                             | logCode | pluginName | removableText |
      | INFO | Tagged 1 items with tag AutoTagger   |         |            |               |
      | INFO | Untagged 0 items from tag AutoTagger |         |            |               |

  @MLP-29695 @regression
  Scenario Outline:SC1#MLP-29695_user retrieves the item ids of item and copy them to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name         | type  | targetFile                             | jsonpath      |
      | APPDBPOSTGRES | Default | AutoTagTable | Table | response/parquetS3/actual/itemIds.json | $..Cluster.id |

  Scenario Outline: SC#1-user verifies tag assigned
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    And user verifies whether the value is present in response using json path "$..['name']"
      | jsonValues |
      | AutoTagger |
    Examples:
      | url                                       | responseCode | inputJson     | inputFile                              | outPutFile                                     | outPutJson |
      | tags/Default/list/Default.Table:::dynamic | 200          | $..Cluster.id | response/parquetS3/actual/itemIds.json | response/parquetS3/actual/clusterMetadata.json |            |


  @MLP-29695
  Scenario: SC#1:MLP-29695:Delete Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                 | type     | query | param |
      | SingleItemDelete | Default | linker/AutomaticTagger/TableAutoTag% | Analysis |       |       |

#7246398#7246409#
  @MLP-29695 @regression
  Scenario:SC2#MLP-29695_Validate rerunning plugin tags new items based on changed GraphQL query and old items are untagged
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                       | body                               | response code | response message | jsonPath                                          |
      | application/json |       |       | Put          | settings/analyzers/AutomaticTagger                                        | idc/MLP_29695/DatabaseGraphQL.json | 204           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AutomaticTagger/TableAutoTag |                                    | 200           | IDLE             | $.[?(@.configurationName=='TableAutoTag')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/linker/AutomaticTagger/TableAutoTag  |                                    | 200           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AutomaticTagger/TableAutoTag |                                    | 200           | IDLE             | $.[?(@.configurationName=='TableAutoTag')].status |
    And Analysis log "linker/AutomaticTagger/TableAutoTag%" should display below info/error/warning
      | type | logValue                             | logCode | pluginName | removableText |
      | INFO | Tagged 1 items with tag AutoTagger   |         |            |               |
      | INFO | Untagged 1 items from tag AutoTagger |         |            |               |


  @MLP-29695 @regression
  Scenario Outline:SC2#MLP-29695_user retrieves the item ids of item and copy them to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name            | type     | targetFile                             | jsonpath      |
      | APPDBPOSTGRES | Default | AutoTagDatabase | Database | response/parquetS3/actual/itemIds.json | $..Cluster.id |

  Scenario Outline: SC#2-user verifies tag assigned
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    And user verifies whether the value is present in response using json path "$..['name']"
      | jsonValues |
      | AutoTagger |
    Examples:
      | url                                          | responseCode | inputJson     | inputFile                              | outPutFile                                     | outPutJson |
      | tags/Default/list/Default.Database:::dynamic | 200          | $..Cluster.id | response/parquetS3/actual/itemIds.json | response/parquetS3/actual/clusterMetadata.json |            |

  @MLP-29695 @regression
  Scenario Outline:SC2#MLP-29695_user retrieves the item id of item and copy them to json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name         | type  | targetFile                             | jsonpath      |
      | APPDBPOSTGRES | Default | AutoTagTable | Table | response/parquetS3/actual/itemIds.json | $..Cluster.id |

  Scenario Outline: SC#2-user verifies tag unassigned
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    And empty response body should be displayed
    Examples:
      | url                                       | responseCode | inputJson     | inputFile                              | outPutFile                                     | outPutJson |
      | tags/Default/list/Default.Table:::dynamic | 200          | $..Cluster.id | response/parquetS3/actual/itemIds.json | response/parquetS3/actual/clusterMetadata.json |            |


  @MLP-29695
  Scenario: SC#2:MLP-29695:Delete tag
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                 | type     | query | param |
      | SingleItemDelete | Default | AutoTagger                           | Tag      |       |       |
      | SingleItemDelete | Default | linker/AutomaticTagger/TableAutoTag% | Analysis |       |       |


    #7246400#
  @MLP-29695 @regression
  Scenario:SC3#MLP-29695_Validating child items are also tagged when tagchildren is enabled
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                       | body                                 | response code | response message | jsonPath                                          |
      | application/json |       |       | Put          | settings/analyzers/AutomaticTagger                                        | idc/MLP_29695/TableChildGraphQL.json | 204           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AutomaticTagger/ChildAutoTag |                                      | 200           | IDLE             | $.[?(@.configurationName=='ChildAutoTag')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/linker/AutomaticTagger/ChildAutoTag  |                                      | 200           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AutomaticTagger/ChildAutoTag |                                      | 200           | IDLE             | $.[?(@.configurationName=='ChildAutoTag')].status |
    And Analysis log "linker/AutomaticTagger/ChildAutoTag%" should display below info/error/warning
      | type | logValue                                  | logCode | pluginName | removableText |
      | INFO | Tagged 3 items with tag AutoChildTagger   |         |            |               |
      | INFO | Untagged 0 items from tag AutoChildTagger |         |            |               |

  @MLP-29695 @regression
  Scenario Outline:SC3#MLP-29695_user retrieves the item ids of item and copy them to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name             | type   | targetFile                             | jsonpath            |
      | APPDBPOSTGRES | Default | AutoTagTable     | Table  | response/parquetS3/actual/itemIds.json | $..Cluster.id       |
      | APPDBPOSTGRES | Default | AutoTagColumnOne | Column | response/parquetS3/actual/itemIds.json | $..has_Service.id   |
      | APPDBPOSTGRES | Default | AutoTagColumnTwo | Column | response/parquetS3/actual/itemIds.json | $..has_Directory.id |

  Scenario Outline: SC#3-user verifies tag assigned
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    And user verifies whether the value is present in response using json path "$..['name']"
      | jsonValues      |
      | AutoChildTagger |
    Examples:
      | url                                        | responseCode | inputJson           | inputFile                              | outPutFile                                     | outPutJson |
      | tags/Default/list/Default.Table:::dynamic  | 200          | $..Cluster.id       | response/parquetS3/actual/itemIds.json | response/parquetS3/actual/clusterMetadata.json |            |
      | tags/Default/list/Default.Column:::dynamic | 200          | $..has_Service.id   | response/parquetS3/actual/itemIds.json | response/parquetS3/actual/serviceMetadata.json |            |
      | tags/Default/list/Default.Column:::dynamic | 200          | $..has_Directory.id | response/parquetS3/actual/itemIds.json | response/parquetS3/actual/dirMetadata.json     |            |


  @MLP-29632 @regression
  Scenario Outline:SC4:Store the item ID to a file
    Given user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive          | catalog | type  | name         | asg_scopeid | targetFile                            | jsonpath       |
      | APPDBPOSTGRES | ItemIDNodeUpdate | Default | Table | AutoTagTable |             | payloads\idc\MLP_29695\AssignTag.json | $..itemIds..id |

  @MLP-29632 @regression
  Scenario:SC4:Manually assigning tag to item which was tagged with automatic tagger
    And user update the json file "idc/MLP_29695/AssignTag.json" file for following values
      | jsonPath             | jsonValues |
      | $.assignedTags..name | State      |
    Then Execute REST API with following parameters
      | Header           | Query | Param | type | url                      | body                         | response code | response message | jsonPath |
      | application/json |       |       | Post | tags/Default/assignments | idc/MLP_29695/AssignTag.json | 204           |                  |          |


  @MLP-29695 @regression
  Scenario Outline:SC4#MLP-29695_user retrieves the item ids of item and copy them to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name         | type  | targetFile                             | jsonpath      |
      | APPDBPOSTGRES | Default | AutoTagTable | Table | response/parquetS3/actual/itemIds.json | $..Cluster.id |

  Scenario Outline: SC#4-user verifies tag assigned
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    And user verifies whether the value is present in response using json path "$..['name']"
      | jsonValues      |
      | AutoChildTagger |
      | State           |
    Examples:
      | url                                       | responseCode | inputJson     | inputFile                              | outPutFile                                     | outPutJson |
      | tags/Default/list/Default.Table:::dynamic | 200          | $..Cluster.id | response/parquetS3/actual/itemIds.json | response/parquetS3/actual/clusterMetadata.json |            |


  @MLP-29695 @regression
  Scenario:SC4#MLP-29695_Rerunning the plugin
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                       | body                              | response code | response message | jsonPath                                          |
      | application/json |       |       | Put          | settings/analyzers/AutomaticTagger                                        | idc/MLP_29695/ServiceGraphQL.json | 204           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AutomaticTagger/ChildAutoTag |                                   | 200           | IDLE             | $.[?(@.configurationName=='ChildAutoTag')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/linker/AutomaticTagger/ChildAutoTag  |                                   | 200           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AutomaticTagger/ChildAutoTag |                                   | 200           | IDLE             | $.[?(@.configurationName=='ChildAutoTag')].status |


  @MLP-29695 @regression
  Scenario Outline:SC4#MLP-29695_user retrieves the item ids of item and copy them to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name         | type  | targetFile                             | jsonpath      |
      | APPDBPOSTGRES | Default | AutoTagTable | Table | response/parquetS3/actual/itemIds.json | $..Cluster.id |

    #7246402#
  Scenario Outline: SC#4-Validating plugin should never untag manually assigned tag
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    And user verifies whether the value is present in response using json path "$..['name']"
      | jsonValues |
      | State      |
    Examples:
      | url                                       | responseCode | inputJson     | inputFile                              | outPutFile                                     | outPutJson |
      | tags/Default/list/Default.Table:::dynamic | 200          | $..Cluster.id | response/parquetS3/actual/itemIds.json | response/parquetS3/actual/clusterMetadata.json |            |


  @MLP-29695
  Scenario: SC#4:MLP-29695:Delete tag
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name            | type | query | param |
      | SingleItemDelete | Default | AutoChildTagger | Tag  |       |       |


  @MLP-29632 @regression
  Scenario Outline:SC4:Store item ID to a file
    Given user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive          | catalog | type  | name         | asg_scopeid | targetFile                              | jsonpath       |
      | APPDBPOSTGRES | ItemIDNodeUpdate | Default | Table | AutoTagTable |             | payloads\idc\MLP_29695\UnAssignTag.json | $..itemIds..id |

  @MLP-29632 @regression
  Scenario:SC4:Remove assigned Tag
    And user update the json file "idc/MLP_29695/UnAssignTag.json" file for following values
      | jsonPath             | jsonValues |
      | $.assignedTags..name | State      |
    Then Execute REST API with following parameters
      | Header           | Query | Param | type | url                      | body                           | response code | response message | jsonPath |
      | application/json |       |       | Post | tags/Default/assignments | idc/MLP_29695/UnAssignTag.json | 204           |                  |          |


#7246403#
  @MLP-29695 @regression
  Scenario:SC5#MLP-29695_Validating no items are tagged when invalid table name are given in GraphQL query
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                       | body                                   | response code | response message | jsonPath                                          |
      | application/json |       |       | Put          | settings/analyzers/AutomaticTagger                                        | idc/MLP_29695/InvalidTableGraphQL.json | 204           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AutomaticTagger/TableAutoTag |                                        | 200           | IDLE             | $.[?(@.configurationName=='TableAutoTag')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/linker/AutomaticTagger/TableAutoTag  |                                        | 200           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AutomaticTagger/TableAutoTag |                                        | 200           | IDLE             | $.[?(@.configurationName=='TableAutoTag')].status |
    And Analysis log "linker/AutomaticTagger/TableAutoTag%" should display below info/error/warning
      | type | logValue                             | logCode | pluginName | removableText |
      | INFO | Tagged 0 items with tag AutoTagger   |         |            |               |
      | INFO | Untagged 0 items from tag AutoTagger |         |            |               |

#7246404#
  @MLP-29695 @regression @webtest
  Scenario:SC#6_Validating error message in UI if invalid GraphQL query is provided.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute       |
      | Type      | Linker          |
      | Plugin    | AutomaticTagger |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute           |
      | Name      | TestAutomaticTagger |
      | Label     | TestAutomaticTagger |
    And user "click" on "Add button in Tagging Queries" button in "Add Manage Configuration Sources Page"
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName  | attribute |
      | Query Code | Test      |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName  | validationMessage                                               |
      | Query Code | Invalid GraphQL query Syntax Error: Unexpected Name "Test". 1:1 |

#7246411#
  @MLP-29695 @regression @webtest
  Scenario:SC#7_Verify if mandatory fields are left blank it throws proper error message in AutomaticTagger Plugin
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute       |
      | Type      | Linker          |
      | Plugin    | AutomaticTagger |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |
    And user "click" on "Add button in Tagging Queries" button in "Add Manage Configuration Sources Page"
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage                   |
      | Tag Names | Tag Names field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

#7246405#7246412#
  @MLP-29695 @regression
  Scenario:SC8#MLP-29695_Validating items are tagged if multiple GraphQL queries with different tag names are provided.
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                          | body                               | response code | response message | jsonPath                                             |
      | application/json |       |       | Put          | settings/analyzers/AutomaticTagger                                           | idc/MLP_29695/MultipleGraphQL.json | 204           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AutomaticTagger/MultipleAutoTag |                                    | 200           | IDLE             | $.[?(@.configurationName=='MultipleAutoTag')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/linker/AutomaticTagger/MultipleAutoTag  |                                    | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AutomaticTagger/MultipleAutoTag |                                    | 200           | IDLE             | $.[?(@.configurationName=='MultipleAutoTag')].status |
    And Analysis log "linker/AutomaticTagger/MultipleAutoTag%" should display below info/error/warning
      | type | logValue                             | logCode | pluginName | removableText |
      | INFO | Tagged 1 items with tag AutoTagTwo   |         |            |               |
      | INFO | Tagged 1 items with tag AutoTagOne   |         |            |               |
      | INFO | Untagged 0 items from tag AutoTagTwo |         |            |               |
      | INFO | Untagged 0 items from tag AutoTagOne |         |            |               |


  @MLP-29695 @regression
  Scenario Outline:SC8#MLP-29695_user retrieves the item id of item AutoTagTable and copy them to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name         | type  | targetFile                             | jsonpath      |
      | APPDBPOSTGRES | Default | AutoTagTable | Table | response/parquetS3/actual/itemIds.json | $..Cluster.id |


  Scenario Outline: SC#8-user verifies tag assigned AutoTagOne
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    And user verifies whether the value is present in response using json path "$..['name']"
      | jsonValues |
      | AutoTagOne |
    Examples:
      | url                                       | responseCode | inputJson     | inputFile                              | outPutFile                                     | outPutJson |
      | tags/Default/list/Default.Table:::dynamic | 200          | $..Cluster.id | response/parquetS3/actual/itemIds.json | response/parquetS3/actual/clusterMetadata.json |            |

  @MLP-29695 @regression
  Scenario Outline:SC8#MLP-29695_user retrieves the item id of item AutoTagColumnOne and copy them to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name             | type   | targetFile                             | jsonpath      |
      | APPDBPOSTGRES | Default | AutoTagColumnOne | Column | response/parquetS3/actual/itemIds.json | $..Cluster.id |


  Scenario Outline: SC#8-user verifies tag assigned AutoTagTwo
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    And user verifies whether the value is present in response using json path "$..['name']"
      | jsonValues |
      | AutoTagTwo |
    Examples:
      | url                                        | responseCode | inputJson     | inputFile                              | outPutFile                                     | outPutJson |
      | tags/Default/list/Default.Column:::dynamic | 200          | $..Cluster.id | response/parquetS3/actual/itemIds.json | response/parquetS3/actual/clusterMetadata.json |            |


  @MLP-29695
  Scenario: SC#8:MLP-29695:Delete tag
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name       | type | query | param |
      | SingleItemDelete | Default | AutoTagTwo | Tag  |       |       |
      | SingleItemDelete | Default | AutoTagOne | Tag  |       |       |

#7246406#
  @MLP-29695 @regression
  Scenario:SC9#MLP-29695_Validating items are tagged if multiple GraphQL queries with same tag names are provided.
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                          | body                               | response code | response message | jsonPath                                             |
      | application/json |       |       | Put          | settings/analyzers/AutomaticTagger                                           | idc/MLP_29695/MultipleSameTag.json | 204           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AutomaticTagger/MultipleSameTag |                                    | 200           | IDLE             | $.[?(@.configurationName=='MultipleSameTag')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/linker/AutomaticTagger/MultipleSameTag  |                                    | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AutomaticTagger/MultipleSameTag |                                    | 200           | IDLE             | $.[?(@.configurationName=='MultipleSameTag')].status |
    And Analysis log "linker/AutomaticTagger/MultipleSameTag%" should display below info/error/warning
      | type | logValue                             | logCode | pluginName | removableText |
      | INFO | Tagged 2 items with tag AutoTagOne   |         |            |               |
      | INFO | Untagged 0 items from tag AutoTagOne |         |            |               |


  @MLP-29695 @regression
  Scenario Outline:SC9#MLP-29695_user retrieves the item ids of item and copy them to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name             | type   | targetFile                             | jsonpath          |
      | APPDBPOSTGRES | Default | AutoTagTable     | Table  | response/parquetS3/actual/itemIds.json | $..Cluster.id     |
      | APPDBPOSTGRES | Default | AutoTagColumnOne | Column | response/parquetS3/actual/itemIds.json | $..has_Service.id |

  Scenario Outline: SC#9-user verifies tag assigned
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    And user verifies whether the value is present in response using json path "$..['name']"
      | jsonValues |
      | AutoTagOne |
    Examples:
      | url                                        | responseCode | inputJson         | inputFile                              | outPutFile                                     | outPutJson |
      | tags/Default/list/Default.Table:::dynamic  | 200          | $..Cluster.id     | response/parquetS3/actual/itemIds.json | response/parquetS3/actual/clusterMetadata.json |            |
      | tags/Default/list/Default.Column:::dynamic | 200          | $..has_Service.id | response/parquetS3/actual/itemIds.json | response/parquetS3/actual/serviceMetadata.json |            |


  @MLP-29695
  Scenario:MLP-29695:SC#9Delete tag and Analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                     | type     | query | param |
      | SingleItemDelete | Default | AutoTagOne               | Tag      |       |       |
      | SingleItemDelete | Default | AutoTagDBSystem          | Service  |       |       |
      | MultipleIDDelete | Default | linker/AutomaticTagger/% | Analysis |       |       |


  @MLP-30756 @regression
  Scenario:SC#10_Importing xml data
    Given Execute REST API with following parameters
      | Header          | Query | Param | type | url                                                                                                                                 | body                   | response code | response message | jsonPath |
      | application/xml |       |       | Post | import/Default?isRnx=true&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&streamStartItemCount=50000 | idc/MLP_29695/Data.xml | 200           |                  |          |


  @MLP-30756 @regression
  Scenario:SC10#MLP-30756_Run automatic tagger plugin with similar graphQL query
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                         | body                              | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/AutomaticTagger                                          | idc/MLP_29695/SimilarGraphQL.json | 204           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AutomaticTagger/SimilarAutoTag |                                   | 200           | IDLE             | $.[?(@.configurationName=='SimilarAutoTag')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/linker/AutomaticTagger/SimilarAutoTag  |                                   | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AutomaticTagger/SimilarAutoTag |                                   | 200           | IDLE             | $.[?(@.configurationName=='SimilarAutoTag')].status |
    And Analysis log "linker/AutomaticTagger/SimilarAutoTag%" should display below info/error/warning
      | type | logValue                                    | logCode | pluginName | removableText |
      | INFO | Tagged 2 items with tag SimilarGraphQLTag   |         |            |               |
      | INFO | Untagged 0 items from tag SimilarGraphQLTag |         |            |               |


  @MLP-30756 @regression
  Scenario:SC10#MLP-30756_Verification of automatic tagger plugin run with similar graphQL query
    And Execute REST API with following parameters
      | Header           | Query | Param | type | url                                                                | body | response code | response message | jsonPath |
      | application/json |       |       | Get  | tags/Default/SimilarGraphQLTag/items?subtags=true&limit=0&offset=0 |      | 200           |                  |          |
    And user verifies whether below expected values matches with response using json path "$..['name']"
      | jsonValues        |
      | GraphQLSimilarTab |
      | GraphQLSimilarTab |

  @MLP-30756
  Scenario:MLP-30756:SC#10Delete tag and Analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                     | type     | query | param |
      | SingleItemDelete | Default | SimilarGraphQLTag        | Tag      |       |       |
      | SingleItemDelete | Default | linker/AutomaticTagger/% | Analysis |       |       |


  @MLP-30756 @regression
  Scenario:SC11#MLP-30756_Run automatic tagger plugin with alias graphQL query
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                         | body                            | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/AutomaticTagger                                          | idc/MLP_29695/AliasGraphQL.json | 204           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AutomaticTagger/SimilarAutoTag |                                 | 200           | IDLE             | $.[?(@.configurationName=='SimilarAutoTag')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/linker/AutomaticTagger/SimilarAutoTag  |                                 | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AutomaticTagger/SimilarAutoTag |                                 | 200           | IDLE             | $.[?(@.configurationName=='SimilarAutoTag')].status |
    And Analysis log "linker/AutomaticTagger/SimilarAutoTag%" should display below info/error/warning
      | type | logValue                                  | logCode | pluginName | removableText |
      | INFO | Tagged 2 items with tag AliasGraphQLTag   |         |            |               |
      | INFO | Untagged 0 items from tag AliasGraphQLTag |         |            |               |


  @MLP-30756 @regression
  Scenario:SC11#MLP-30756_Verification of automatic tagger plugin run with similar graphQL query
    And Execute REST API with following parameters
      | Header           | Query | Param | type | url                                                              | body | response code | response message | jsonPath |
      | application/json |       |       | Get  | tags/Default/AliasGraphQLTag/items?subtags=true&limit=0&offset=0 |      | 200           |                  |          |
    And user verifies whether below expected values matches with response using json path "$..['name']"
      | jsonValues    |
      | GraphQLColumn |
      | GraphQLColumn |

  @MLP-30756
  Scenario:MLP-30756:SC#11Delete tag and Analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                     | type     | query | param |
      | SingleItemDelete | Default | AliasGraphQLTag          | Tag      |       |       |
      | SingleItemDelete | Default | linker/AutomaticTagger/% | Analysis |       |       |


  @MLP-30756 @regression
  Scenario:SC12#MLP-30756_Verification of searches using graphql query with similar keyword
    And Execute REST API with following parameters
      | Header           | Query | Param | type | url                      | body                             | response code | response message | jsonPath |
      | application/json |       |       | Post | searches/Default/graphql | idc/MLP_29695/SimilarSearch.json | 200           |                  |          |
    And user verifies whether below expected values matches with response using json path "$..['name']"
      | jsonValues        |
      | GraphQLSimilarTab |
      | GraphQLSimilarTab |
    And user verifies whether below expected values matches with response using json path "$..['type']"
      | jsonValues |
      | Table      |
      | Table      |
    And user verifies whether below expected values matches with response using json path "$..['catalog']"
      | jsonValues |
      | Default    |
      | Default    |
    Then Json response message should contains the following value
      | responseMessage |
      | "id"            |

  @MLP-30756 @regression
  Scenario:SC13#MLP-30756_Verification of searches using graphql query with aliases keyword
    And Execute REST API with following parameters
      | Header           | Query | Param | type | url                      | body                           | response code | response message | jsonPath |
      | application/json |       |       | Post | searches/Default/graphql | idc/MLP_29695/AliasSearch.json | 200           |                  |          |
    And user verifies whether below expected values matches with response using json path "$..['name']"
      | jsonValues    |
      | GraphQLColumn |
      | GraphQLColumn |
    And user verifies whether below expected values matches with response using json path "$..['type']"
      | jsonValues |
      | Column     |
      | Column     |
    And user verifies whether below expected values matches with response using json path "$..['catalog']"
      | jsonValues |
      | Default    |
      | Default    |
    Then Json response message should contains the following value
      | responseMessage |
      | "id"            |

  @MLP-30756 @regression
  Scenario:SC14#MLP-30756_Verification of searches using graphql query with Any keyword
    And Execute REST API with following parameters
      | Header           | Query | Param | type | url                                  | body                               | response code | response message | jsonPath |
      | application/json |       |       | Post | items/Default/root?allowUpdate=false | idc/MLP_29695/MultiItemCreate.json | 200           |                  |          |
      |                  |       |       | Post | searches/Default/graphql             | idc/MLP_29695/AnySearch.json       | 200           |                  |          |
    And user verifies whether below expected values matches with response using json path "$..['name']"
      | jsonValues       |
      | GraphQLDirectory |
      | GraphQLFile      |
    And user verifies whether below expected values matches with response using json path "$..['type']"
      | jsonValues |
      | Directory  |
      | File       |

  @MLP-30756 @regression
  Scenario:SC15#MLP-30756_Verification of searches using graphql query with field contents keyword
    And Execute REST API with following parameters
      | Header           | Query | Param | type | url                      | body                           | response code | response message | jsonPath |
      | application/json |       |       | Post | searches/Default/graphql | idc/MLP_29695/FieldSearch.json | 200           |                  |          |
    And user verifies whether the value is present in response using json path "$..['name']"
      | jsonValues      |
      | customeraddress |
    Then Json response message should contains the following value
      | responseMessage |
      | "id"            |
      | "catalog"       |
      | "type"          |
      | "createdAt"     |
      | "filesCount"    |
      | "createdBy"     |
      | "tableSize"     |
      | "storageType"   |
      | "name"          |
      | "inputType"     |


  @MLP-30756 @regression
  Scenario:SC16#MLP-30756_Run automatic tagger plugin with Any graphQL query
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                         | body                          | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/AutomaticTagger                                          | idc/MLP_29695/AnyGraphQL.json | 204           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AutomaticTagger/SimilarAutoTag |                               | 200           | IDLE             | $.[?(@.configurationName=='SimilarAutoTag')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/linker/AutomaticTagger/SimilarAutoTag  |                               | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AutomaticTagger/SimilarAutoTag |                               | 200           | IDLE             | $.[?(@.configurationName=='SimilarAutoTag')].status |
    And Analysis log "linker/AutomaticTagger/SimilarAutoTag%" should display below info/error/warning
      | type | logValue                                | logCode | pluginName | removableText |
      | INFO | Tagged 2 items with tag AnyGraphQLTag   |         |            |               |
      | INFO | Untagged 0 items from tag AnyGraphQLTag |         |            |               |


  @MLP-30756 @regression
  Scenario:SC16#MLP-30756_Verification of automatic tagger plugin run with any graphQL query
    And Execute REST API with following parameters
      | Header           | Query | Param | type | url                                                            | body | response code | response message | jsonPath |
      | application/json |       |       | Get  | tags/Default/AnyGraphQLTag/items?subtags=true&limit=0&offset=0 |      | 200           |                  |          |
    And user verifies whether below expected values matches with response using json path "$..['name']"
      | jsonValues       |
      | GraphQLDirectory |
      | GraphQLFile      |

  @MLP-30756
  Scenario:MLP-30756:SC#16Delete tag and Analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                     | type     | query | param |
      | SingleItemDelete | Default | AnyGraphQLTag            | Tag      |       |       |
      | MultipleIDDelete | Default | linker/AutomaticTagger/% | Analysis |       |       |

  @MLP-30756
  Scenario:MLP-30756:SC#17Delete item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name             | type      | query | param |
      | SingleItemDelete | Default | GraphQLDirectory | Directory |       |       |
      | SingleItemDelete | Default | GraphQLFile      | File      |       |       |
      | SingleItemDelete | Default | AutoTagDBSystem  | Service   |       |       |
      | SingleItemDelete | Default | NewTagDBSystem   | Service   |       |       |