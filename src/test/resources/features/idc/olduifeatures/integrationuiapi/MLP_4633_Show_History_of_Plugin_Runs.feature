#@MLP-4633
#Feature: MLP-4633 Provide service to show history of runs of a particular plugin configuration and log info
#
#  @MLP-4633 @positive @IDC10.0 @sanity
#  Scenario:Update Analysis configuration and run HDFS Cataloger plugin
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                               | body                                                         | response code | response message |
#      |        |       |       | Put  | /settings/analyzers/HdfsCataloger | ida/bigdataAnalyzerPayloads/bigdataAnalyzer_hdfs_config.json | 204           |                  |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                             | body                                                                | response code | response message |
#      |        |       |       | Put  | /settings/analyzers/HdfsMonitor | ida/bigdataAnalyzerPayloads/bigdataAnalyzer_hdfsmonitor_config.json | 204           |                  |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                 | body                                                    | response code | response message |
#      |        |       |       | Put  | /settings/analyzers/BigDataAnalyzer | ida/bigdataAnalyzerPayloads/bigdataAnalyzer_config.json | 204           |                  |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                               | body | response code | response message |
#      |        |       |       | Get  | /settings/analyzers/HdfsCataloger |      | 200           | HdfsCataloger    |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                   | body | response code | response message | jsonPath                                           |
#      |        |       |       | RecursiveGet | /extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger |      | 200           | IDLE             | $.[?(@.configurationName=='HdfsCataloger')].status |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                  | body | response code | response message |
#      |        |       |       | Post | /extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger |      | 200           |                  |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                   | body | response code | response message | jsonPath                                           |
#      |        |       |       | RecursiveGet | /extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger |      | 200           | IDLE             | $.[?(@.configurationName=='HdfsCataloger')].status |
#
#  @MLP-4633 @positive @IDC10.0 @sanity @webtest
#  Scenario:MLP-4633 Verification of getting logs for the particular plugin
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user makes a REST Call for Get request with url "extensions/analyzers/history/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger" and store value of json path"$.[-1:].name"
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
##    And user configure the advance search for the login
#    And user enters the Analysis job name in Search text box and click Search
#    And user iterate and click exact Analysis log from search results
#    And user makes a REST Call for Get request with url "extensions/analyzers/history/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger" and store value of json path"$.[-1:].id"
#    And user makes a REST Call for Get request with url "/searches/BigData/query/AnalysisHistoryLog?limit=0&param=id%3DBigData.Analysis%3A%3A%3A" with value retrieved from json response
#    And user get the value from response using json path "$..data" and decode the value
#    And user clicks on log link and opens the log
#    Then Log text in UI and decoded text should be same
#
#  @MLP-4633 @positive @IDC10.0 @sanity @webtest
#  Scenario:MLP-4633_Verification of running plugin again shows the previous logs as well as new
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user makes a REST Call for Get request with url "extensions/analyzers/history/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger" and store value of json path"$.[-1:].id"
##    And User launch browser and traverse to login page
##    And user enter credentials for "System Administrator" role
##    And user clicks on Administration widget
##    And user clicks on Plugin Manager in Administration dashboard
##    And user clicks on "Cluster Demo" from nodes list
##    And user verifies whether "HdfsCataloger" is present in the plugins list and unassigns it
##    And user click save button in Create New Node page
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                               | body                                                         | response code | response message |
#      |        |       |       | Put  | /settings/analyzers/HdfsCataloger | ida/bigdataAnalyzerPayloads/bigdataAnalyzer_hdfs_config.json | 204           |                  |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                               | body | response code | response message |
#      |        |       |       | Get  | /settings/analyzers/HdfsCataloger |      | 200           | HdfsCataloger    |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                   | body | response code | response message | jsonPath                                           |
#      |        |       |       | RecursiveGet | /extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/* |      | 200           | IDLE             | $.[?(@.configurationName=='HdfsCataloger')].status |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                  | body | response code | response message |
#      |        |       |       | Post | /extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/* |      | 200           |                  |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                   | body | response code | response message | jsonPath                                           |
#      |        |       |       | RecursiveGet | /extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/* |      | 200           | IDLE             | $.[?(@.configurationName=='HdfsCataloger')].status |
#    And user makes a REST Call for Get request with url "extensions/analyzers/history/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger"
#    Then Old Analysis log should get displayed in response
#
#
##  @MLP-4633 @positive @IDC10.0 @sanity @webtest
##  Scenario:MLP-4633_Verification of deleting a plugin and adding it again with same configuration
##    Given User launch browser and traverse to login page
##    And user enter credentials for "System Administrator" role
##    And user clicks on Administration widget
##    And user clicks on Plugin Manager in Administration dashboard
##    And user clicks on "Cluster Demo" from nodes list
##    And user verifies whether "HdfsCataloger" is present in the plugins list and unassigns it
##    And user click save button in Create New Node page
##    And A query param with "" and "" and supply authorized users, contentType and Accept headers
##    And Execute REST API with following parameters
##      | Header | Query | Param | type | url                               | body                                                         | response code | response message |
##      |        |       |       | Put  | /settings/analyzers/HdfsCataloger | ida/bigdataAnalyzerPayloads/bigdataAnalyzer_hdfs_config.json | 204           |                  |
##    And Execute REST API with following parameters
##      | Header | Query | Param | type | url                               | body | response code | response message |
##      |        |       |       | Get  | /settings/analyzers/HdfsCataloger |      | 200           | HdfsCataloger    |
##    And Execute REST API with following parameters
##      | Header | Query | Param | type         | url                                                                   | body | response code | response message | jsonPath                                           |
##      |        |       |       | RecursiveGet | /extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/* |      | 200           | IDLE             | $.[?(@.configurationName=='HdfsCataloger')].status |
##    And Execute REST API with following parameters
##      | Header | Query | Param | type | url                                                                  | body | response code | response message |
##      |        |       |       | Post | /extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/* |      | 200           |                  |
##    And Execute REST API with following parameters
##      | Header | Query | Param | type         | url                                                                   | body | response code | response message | jsonPath                                           |
##      |        |       |       | RecursiveGet | /extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/* |      | 200           | IDLE             | $.[?(@.configurationName=='HdfsCataloger')].status |
##    And user makes a REST Call for Get request with url "extensions/analyzers/history/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger" and store value of json path"$.[-1:].name"
##    And user enters the Analysis job name in Search text box and click Search
##    And user iterate and click exact Analysis log from search results
##    And user makes a REST Call for Get request with url "extensions/analyzers/history/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger" and store value of json path"$.[-1:].id"
##    And user makes a REST Call for Get request with url "/searches/BigData/query/AnalysisHistoryLog?limit=0&param=id%3DBigData.Analysis%3A%3A%3A" with value retrieved from json response
##    And user get the value from response using json path "$..data" and decode the value
##    And user clicks on log link and opens the log
##    Then Log text in UI and decoded text should be same
#
##  @MLP-4633 @positive @IDC10.0 @sanity @webtest
##  Scenario: MLP-4633_Verification of adding plugin under new node
##    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
##    And Execute REST API with following parameters
##      | Header | Query | Param | type | url                          | body                               | response code | response message |
##      |        |       |       | Put  | /settings/analyzers/hostName | ida/git_collector_repo_config.json | 204           |                  |
##    And Execute REST API with following parameters
##      | Header | Query | Param | type | url                          | body | response code | response message           |
##      |        |       |       | Get  | /settings/analyzers/hostName |      | 200           | Bitbucket AnalysisDemoData |
##    And Execute REST API with following parameters
##      | Header | Query | Param | type         | url                                                            | body | response code | response message | jsonPath                                                        |
##      |        |       |       | RecursiveGet | /extensions/analyzers/status/hostName/collector/GitCollector/* |      | 200           | IDLE             | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
##    And Execute REST API with following parameters
##      | Header | Query | Param | type | url                                                           | body | response code | response message |
##      |        |       |       | Post | /extensions/analyzers/start/hostName/collector/GitCollector/* |      | 200           |                  |
##    And Execute REST API with following parameters
##      | Header | Query | Param | type         | url                                                            | body | response code | response message | jsonPath                                                        |
##      |        |       |       | RecursiveGet | /extensions/analyzers/status/hostName/collector/GitCollector/* |      | 200           | IDLE             | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
##    And user makes a REST Call for Get request with url "extensions/analyzers/history/hostName/collector/GitCollector/Bitbucket%20AnalysisDemoData" and store value of json path"$.[-1:].name"
##    And User launch browser and traverse to login page
##    And user enter credentials for "System Administrator" role
##    And user enters the Analysis job name in Search text box and click Search
##    And user iterate and click exact Analysis log from search results
##    And user makes a REST Call for Get request with url "extensions/analyzers/history/hostName/collector/GitCollector/Bitbucket%20AnalysisDemoData" and store value of json path"$.[-1:].id"
##    And user makes a REST Call for Get request with url "/searches/Analysis/query/AnalysisHistoryLog?limit=0&param=id%3DAnalysis.Analysis%3A%3A%3A" with value retrieved from json response
##    And user get the value from response using json path "$..data" and decode the value
##    And user clicks on log link and opens the log
##    Then Log text in UI and decoded text should be same
#
#  @MLP-4633 @positive @IDC10.0 @sanity @webtest
#  Scenario: MLP-4633_Verification of adding plugin under Internal node
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                              | body                               | response code | response message |
#      |        |       |       | Put  | /settings/analyzers/GitCollector | ida/git_collector_repo_config.json | 204           |                  |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                              | body | response code | response message           | jsonPath                                                        |
#      |        |       |       | Get  | /settings/analyzers/GitCollector |      | 200           | Bitbucket AnalysisDemoData | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                | body | response code | response message |
#      |        |       |       | RecursiveGet | /extensions/analyzers/status/InternalNode/collector/GitCollector/* |      | 200           | IDLE             |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                               | body | response code | response message |
#      |        |       |       | Post | /extensions/analyzers/start/InternalNode/collector/GitCollector/* |      | 200           |                  |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                | body | response code | response message | jsonPath                                                        |
#      |        |       |       | RecursiveGet | /extensions/analyzers/status/InternalNode/collector/GitCollector/* |      | 200           | IDLE             | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
#    And user makes a REST Call for Get request with url "extensions/analyzers/history/InternalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData" and store value of json path"$.[-1:].name"
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And user enters the Analysis job name in Search text box and click Search
#    And user iterate and click exact Analysis log from search results
#    And user makes a REST Call for Get request with url "extensions/analyzers/history/InternalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData" and store value of json path"$.[-1:].id"
#    And user makes a REST Call for Get request with url "/searches/Analysis/query/AnalysisHistoryLog?limit=0&param=id%3DAnalysis.Analysis%3A%3A%3A" with value retrieved from json response
#    And user get the value from response using json path "$..data" and decode the value
#    And user clicks on log link and opens the log
#    Then Log text in UI and decoded text should be same
#
#
#  @MLP-4633 @positive @IDC10.0 @sanity @webtest
#  Scenario: MLP-4633_Verification of editing plugin configuration name and getting history
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                               | body                                        | response code | response message |
#      |        |       |       | Put  | /settings/analyzers/HdfsCataloger | ida/bigdataAnalyzer_hdfs_config_rename.json | 204           |                  |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                               | body | response code | response message     |
#      |        |       |       | Get  | /settings/analyzers/HdfsCataloger |      | 200           | HdfsCatalogerRenamed |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                   | body | response code | response message | jsonPath                                                  |
#      |        |       |       | RecursiveGet | /extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/* |      | 200           | IDLE             | $.[?(@.configurationName=='HdfsCatalogerRenamed')].status |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                  | body | response code | response message |
#      |        |       |       | Post | /extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/* |      | 200           |                  |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                   | body | response code | response message | jsonPath                                                  |
#      |        |       |       | RecursiveGet | /extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/* |      | 200           | IDLE             | $.[?(@.configurationName=='HdfsCatalogerRenamed')].status |
#    And user makes a REST Call for Get request with url "extensions/analyzers/history/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCatalogerRenamed" and store value of json path"$.[-1:].name"
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And user enters the Analysis job name in Search text box and click Search
#    And user iterate and click exact Analysis log from search results
#    And user makes a REST Call for Get request with url "extensions/analyzers/history/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCatalogerRenamed" and store value of json path"$.[-1:].id"
#    And user makes a REST Call for Get request with url "/searches/BigData/query/AnalysisHistoryLog?limit=0&param=id%3DBigData.Analysis%3A%3A%3A" with value retrieved from json response
#    And user get the value from response using json path "$..data" and decode the value
#    And user clicks on log link and opens the log
#    Then Log text in UI and decoded text should be same
#
#
#  @MLP-4633 @positive @IDC10.0 @sanity @webtest
#  Scenario: MLP-4633_Verification of adding multiple configuration and checking logs
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                               | body                                                | response code | response message |
#      |        |       |       | Put  | /settings/analyzers/HdfsCataloger | ida/bigdataAnalyzer_hdfs_config_multipleconfig.json | 204           |                  |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                               | body | response code | response message |
#      |        |       |       | Get  | /settings/analyzers/HdfsCataloger |      | 200           | HdfsCatalogerOne |
#      |        |       |       | Get  | /settings/analyzers/HdfsCataloger |      | 200           | HdfsCatalogerTwo |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                   | body | response code | response message | jsonPath                                              |
#      |        |       |       | RecursiveGet | /extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/* |      | 200           | IDLE             | $.[?(@.configurationName=='HdfsCatalogerOne')].status |
#      |        |       |       | RecursiveGet | /extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/* |      | 200           | IDLE             | $.[?(@.configurationName=='HdfsCatalogerTwo')].status |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                  | body | response code | response message |
#      |        |       |       | Post | /extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/* |      | 200           |                  |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                   | body | response code | response message | jsonPath                                              |
#      |        |       |       | RecursiveGet | /extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/* |      | 200           | IDLE             | $.[?(@.configurationName=='HdfsCatalogerOne')].status |
#      |        |       |       | RecursiveGet | /extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/* |      | 200           | IDLE             | $.[?(@.configurationName=='HdfsCatalogerTwo')].status |
#    And user makes a REST Call for Get request with url "extensions/analyzers/history/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCatalogerOne" and store value of json path"$.[-1:].name"
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And user enters the Analysis job name in Search text box and click Search
#    And user iterate and click exact Analysis log from search results
#    And user makes a REST Call for Get request with url "extensions/analyzers/history/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCatalogerOne" and store value of json path"$.[-1:].id"
#    And user makes a REST Call for Get request with url "/searches/BigData/query/AnalysisHistoryLog?limit=0&param=id%3DBigData.Analysis%3A%3A%3A" with value retrieved from json response
#    And user get the value from response using json path "$..data" and decode the value
#    And user clicks on log link and opens the log
#    Then Log text in UI and decoded text should be same
#    And user makes a REST Call for Get request with url "extensions/analyzers/history/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCatalogerTwo" and store value of json path"$.[-1:].name"
#    And user enters the Analysis job name in Search text box and click Search
#    And user iterate and click exact Analysis log from search results
#    And user makes a REST Call for Get request with url "extensions/analyzers/history/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCatalogerTwo" and store value of json path"$.[-1:].id"
#    And user makes a REST Call for Get request with url "/searches/BigData/query/AnalysisHistoryLog?limit=0&param=id%3DBigData.Analysis%3A%3A%3A" with value retrieved from json response
#    And user get the value from response using json path "$..data" and decode the value
#    And user clicks on log link and opens the log
#    Then Log text in UI and decoded text should be same
#
#  @MLP-4633 @positive @IDC10.0 @sanity @webtest
#  Scenario:MLP-4633_Verification of removing the advance solr search
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
##    And user configure the advance search for the login
#    And user clicks on logout button