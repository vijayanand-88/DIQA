Feature: Feature to validate the Filter pattern through the Collector plugin


  @webtest @1397 @sanity @positive
  Scenario: Run Collector plugin with Inclusion filter with exact file name and validate source count collected in IDA UI.
    Given I create "Analysis" widget for "TestServiceUser" role
    And I create a dashboard with name "IDA" and add "Analysis" widget for "TestServiceUser" role
#    And user update the plugin config "ida/pluginConfigWithFilterpattern.json" from default plugin config "ida/filter_Pattern_Repo.json" with following values
#      | fileMode       | expressionType    | expressions | objectType           |
#      | configurations | GitCollector      | 0           | simpleIncludePattern |
    And Execute REST API with following parameters
      | Header           | Query | Param | type | url                         | body                                                      | response code | response message                                                 |
      | application/json | raw   | false | Put  | settings/analyzers/hostName | ida/gitFilterPayloads/incfilterpattern_exactfilename.json | 204           | https://source-team.asg.com/scm/diqa/test_data_git_collector.git |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                         | body | response code | response message                  |
      |        |       |       | Get  | settings/analyzers/hostName |      | 200           | Bitbucket Analysis Filter Pattern |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                                                                                                | body | response code | response message |
      |        |       |       | Post | extensions/analyzers/start/hostName/collector/GitCollector/Bitbucket%20Analysis%20Filter%20Pattern |      | 200           |                  |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                                                 | body | response code | response message |
      |        |       |       | RecursiveGet | extensions/analyzers/status/hostName/collector/GitCollector/Bitbucket%20Analysis%20Filter%20Pattern |      | 200           | IDLE             |
    And configure a new REST API for the service "BitBucket"
    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/Test_Data_Git_Collector/files?limit=10000"
    And User gets the "pom.xml" included file count from bitbucket repository
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And login must be successful for all users
    When User clicks on IDA dashboard
    And user click on the collector analysis link and open the log
    Then filepattern count from Bitbucket repository and IDA UI should match .


  @webtest @1397 @sanity @positive
  Scenario: Run Collector plugin with Inclusion filter with .java extension and validate source count collected in IDA UI.
    Given I create "Analysis" widget for "TestServiceUser" role
    And I create a dashboard with name "IDA" and add "Analysis" widget for "TestServiceUser" role
#    And user update the plugin config "ida/pluginConfigWithFilterpattern.json" from default plugin config "ida/filter_Pattern_Repo.json" with following values
#      | jsonObject     | jsonArray    | index | configName           | configValue |
#      | configurations | GitCollector | 0     | simpleIncludePattern | *.java      |
    And Execute REST API with following parameters
      | Header           | Query | Param | type | url                         | body                                                      | response code | response message                                                 |
      | application/json | raw   | false | Put  | settings/analyzers/hostName | ida/gitFilterPayloads/incfilterpattern_javaextension.json | 204           | https://source-team.asg.com/scm/diqa/test_data_git_collector.git |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                         | body | response code | response message                  |
      |        |       |       | Get  | settings/analyzers/hostName |      | 200           | Bitbucket Analysis Filter Pattern |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                                                                                                | body | response code | response message |
      |        |       |       | Post | extensions/analyzers/start/hostName/collector/GitCollector/Bitbucket%20Analysis%20Filter%20Pattern |      | 200           |                  |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                                                 | body | response code | response message |
      |        |       |       | RecursiveGet | extensions/analyzers/status/hostName/collector/GitCollector/Bitbucket%20Analysis%20Filter%20Pattern |      | 200           | IDLE             |
    And configure a new REST API for the service "BitBucket"
    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/Test_Data_Git_Collector/files?limit=10000"
    And User gets the ".java" included file count from bitbucket repository
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And login must be successful for all users
    When User clicks on IDA dashboard
    And user click on the collector analysis link and open the log
    Then filepattern count from Bitbucket repository and IDA UI should match .


  @webtest @1397 @sanity @positive
  Scenario:Run Collector plugin with Inclusion filter for file name with prefix 'Bye' and validate source count collected in IDA UI.
    Given I create "Analysis" widget for "TestServiceUser" role
    And I create a dashboard with name "IDA" and add "Analysis" widget for "TestServiceUser" role
