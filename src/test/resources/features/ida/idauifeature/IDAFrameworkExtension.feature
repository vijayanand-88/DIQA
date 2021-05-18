Feature: Feature to validate the plugin based on Node Condition

  @sanity @positive @regression
  Scenario Outline:SC1#-Set the Credentials & Git Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                       | body                                                             | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/GitValidCredentials  | ida/gitFilterPayloads/GitCredentials.json                        | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/GitCollectorDataSource | ida/gitFilterPayloads/git_collectory_repo_config_Datasource.json | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/GitCollectorDataSource |                                                                  | 200           |                  |          |

  @positive
  Scenario: Verify plugin config gets assigned to appropriate nodes when nodeCondition is defined as internal
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                          | body                        | response code | response message      | jsonPath                                         |
      | application/json | raw   | false | Put  | settings/analyzers/GitCollector              | ida/frameworkextension.json | 204           |                       |                                                  |
      |                  |       |       | Get  | extensions/analyzers/definition/InternalNode | ida/frameworkextension.json | 200           | BitbucketInternalnode | $.configurations.[name]=='BitbucketInternalnode' |


  @positive
  Scenario: Verify plugin config gets assigned to all nodes when nodeCondition is not defined
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                               | body                        | response code | response message     | jsonPath                                        |
      | application/json | raw   | false | Put  | settings/analyzers/GitCollector   | ida/frameworkextension.json | 204           |                      |                                                 |
      |                  |       |       | Get  | extensions/analyzers/definition/* | ida/frameworkextension.json | 200           | Bitbucketwithoutnode | $.configurations.[name]=='Bitbucketwithoutnode' |

  @positive
  Scenario: Verify plugin config gets assigned to appropriate nodes when nodeCondition is defined as java
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                       | body                        | response code | response message  | jsonPath                                     |
      | application/json | raw   | false | Put  | settings/analyzers/GitCollector           | ida/frameworkextension.json | 204           |                   |                                              |
      |                  |       |       | Get  | extensions/analyzers/definition/LocalNode | ida/frameworkextension.json | 200           | BitbucketJavanode | $.configurations.[name]=='BitbucketJavanode' |


  @positive
  Scenario: Verify plugin config gets assigned to appropriate nodes when nodeCondition is defined as bigdata
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                            | body                        | response code | response message     | jsonPath                                        |
      | application/json | raw   | false | Put  | settings/analyzers/GitCollector                | ida/frameworkextension.json | 204           |                      |                                                 |
      |                  |       |       | Get  | extensions/analyzers/definition/Cluster%20Demo | ida/frameworkextension.json | 200           | Bitbucketbigdatanode | $.configurations.[name]=='Bitbucketbigdatanode' |

##################  De Scoped  ###################

#  @webtest
#  Scenario: Verify Show Advanced Settings option should be visible for all analysis plugins
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And user clicks on Plugin Manager in Administration dashboard
#    And user click on Analysis plugin label and navigates to valdiate Show Advanced Settings option is present
#
#  @webtest
#  Scenario: Verify Show Advanced Settings option should not be visible for all dataset plugins
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And user clicks on Plugin Manager in Administration dashboard
#    And user click on Analysis plugin label and navigates to valdiate Show Advanced Settings option is not present


#  @webtest
#  Scenario: Verify invalid expresssion is not allowed in the node condition
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And user clicks on Plugin Manager in Administration dashboard
#    And user click on Analysis plugin label and navigate to "GitCollector" from the available plugin list in Plugin Manager
#    And user clicks on Add button in plugin panel
#    And user selects "BigData" catalog from the dropdown in the Plugin configuration panel in Plugin manager
#    And user enters the following values in Plugin Configuration fields
#      | pluginConfigFieldName | pluginConfigFieldValue                                    |
#      | NAME                  | Git_Collector                                             |
#      | LABEL                 | Git_Collector                                             |
#      | REPOSITORY URL        | https://source-team.asg.com/scm/di/pythonanalyzerdemo.git |
#    And user "click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
#    And user enters the following values in Plugin Configuration fields
#      | pluginConfigFieldName | pluginConfigFieldValue |
#      | NODE CONDITION        | *&%&^$$&               |
#    And user click Apply button in "PLUGIN CONFIGURATION" page
#    And user click Apply button in "GITCOLLECTOR CONFIGURATIONS" page
#    And user verifies invalid "nodeCondition" expresssion is not allowed

#  @webtest
#  Scenario: Verify invalid expresssion is not allowed in the event condition
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And user clicks on Plugin Manager in Administration dashboard
#    And user click on Analysis plugin label and navigate to "HdfsCataloger" from the available plugin list in Plugin Manager
#    And user clicks on Add button in plugin panel
#    And user selects "BigData" catalog from the dropdown in the Plugin configuration panel in Plugin manager
#    And user enters the following values in Plugin Configuration fields
#      | pluginConfigFieldName | pluginConfigFieldValue |
#      | NAME                  | HdfsCataloger          |
#      | LABEL                 | HdfsCataloger          |
#      | MAX HITS              | 3                      |
#      | DELTA TIME            | 300                    |
#    And user "click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
#    And user enters the following values in Plugin Configuration fields
#      | pluginConfigFieldName | pluginConfigFieldValue |
#      | EVENT CONDITION       | *&%&^$$&               |
#    And user click Apply button in "PLUGIN CONFIGURATION" page
#    And user click Apply button in "HDFSCATALOGER CONFIGURATIONS" page
#    And user verifies invalid "eventCondition" expresssion is not allowed
#
#
#  @webtest
#  Scenario: Verify invalid expresssion is not allowed in the event condition
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And user clicks on Plugin Manager in Administration dashboard
#    And user click on Analysis plugin label and navigate to "HiveCataloger" from the available plugin list in Plugin Manager
#    And user clicks on Add button in plugin panel
#    And user selects "BigData" catalog from the dropdown in the Plugin configuration panel in Plugin manager
#    And user enters the following values in Plugin Configuration fields
#      | pluginConfigFieldName | pluginConfigFieldValue |
#      | NAME                  | HiveCataloger          |
#      | LABEL                 | HiveCataloger          |
#      | DELTA TIME            | 300                    |
#    And user "click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
#    And user enters the following values in Plugin Configuration fields
#      | pluginConfigFieldName | pluginConfigFieldValue |
#      | EVENT CONDITION       | *&%&^$$&               |
#    And user click Apply button in "PLUGIN CONFIGURATION" page
#    And user click Apply button in "HIVECATALOGER CONFIGURATIONS" page
#    And user verifies invalid "eventCondition" expresssion is not allowed
#
#
#  @webtest
#  Scenario: Verify invalid expresssion is not allowed in the event condition
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And user clicks on Plugin Manager in Administration dashboard
#    And user click on Analysis plugin label and navigate to "HiveDirectoryLinker" from the available plugin list in Plugin Manager
#    And user clicks on Add button in plugin panel
#    And user selects "BigData" catalog from the dropdown in the Plugin configuration panel in Plugin manager
#    And user enters the following values in Plugin Configuration fields
#      | pluginConfigFieldName | pluginConfigFieldValue |
#      | NAME                  | HiveDirectoryLinker    |
#      | LABEL                 | HiveDirectoryLinker    |
#    And user "click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
#    And user enters the following values in Plugin Configuration fields
#      | pluginConfigFieldName | pluginConfigFieldValue |
#      | EVENT CONDITION       | *&%&^$$&               |
#    And user click Apply button in "PLUGIN CONFIGURATION" page
#    And user click Apply button in "HIVEDIRECTORYLINKER CONFIGURATIONS" page
#    And user verifies invalid "eventCondition" expresssion is not allowed


  @positive
  Scenario: Verify Data_Analysis permission if the node status is down
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdEd1ZXN0VXNlcjpHdWVzdFVzZXI= |
      | Content-Type  | application/json                       |
      | Accept        | application/json                       |
    And supply payload with file name "ida/Valid_Node_Status_DOWN.txt"
    When user makes a REST Call for PUT request with url "extensions/analyzers/status/LocalNode"
    Then Status code 403 must be returned
    Then response message contains value "Access to the specified resource has been forbidden"


  @positive
  Scenario: Verify Data_Analysis permission if the node status is Up
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdEd1ZXN0VXNlcjpHdWVzdFVzZXI= |
      | Content-Type  | application/json                       |
      | Accept        | application/json                       |
    And supply payload with file name "ida/Valid_Node_Status_UP.txt"
    When user makes a REST Call for PUT request with url "extensions/analyzers/status/LocalNode"
    Then Status code 403 must be returned
    Then response message contains value "Access to the specified resource has been forbidden"


  Scenario: Verify plugin config gets assigned to appropriate nodes when nodeCondition is defined for HDFS cataloger
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                            | body                           | response code | response message | jsonPath                                 |
      | application/json | raw   | false | Put  | settings/analyzers/HdfsCataloger               | ida/frameworkextensionone.json | 204           |                  |                                          |
      |                  |       |       | Get  | extensions/analyzers/definition/Cluster%20Demo | ida/frameworkextensionone.json | 200           | HdfsCataloger    | $.configurations.[name]=='HdfsCataloger' |

  Scenario: Verify plugin config gets assigned to appropriate nodes when nodeCondition is defined for Hive cataloger
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                            | body                           | response code | response message | jsonPath                                 |
      | application/json | raw   | false | Put  | settings/analyzers/HiveCataloger               | ida/frameworkextensionone.json | 204           |                  |                                          |
      |                  |       |       | Get  | extensions/analyzers/definition/Cluster%20Demo | ida/frameworkextensionone.json | 200           | HiveCataloger    | $.configurations.[name]=='HiveCataloger' |

  Scenario: Verify plugin config gets assigned to appropriate nodes when nodeCondition is defined for Hive Directory linker
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                            | body                           | response code | response message    | jsonPath                                       |
      | application/json | raw   | false | Put  | settings/analyzers/HiveDirectoryLinker         | ida/frameworkextensionone.json | 204           |                     |                                                |
      |                  |       |       | Get  | extensions/analyzers/definition/Cluster%20Demo | ida/frameworkextensionone.json | 200           | HiveDirectoryLinker | $.configurations.[name]=='HiveDirectoryLinker' |

    ##5146445##
  Scenario: Verification of response code when trying to run non existing plugin
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for Get request with url "/settings/analyzers/tester"
    Then Status code 200 must be returned
    And response message contains value ""