#    And user update the plugin config "ida/pluginConfigWithFilterpattern.json" from default plugin config "ida/filter_Pattern_Repo.json" with following values
#      | jsonObject     | jsonArray    | index | configName           | configValue |
#      | configurations | GitCollector | 0     | simpleIncludePattern | Bye*.*      |
    And Execute REST API with following parameters
      | Header           | Query | Param | type | url                         | body                                               | response code | response message                                                 |
      | application/json | raw   | false | Put  | settings/analyzers/hostName | ida/gitFilterPayloads/incfilterpattern_prefix.json | 204           | https://source-team.asg.com/scm/diqa/test_data_git_collector.git |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                         | body | response code | response message                  |
      |        |       |       | Get  | settings/analyzers/hostName |      | 200           | Bitbucket Analysis Filter Pattern |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                                                                                                | body | response code | response message |
      |        |       |       | Post | extensions/analyzers/start/hostName/collector/GitCollector/Bitbucket%20Analysis%20Filter%20Pattern |      | 200           |                  |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                                                 | body | response code | response message |
      |        |       |       | RecursiveGet | extensions/analyzers/status/hostName/collector/GitCollector/Bitbucket%20Analysis%20Filter%20Pattern |      | 200           | IDLE             |
    And configure a new REST API for the service "BitBucket"
    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/Test_Data_Git_Collector/files?limit=10000"
    And User gets the "Bye*.*" included file count from bitbucket repository
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And login must be successful for all users
    When User clicks on IDA dashboard
    And user click on the collector analysis link and open the log
    Then filepattern count from Bitbucket repository and IDA UI should match .


  @webtest @1397 @sanity @positive
  Scenario: Run Collector plugin with inclusion filter with regex and validate source count collected in IDA UI.
    Given I create "Analysis" widget for "TestServiceUser" role
    And I create a dashboard with name "IDA" and add "Analysis" widget for "TestServiceUser" role
#    And user update the plugin config "ida/pluginConfigWithFilterpattern.json" from default plugin config "ida/filter_Pattern_Repo.json" with following values
#      | jsonObject     | jsonArray    | index | configName          | configValue |
#      | configurations | GitCollector | 0     | regexIncludePattern | .*\\.c[sS]$ |
    And Execute REST API with following parameters
      | Header           | Query | Param | type | url                         | body                                                        | response code | response message                                                 |
      | application/json | raw   | false | Put  | settings/analyzers/hostName | ida/gitFilterPayloads/incfilterpattern_filterWithRegex.json | 204           | https://source-team.asg.com/scm/diqa/test_data_git_collector.git |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                         | body | response code | response message                  |
      |        |       |       | Get  | settings/analyzers/hostName |      | 200           | Bitbucket Analysis Filter Pattern |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                                                                                                | body | response code | response message |
      |        |       |       | Post | extensions/analyzers/start/hostName/collector/GitCollector/Bitbucket%20Analysis%20Filter%20Pattern |      | 200           |                  |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                                                 | body | response code | response message |
      |        |       |       | RecursiveGet | extensions/analyzers/status/hostName/collector/GitCollector/Bitbucket%20Analysis%20Filter%20Pattern |      | 200           | IDLE             |
    And configure a new REST API for the service "BitBucket"
    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/Test_Data_Git_Collector/files?limit=10000"
    And User gets the "\\*.c[sS]$" included file count from bitbucket repository
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And login must be successful for all users
    When User clicks on IDA dashboard
    And user click on the collector analysis link and open the log
    Then filepattern count from Bitbucket repository and IDA UI should match .

  @webtest @1397 @sanity @positive
  Scenario:Run Collector plugin  simple inclusion filter with multiple regex pattern and validate source count collected in IDA UI.
    Given I create "Analysis" widget for "TestServiceUser" role
    And I create a dashboard with name "IDA" and add "Analysis" widget for "TestServiceUser" role
#    And user update the plugin config "ida/pluginConfigWithFilterpattern.json" from default plugin config "ida/filter_Pattern_Repo.json" with following values
#      | jsonObject     | jsonArray    | index | configName          | configValue                   |
#      | configurations | GitCollector | 0     | regexIncludePattern | .*\\.cpp$\|.*\\.h$\|.*\\.java |
    And Execute REST API with following parameters
      | Header           | Query | Param | type | url                         | body                                                                     | response code | response message                                                 |
      | application/json | raw   | false | Put  | settings/analyzers/hostName | ida/gitFilterPayloads/incfilterpattern_simpleInclusionMultipleRegex.json | 204           | https://source-team.asg.com/scm/diqa/test_data_git_collector.git |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                         | body | response code | response message                  |
      |        |       |       | Get  | settings/analyzers/hostName |      | 200           | Bitbucket Analysis Filter Pattern |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                                                                                                | body | response code | response message |
      |        |       |       | Post | extensions/analyzers/start/hostName/collector/GitCollector/Bitbucket%20Analysis%20Filter%20Pattern |      | 200           |                  |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                                                 | body | response code | response message |
      |        |       |       | RecursiveGet | extensions/analyzers/status/hostName/collector/GitCollector/Bitbucket%20Analysis%20Filter%20Pattern |      | 200           | IDLE             |
    And configure a new REST API for the service "BitBucket"
    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/Test_Data_Git_Collector/files?limit=10000"
    And User gets the "\\*(.cpp|.h|.java)$" included file count from bitbucket repository
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And login must be successful for all users
    When User clicks on IDA dashboard
    And user click on the collector analysis link and open the log
    Then filepattern count from Bitbucket repository and IDA UI should match .


  @webtest @1397 @sanity @positive
  Scenario:Run Collector plugin  regex inclusion filter with multiple regex pattern and validate source count collected in IDA UI.
    Given I create "Analysis" widget for "TestServiceUser" role
    And I create a dashboard with name "IDA" and add "Analysis" widget for "TestServiceUser" role
#    And user update the plugin config "ida/pluginConfigWithFilterpattern.json" from default plugin config "ida/filter_Pattern_Repo.json" with following values
#      | jsonObject     | jsonArray    | index | configName          | configValue    |
#      | configurations | GitCollector | 0     | regexIncludePattern | \\*(.cpp\|.h)$ |
    And Execute REST API with following parameters
      | Header           | Query | Param | type | url                         | body                                                                 | response code | response message                                                 |
      | application/json | raw   | false | Put  | settings/analyzers/hostName | ida/gitFilterPayloads/incfilterpattern_regexwithmultiplepattern.json | 204           | https://source-team.asg.com/scm/diqa/test_data_git_collector.git |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                         | body | response code | response message                  |
      |        |       |       | Get  | settings/analyzers/hostName |      | 200           | Bitbucket Analysis Filter Pattern |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                                                                                                | body | response code | response message |
      |        |       |       | Post | extensions/analyzers/start/hostName/collector/GitCollector/Bitbucket%20Analysis%20Filter%20Pattern |      | 200           |                  |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                                                 | body | response code | response message |
      |        |       |       | RecursiveGet | extensions/analyzers/status/hostName/collector/GitCollector/Bitbucket%20Analysis%20Filter%20Pattern |      | 200           | IDLE             |
    And configure a new REST API for the service "BitBucket"
    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/Test_Data_Git_Collector/files?limit=10000"
    And User gets the "\\*(.cpp\|.h)$" included file count from bitbucket repository
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And login must be successful for all users
    When User clicks on IDA dashboard
    And user click on the collector analysis link and open the log
    Then filepattern count from Bitbucket repository and IDA UI should match .


  @webtest @1397 @sanity @positive
  Scenario:Run Collector plugin with Inclusion filter with multiple extension  and validate source count collected in IDA UI.
    Given I create "Analysis" widget for "TestServiceUser" role
    And I create a dashboard with name "IDA" and add "Analysis" widget for "TestServiceUser" role
#    And user update the plugin config "ida/pluginConfigWithFilterpattern.json" from default plugin config "ida/filter_Pattern_Repo.json" with following values
#      | jsonObject     | jsonArray    | index | configName           | configValue                  |
#      | configurations | GitCollector | 0     | simpleIncludePattern | FileName.extension.extension |
    And Execute REST API with following parameters
      | Header           | Query | Param | type | url                         | body                                                          | response code | response message                                                 |
      | application/json | raw   | false | Put  | settings/analyzers/hostName | ida/gitFilterPayloads/incfilterpattern_multipleExtension.json | 204           | https://source-team.asg.com/scm/diqa/test_data_git_collector.git |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                         | body | response code | response message                  |
      |        |       |       | Get  | settings/analyzers/hostName |      | 200           | Bitbucket Analysis Filter Pattern |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                                                                                                | body | response code | response message |
      |        |       |       | Post | extensions/analyzers/start/hostName/collector/GitCollector/Bitbucket%20Analysis%20Filter%20Pattern |      | 200           |                  |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                                                 | body | response code | response message |
      |        |       |       | RecursiveGet | extensions/analyzers/status/hostName/collector/GitCollector/Bitbucket%20Analysis%20Filter%20Pattern |      | 200           | IDLE             |
    And configure a new REST API for the service "BitBucket"
    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/Test_Data_Git_Collector/files?limit=10000"
    And User gets the "FileName.extension.extension " included file count from bitbucket repository
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And login must be successful for all users
    When User clicks on IDA dashboard
    And user click on the collector analysis link and open the log
    Then filepattern count from Bitbucket repository and IDA UI should match .


  @webtest @1397 @sanity @positive
  Scenario:Run Collector plugin with Inclusion filter with blank file pattern and validate source count collected in IDA UI.
    Given I create "Analysis" widget for "TestServiceUser" role
    And I create a dashboard with name "IDA" and add "Analysis" widget for "TestServiceUser" role
#    And user update the plugin config "ida/pluginConfigWithFilterpattern.json" from default plugin config "ida/filter_Pattern_Repo.json" with following values
#      | jsonObject     | jsonArray    | index | configName           | configValue |
#      | configurations | GitCollector | 0     | simpleIncludePattern |             |
    And Execute REST API with following parameters
      | Header           | Query | Param | type | url                         | body                                                    | response code | response message                                                 |
      | application/json | raw   | false | Put  | settings/analyzers/hostName | ida/gitFilterPayloads/incfilterpattern_blankfilter.json | 204           | https://source-team.asg.com/scm/diqa/test_data_git_collector.git |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                         | body | response code | response message                  |
      |        |       |       | Get  | settings/analyzers/hostName |      | 200           | Bitbucket Analysis Filter Pattern |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                                                                                                | body | response code | response message |
      |        |       |       | Post | extensions/analyzers/start/hostName/collector/GitCollector/Bitbucket%20Analysis%20Filter%20Pattern |      | 200           |                  |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                                                 | body | response code | response message |
      |        |       |       | RecursiveGet | extensions/analyzers/status/hostName/collector/GitCollector/Bitbucket%20Analysis%20Filter%20Pattern |      | 200           | IDLE             |
    And configure a new REST API for the service "BitBucket"
    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/Test_Data_Git_Collector/files?limit=10000"
    And User gets the "\\*" included file count from bitbucket repository
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And login must be successful for all users
    When User clicks on IDA dashboard
    And user click on the collector analysis link and open the log
    Then filepattern count from Bitbucket repository and IDA UI should match .


  @webtest @1397 @sanity @positive
  Scenario:Run Collector plugin with Exclude filter with  exact file name and validate source count collected in IDA UI.
    Given I create "Analysis" widget for "TestServiceUser" role
    And I create a dashboard with name "IDA" and add "Analysis" widget for "TestServiceUser" role
#    And user update the plugin config "ida/pluginConfigWithFilterpattern.json" from default plugin config "ida/filter_Pattern_Repo.json" with following values
#      | jsonObject     | jsonArray    | index | configName           | configValue |
#      | configurations | GitCollector | 0     | simpleExcludePattern | pom.xml     |
    And Execute REST API with following parameters
      | Header           | Query | Param | type | url                         | body                                                      | response code | response message                                                 |
      | application/json | raw   | false | Put  | settings/analyzers/hostName | ida/gitFilterPayloads/excfilterpattern_exactfilename.json | 204           | https://source-team.asg.com/scm/diqa/test_data_git_collector.git |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                         | body | response code | response message                  |
      |        |       |       | Get  | settings/analyzers/hostName |      | 200           | Bitbucket Analysis Filter Pattern |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                                                                                                | body | response code | response message |
      |        |       |       | Post | extensions/analyzers/start/hostName/collector/GitCollector/Bitbucket%20Analysis%20Filter%20Pattern |      | 200           |                  |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                                                 | body | response code | response message |
      |        |       |       | RecursiveGet | extensions/analyzers/status/hostName/collector/GitCollector/Bitbucket%20Analysis%20Filter%20Pattern |      | 200           | IDLE             |
    And configure a new REST API for the service "BitBucket"
    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/Test_Data_Git_Collector/files?limit=10000"
    And User gets the "pom.xml" excluded file count from bitbucket repository
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And login must be successful for all users
    When User clicks on IDA dashboard
    And user click on the collector analysis link and open the log
    Then filepattern count from Bitbucket repository and IDA UI should match .


  @webtest @1397 @sanity @positive
  Scenario:Run Collector plugin with Exclude filter with .java extension and validate source count collected in IDA UI.
    Given I create "Analysis" widget for "TestServiceUser" role
    And I create a dashboard with name "IDA" and add "Analysis" widget for "TestServiceUser" role
#    And user update the plugin config "ida/pluginConfigWithFilterpattern.json" from default plugin config "ida/filter_Pattern_Repo.json" with following values
#      | jsonObject     | jsonArray    | index | configName           | configValue |
#      | configurations | GitCollector | 0     | simpleExcludePattern | *.java      |
    And Execute REST API with following parameters
      | Header           | Query | Param | type | url                         | body                                                      | response code | response message                                                 |
      | application/json | raw   | false | Put  | settings/analyzers/hostName | ida/gitFilterPayloads/excfilterpattern_javaextension.json | 204           | https://source-team.asg.com/scm/diqa/test_data_git_collector.git |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                         | body | response code | response message                  |
      |        |       |       | Get  | settings/analyzers/hostName |      | 200           | Bitbucket Analysis Filter Pattern |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                                                                                                | body | response code | response message |
      |        |       |       | Post | extensions/analyzers/start/hostName/collector/GitCollector/Bitbucket%20Analysis%20Filter%20Pattern |      | 200           |                  |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                                                 | body | response code | response message |
      |        |       |       | RecursiveGet | extensions/analyzers/status/hostName/collector/GitCollector/Bitbucket%20Analysis%20Filter%20Pattern |      | 200           | IDLE             |
    And configure a new REST API for the service "BitBucket"
    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/Test_Data_Git_Collector/files?limit=10000"
    And User gets the ".java" excluded file count from bitbucket repository
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And login must be successful for all users
    When User clicks on IDA dashboard
    And user click on the collector analysis link and open the log
    Then filepattern count from Bitbucket repository and IDA UI should match .

  @webtest @1397 @sanity @positive
  Scenario:Run Collector plugin with Exclude filter for file name with prefix 'Bye' and validate source count collected in IDA UI.
    Given I create "Analysis" widget for "TestServiceUser" role
    And I create a dashboard with name "IDA" and add "Analysis" widget for "TestServiceUser" role
#    And user update the plugin config "ida/pluginConfigWithFilterpattern.json" from default plugin config "ida/filter_Pattern_Repo.json" with following values
#      | jsonObject     | jsonArray    | index | configName           | configValue |
#      | configurations | GitCollector | 0     | simpleExcludePattern | Bye*.*      |
    And Execute REST API with following parameters
      | Header           | Query | Param | type | url                         | body                                               | response code | response message                                                 |
      | application/json | raw   | false | Put  | settings/analyzers/hostName | ida/gitFilterPayloads/excfilterpattern_prefix.json | 204           | https://source-team.asg.com/scm/diqa/test_data_git_collector.git |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                         | body | response code | response message                  |
      |        |       |       | Get  | settings/analyzers/hostName |      | 200           | Bitbucket Analysis Filter Pattern |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                                                                                                | body | response code | response message |
      |        |       |       | Post | extensions/analyzers/start/hostName/collector/GitCollector/Bitbucket%20Analysis%20Filter%20Pattern |      | 200           |                  |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                                                 | body | response code | response message |
      |        |       |       | RecursiveGet | extensions/analyzers/status/hostName/collector/GitCollector/Bitbucket%20Analysis%20Filter%20Pattern |      | 200           | IDLE             |
    And configure a new REST API for the service "BitBucket"
    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/Test_Data_Git_Collector/files?limit=10000"
    And User gets the "Bye*.*" excluded file count from bitbucket repository
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And login must be successful for all users
    When User clicks on IDA dashboard
    And user click on the collector analysis link and open the log
    Then filepattern count from Bitbucket repository and IDA UI should match .


  @webtest @1397 @sanity @positive
  Scenario:Run Collector plugin with Exclude filter with regex and validate source count collected in IDA UI.
    Given I create "Analysis" widget for "TestServiceUser" role
    And I create a dashboard with name "IDA" and add "Analysis" widget for "TestServiceUser" role
#    And user update the plugin config "ida/pluginConfigWithFilterpattern.json" from default plugin config "ida/filter_Pattern_Repo.json" with following values
#      | jsonObject     | jsonArray    | index | configName          | configValue |
#      | configurations | GitCollector | 0     | regexExcludePattern | .*\\.c[sS]$ |
    And Execute REST API with following parameters
      | Header           | Query | Param | type | url                         | body                                                        | response code | response message                                                 |
      | application/json | raw   | false | Put  | settings/analyzers/hostName | ida/gitFilterPayloads/excfilterpattern_filterWithRegex.json | 204           | https://source-team.asg.com/scm/diqa/test_data_git_collector.git |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                         | body | response code | response message                  |
      |        |       |       | Get  | settings/analyzers/hostName |      | 200           | Bitbucket Analysis Filter Pattern |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                                                                                                | body | response code | response message |
      |        |       |       | Post | extensions/analyzers/start/hostName/collector/GitCollector/Bitbucket%20Analysis%20Filter%20Pattern |      | 200           |                  |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                                                 | body | response code | response message |
      |        |       |       | RecursiveGet | extensions/analyzers/status/hostName/collector/GitCollector/Bitbucket%20Analysis%20Filter%20Pattern |      | 200           | IDLE             |
    And configure a new REST API for the service "BitBucket"
    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/Test_Data_Git_Collector/files?limit=10000"
    And User gets the "\\*.c[sS]$" excluded file count from bitbucket repository
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And login must be successful for all users
    When User clicks on IDA dashboard
    And user click on the collector analysis link and open the log
    Then filepattern count from Bitbucket repository and IDA UI should match .

  @webtest @1397 @sanity @positive
  Scenario:Run Collector plugin  simple Exclude filter with multiple regex pattern and validate source count collected in IDA UI.
    Given I create "Analysis" widget for "TestServiceUser" role
    And I create a dashboard with name "IDA" and add "Analysis" widget for "TestServiceUser" role
#    And user update the plugin config "ida/pluginConfigWithFilterpattern.json" from default plugin config "ida/filter_Pattern_Repo.json" with following values
#      | jsonObject     | jsonArray    | index | configName           | configValue        |
#      | configurations | GitCollector | 0     | simpleExcludePattern | *.cpp\|*.h\|*.java |
    And Execute REST API with following parameters
      | Header           | Query | Param | type | url                         | body                                                                     | response code | response message                                                 |
      | application/json | raw   | false | Put  | settings/analyzers/hostName | ida/gitFilterPayloads/excfilterpattern_simpleInclusionMultipleRegex.json | 204           | https://source-team.asg.com/scm/diqa/test_data_git_collector.git |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                         | body | response code | response message                  |
      |        |       |       | Get  | settings/analyzers/hostName |      | 200           | Bitbucket Analysis Filter Pattern |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                                                                                                | body | response code | response message |
      |        |       |       | Post | extensions/analyzers/start/hostName/collector/GitCollector/Bitbucket%20Analysis%20Filter%20Pattern |      | 200           |                  |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                                                 | body | response code | response message |
      |        |       |       | RecursiveGet | extensions/analyzers/status/hostName/collector/GitCollector/Bitbucket%20Analysis%20Filter%20Pattern |      | 200           | IDLE             |
    And configure a new REST API for the service "BitBucket"
    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/Test_Data_Git_Collector/files?limit=10000"
    And User gets the "\\*(.cpp|.h|.java)$" excluded file count from bitbucket repository
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And login must be successful for all users
    When User clicks on IDA dashboard
    And user click on the collector analysis link and open the log
    Then filepattern count from Bitbucket repository and IDA UI should match .


  @webtest @1397 @sanity @positive
  Scenario:Run Collector plugin  regex Exclude filter with multiple regex pattern and validate source count collected in IDA UI.
    Given I create "Analysis" widget for "TestServiceUser" role
    And I create a dashboard with name "IDA" and add "Analysis" widget for "TestServiceUser" role
#    And user update the plugin config "ida/pluginConfigWithFilterpattern.json" from default plugin config "ida/filter_Pattern_Repo.json" with following values
#      | jsonObject     | jsonArray    | index | configName          | configValue     |
#      | configurations | GitCollector | 0     | regexExcludePattern | *(\\.cpp$\|.h$) |
    And Execute REST API with following parameters
      | Header           | Query | Param | type | url                         | body                                                                 | response code | response message                                                 |
      | application/json | raw   | false | Put  | settings/analyzers/hostName | ida/gitFilterPayloads/excfilterpattern_regexwithmultiplepattern.json | 204           | https://source-team.asg.com/scm/diqa/test_data_git_collector.git |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                         | body | response code | response message                  |
      |        |       |       | Get  | settings/analyzers/hostName |      | 200           | Bitbucket Analysis Filter Pattern |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                                                                                                | body | response code | response message |
      |        |       |       | Post | extensions/analyzers/start/hostName/collector/GitCollector/Bitbucket%20Analysis%20Filter%20Pattern |      | 200           |                  |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                                                 | body | response code | response message |
      |        |       |       | RecursiveGet | extensions/analyzers/status/hostName/collector/GitCollector/Bitbucket%20Analysis%20Filter%20Pattern |      | 200           | IDLE             |
    And configure a new REST API for the service "BitBucket"
    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/Test_Data_Git_Collector/files?limit=10000"
    And User gets the "\\*(.cpp|.h)$" excluded file count from bitbucket repository
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And login must be successful for all users
    When User clicks on IDA dashboard
    And user click on the collector analysis link and open the log
    Then filepattern count from Bitbucket repository and IDA UI should match .