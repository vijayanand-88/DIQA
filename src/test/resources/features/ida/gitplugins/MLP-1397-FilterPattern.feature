#Feature: Feature to validate the Filter pattern through the Collector plugin
#
#  Background: Update ingestion configuration for collector plugin
#    Given I send series of requests for an operation
#      | requestConfig                  | responseConfig                         | responseRequiredOnNextCall | valueToUpdate            |
#      | getIngestionConfiguration.json | validateGetIngestionConfiguration.json | Yes                        | deleteFilterPattern.json |
#      | putIngestionConfiguration.json | validatePutIngestionConfiguration.json | No                         | Nil                      |
#
#  @sanity @positive
#  Scenario: Update the repository for filter use cases
#    Given I send series of requests for an operation
#      | requestConfig                  | responseConfig                         | responseRequiredOnNextCall | valueToUpdate                |
#      | getIngestionConfiguration.json | validateGetIngestionConfiguration.json | Yes                        | updateRepoDataForFilter.json |
#      | putIngestionConfiguration.json | validatePutIngestionConfiguration.json | No                         | Nil                          |
#
#  @webtest @1397 @sanity @positive
#  Scenario:Run Collector plugin with Inclusion filter with exact file name and validate source count collected in IDA UI.
#    Given I create "Analysis" widget for "TestServiceUser" role
#    And I update the ingestion configuration for "TestServiceUser" role
#      | pathToConfig                     | configName           | configValue |
#      | $.configurations.GitCollector[0] | simpleIncludePattern | pom.xml     |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                          | body | response code | response message |
#      |        |       |       | Post | extensions/analyzers/start/hostName/collector/GitCollector/* |      | 200           |                  |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                           | body | response code | response message |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/hostName/collector/GitCollector/* |      | 200           | IDLE             |
#    And configure a new REST API for the service "BitBucket"
#    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/Test_Data_Git_Collector/files?limit=10000"
#    And User gets the "pom.xml" included file count from bitbucket repository
#    When User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And login must be successful for all users
#    When User clicks on IDA dashboard
#    And user click on the collector analysis link and open the log
#    Then filepattern count from Bitbucket repository and IDA UI should match .
#
#  @webtest @1397 @sanity @positive
#  Scenario:Run Collector plugin with Inclusion filter with .java extension and validate source count collected in IDA UI.
#    Given I create "Analysis" widget for "TestServiceUser" role
#    And I create a dashboard with name "IDA" and add "Analysis" widget for "TestServiceUser" role
#    And I update the ingestion configuration for "TestServiceUser" role
#      | pathToConfig                     | configName           | configValue |
#      | $.configurations.GitCollector[0] | simpleIncludePattern | *.java      |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                          | body | response code | response message |
#      |        |       |       | Post | extensions/analyzers/start/hostName/collector/GitCollector/* |      | 200           |                  |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                           | body | response code | response message |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/hostName/collector/GitCollector/* |      | 200           | IDLE             |
#    And configure a new REST API for the service "BitBucket"
#    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/Test_Data_Git_Collector/files?limit=10000"
#    And User gets the ".java" included file count from bitbucket repository
#    When User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And login must be successful for all users
#    When User clicks on IDA dashboard
#    And user click on the collector analysis link and open the log
#    Then filepattern count from Bitbucket repository and IDA UI should match .
#
#  @webtest @1397 @sanity @positive
#  Scenario:Run Collector plugin with Inclusion filter for file name with prefix 'Bye' and validate source count collected in IDA UI.
#    Given I create "Analysis" widget for "TestServiceUser" role
#    And I create a dashboard with name "IDA" and add "Analysis" widget for "TestServiceUser" role
#    And I update the ingestion configuration for "TestServiceUser" role
#      | pathToConfig                     | configName           | configValue |
#      | $.configurations.GitCollector[0] | simpleIncludePattern | Bye*.*      |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                          | body | response code | response message |
#      |        |       |       | Post | extensions/analyzers/start/hostName/collector/GitCollector/* |      | 200           |                  |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                           | body | response code | response message |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/hostName/collector/GitCollector/* |      | 200           | IDLE             |
#    And configure a new REST API for the service "BitBucket"
#    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/Test_Data_Git_Collector/files?limit=10000"
#    And User gets the "Bye*.*" included file count from bitbucket repository
#    When User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And login must be successful for all users
#    When User clicks on IDA dashboard
#    And user click on the collector analysis link and open the log
#    Then filepattern count from Bitbucket repository and IDA UI should match .
#
#
#  @webtest @1397 @sanity @positive
#  Scenario:Run Collector plugin with inclusion filter with regex and validate source count collected in IDA UI.
#    Given I create "Analysis" widget for "TestServiceUser" role
#    And I create a dashboard with name "IDA" and add "Analysis" widget for "TestServiceUser" role
#    And I update the ingestion configuration for "TestServiceUser" role
#      | pathToConfig                     | configName          | configValue |
#      | $.configurations.GitCollector[0] | regexIncludePattern | .*\\.c[sS]$ |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                          | body | response code | response message |
#      |        |       |       | Post | extensions/analyzers/start/hostName/collector/GitCollector/* |      | 200           |                  |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                           | body | response code | response message |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/hostName/collector/GitCollector/* |      | 200           | IDLE             |
#    And configure a new REST API for the service "BitBucket"
#    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/Test_Data_Git_Collector/files?limit=10000"
#    And User gets the "\\*.c[sS]$" included file count from bitbucket repository
#    When User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And login must be successful for all users
#    When User clicks on IDA dashboard
#    And user click on the collector analysis link and open the log
#    Then filepattern count from Bitbucket repository and IDA UI should match .
#
#  @webtest @1397 @sanity @positive
#  Scenario:Run Collector plugin  simple inclusion filter with multiple regex pattern and validate source count collected in IDA UI.
#    Given I create "Analysis" widget for "TestServiceUser" role
#    And I create a dashboard with name "IDA" and add "Analysis" widget for "TestServiceUser" role
#    And I send series of requests for an operation
#      | requestConfig                  | responseConfig                         | responseRequiredOnNextCall | valueToUpdate                             |
#      | getIngestionConfiguration.json | validateGetIngestionConfiguration.json | Yes                        | deleteFilterPattern.json                  |
#      | putIngestionConfiguration.json | validatePutIngestionConfiguration.json | No                         | Nil                                       |
#      | getIngestionConfiguration.json | validateGetIngestionConfiguration.json | Yes                        | simpleIncludeMultipleWildCardSupport.json |
#      | putIngestionConfiguration.json | validatePutIngestionConfiguration.json | No                         | Nil                                       |
#      | getIngestionConfiguration.json | validateGetIngestionConfiguration.json | No                         | Nil                                       |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                          | body | response code | response message |
#      |        |       |       | Post | extensions/analyzers/start/hostName/collector/GitCollector/* |      | 200           |                  |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                           | body | response code | response message |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/hostName/collector/GitCollector/* |      | 200           | IDLE             |
#    And configure a new REST API for the service "BitBucket"
#    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/Test_Data_Git_Collector/files?limit=10000"
#    And User gets the "\\*(.cpp|.h|.java)$" included file count from bitbucket repository
#    When User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And login must be successful for all users
#    When User clicks on IDA dashboard
#    And user click on the collector analysis link and open the log
#    Then filepattern count from Bitbucket repository and IDA UI should match .
#
#
#  @webtest @1397 @sanity @positive
#  Scenario:Run Collector plugin  regex inclusion filter with multiple regex pattern and validate source count collected in IDA UI.
#    Given I create "Analysis" widget for "TestServiceUser" role
#    And I create a dashboard with name "IDA" and add "Analysis" widget for "TestServiceUser" role
#    And I send series of requests for an operation
#      | requestConfig                  | responseConfig                         | responseRequiredOnNextCall | valueToUpdate                            |
#      | getIngestionConfiguration.json | validateGetIngestionConfiguration.json | Yes                        | deleteFilterPattern.json                 |
#      | putIngestionConfiguration.json | validatePutIngestionConfiguration.json | No                         | Nil                                      |
#      | getIngestionConfiguration.json | validateGetIngestionConfiguration.json | Yes                        | regexIncludeMultipleWildCardSupport.json |
#      | putIngestionConfiguration.json | validatePutIngestionConfiguration.json | No                         | Nil                                      |
#      | getIngestionConfiguration.json | validateGetIngestionConfiguration.json | No                         | Nil                                      |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                          | body | response code | response message |
#      |        |       |       | Post | extensions/analyzers/start/hostName/collector/GitCollector/* |      | 200           |                  |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                           | body | response code | response message |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/hostName/collector/GitCollector/* |      | 200           | IDLE             |
#    And configure a new REST API for the service "BitBucket"
#    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/Test_Data_Git_Collector/files?limit=10000"
#    And User gets the "\\*(.cpp|.h)$" included file count from bitbucket repository
#    When User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And login must be successful for all users
#    When User clicks on IDA dashboard
#    And user click on the collector analysis link and open the log
#    Then filepattern count from Bitbucket repository and IDA UI should match .
#
#  @webtest @1397 @sanity @positive
#  Scenario:Run Collector plugin with Inclusion filter with multiple extension  and validate source count collected in IDA UI.
#    Given I create "Analysis" widget for "TestServiceUser" role
#    And I create a dashboard with name "IDA" and add "Analysis" widget for "TestServiceUser" role
#    And I update the ingestion configuration for "TestServiceUser" role
#      | pathToConfig                     | configName           | configValue                  |
#      | $.configurations.GitCollector[0] | simpleIncludePattern | FileName.extension.extension |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                          | body | response code | response message |
#      |        |       |       | Post | extensions/analyzers/start/hostName/collector/GitCollector/* |      | 200           |                  |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                           | body | response code | response message |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/hostName/collector/GitCollector/* |      | 200           | IDLE             |
#    And configure a new REST API for the service "BitBucket"
#    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/Test_Data_Git_Collector/files?limit=10000"
#    And User gets the "FileName.extension.extension" included file count from bitbucket repository
#    When User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And login must be successful for all users
#    When User clicks on IDA dashboard
#    And user click on the collector analysis link and open the log
#    Then filepattern count from Bitbucket repository and IDA UI should match .
#
#  @webtest @1397 @sanity @positive
#  Scenario:Run Collector plugin with Inclusion filter with blank file pattern and validate source count collected in IDA UI.
#    Given I create "Analysis" widget for "TestServiceUser" role
#    And I create a dashboard with name "IDA" and add "Analysis" widget for "TestServiceUser" role
#    And I update the ingestion configuration for "TestServiceUser" role
#      | pathToConfig                     | configName           | configValue |
#      | $.configurations.GitCollector[0] | simpleIncludePattern |             |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                          | body | response code | response message |
#      |        |       |       | Post | extensions/analyzers/start/hostName/collector/GitCollector/* |      | 200           |                  |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                           | body | response code | response message |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/hostName/collector/GitCollector/* |      | 200           | IDLE             |
#    And configure a new REST API for the service "BitBucket"
#    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/Test_Data_Git_Collector/files?limit=10000"
#    And User gets the "\\*." included file count from bitbucket repository
#    When User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And login must be successful for all users
#    When User clicks on IDA dashboard
#    And user click on the collector analysis link and open the log
#    Then filepattern count from Bitbucket repository and IDA UI should match .
#
#
#  @webtest @1397 @sanity @positive
#  Scenario:Run Collector plugin with Exclude filter with  exact file name and validate source count collected in IDA UI.
#    Given I create "Analysis" widget for "TestServiceUser" role
#    And I create a dashboard with name "IDA" and add "Analysis" widget for "TestServiceUser" role
#    And I update the ingestion configuration for "TestServiceUser" role
#      | pathToConfig                     | configName           | configValue |
#      | $.configurations.GitCollector[0] | simpleExcludePattern | pom.xml     |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                          | body | response code | response message |
#      |        |       |       | Post | extensions/analyzers/start/hostName/collector/GitCollector/* |      | 200           |                  |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                           | body | response code | response message |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/hostName/collector/GitCollector/* |      | 200           | IDLE             |
#    And configure a new REST API for the service "BitBucket"
#    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/Test_Data_Git_Collector/files?limit=10000"
#    And User gets the "pom.xml" excluded file count from bitbucket repository
#    When User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And login must be successful for all users
#    When User clicks on IDA dashboard
#    And user click on the collector analysis link and open the log
#    Then filepattern count from Bitbucket repository and IDA UI should match .
#
#  @webtest @1397 @sanity @positive
#  Scenario:Run Collector plugin with Exclude filter with .java extension and validate source count collected in IDA UI.
#    Given I create "Analysis" widget for "TestServiceUser" role
#    And I create a dashboard with name "IDA" and add "Analysis" widget for "TestServiceUser" role
#    And I update the ingestion configuration for "TestServiceUser" role
#      | pathToConfig                     | configName           | configValue |
#      | $.configurations.GitCollector[0] | simpleExcludePattern | *.java      |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                          | body | response code | response message |
#      |        |       |       | Post | extensions/analyzers/start/hostName/collector/GitCollector/* |      | 200           |                  |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                           | body | response code | response message |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/hostName/collector/GitCollector/* |      | 200           | IDLE             |
#    And configure a new REST API for the service "BitBucket"
#    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/Test_Data_Git_Collector/files?limit=10000"
#    And User gets the ".java" excluded file count from bitbucket repository
#    When User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And login must be successful for all users
#    When User clicks on IDA dashboard
#    And user click on the collector analysis link and open the log
#    Then filepattern count from Bitbucket repository and IDA UI should match .
#
#  @webtest @1397 @sanity @positive
#  Scenario:Run Collector plugin with Exclude filter for file name with prefix 'Bye' and validate source count collected in IDA UI.
#    Given I create "Analysis" widget for "TestServiceUser" role
#    And I create a dashboard with name "IDA" and add "Analysis" widget for "TestServiceUser" role
#    And I update the ingestion configuration for "TestServiceUser" role
#      | pathToConfig                     | configName           | configValue |
#      | $.configurations.GitCollector[0] | simpleExcludePattern | Bye*.*      |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                          | body | response code | response message |
#      |        |       |       | Post | extensions/analyzers/start/hostName/collector/GitCollector/* |      | 200           |                  |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                           | body | response code | response message |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/hostName/collector/GitCollector/* |      | 200           | IDLE             |
#    And configure a new REST API for the service "BitBucket"
#    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/Test_Data_Git_Collector/files?limit=10000"
#    And User gets the "Bye*.*" excluded file count from bitbucket repository
#    When User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And login must be successful for all users
#    When User clicks on IDA dashboard
#    And user click on the collector analysis link and open the log
#    Then filepattern count from Bitbucket repository and IDA UI should match .
#
#  @webtest @1397 @sanity @positive
#  Scenario:Run Collector plugin with Exclude filter with regex and validate source count collected in IDA UI.
#    Given I create "Analysis" widget for "TestServiceUser" role
#    And I create a dashboard with name "IDA" and add "Analysis" widget for "TestServiceUser" role
#    And I update the ingestion configuration for "TestServiceUser" role
#      | pathToConfig                     | configName          | configValue |
#      | $.configurations.GitCollector[0] | regexExcludePattern | .*\\.c[sS]$ |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                          | body | response code | response message |
#      |        |       |       | Post | extensions/analyzers/start/hostName/collector/GitCollector/* |      | 200           |                  |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                           | body | response code | response message |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/hostName/collector/GitCollector/* |      | 200           | IDLE             |
#    And configure a new REST API for the service "BitBucket"
#    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/Test_Data_Git_Collector/files?limit=10000"
#    And User gets the "\\*.c[sS]$" excluded file count from bitbucket repository
#    When User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And login must be successful for all users
#    When User clicks on IDA dashboard
#    And user click on the collector analysis link and open the log
#    Then filepattern count from Bitbucket repository and IDA UI should match .
#
#  @webtest @1397 @sanity @positive
#  Scenario:Run Collector plugin  simple Exclude filter with multiple regex pattern and validate source count collected in IDA UI.
#    Given I create "Analysis" widget for "TestServiceUser" role
#    And I create a dashboard with name "IDA" and add "Analysis" widget for "TestServiceUser" role
#    And I send series of requests for an operation
#      | requestConfig                  | responseConfig                         | responseRequiredOnNextCall | valueToUpdate                            |
#      | getIngestionConfiguration.json | validateGetIngestionConfiguration.json | Yes                        | deleteFilterPattern.json                 |
#      | putIngestionConfiguration.json | validatePutIngestionConfiguration.json | No                         | Nil                                      |
#      | getIngestionConfiguration.json | validateGetIngestionConfiguration.json | Yes                        | simleExcludeMultipleWildCardSupport.json |
#      | putIngestionConfiguration.json | validatePutIngestionConfiguration.json | No                         | Nil                                      |
#      | getIngestionConfiguration.json | validateGetIngestionConfiguration.json | No                         | Nil                                      |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                          | body | response code | response message |
#      |        |       |       | Post | extensions/analyzers/start/hostName/collector/GitCollector/* |      | 200           |                  |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                           | body | response code | response message |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/hostName/collector/GitCollector/* |      | 200           | IDLE             |
#    And configure a new REST API for the service "BitBucket"
#    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/Test_Data_Git_Collector/files?limit=10000"
#    And User gets the "\\*(.cpp|.h|.java)$" excluded file count from bitbucket repository
#    When User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And login must be successful for all users
#    When User clicks on IDA dashboard
#    And user click on the collector analysis link and open the log
#    Then filepattern count from Bitbucket repository and IDA UI should match .
#
#
#  @webtest @1397 @sanity @positive
#  Scenario:Run Collector plugin  regex Exclude filter with multiple regex pattern and validate source count collected in IDA UI.
#    Given I create "Analysis" widget for "TestServiceUser" role
#    And I create a dashboard with name "IDA" and add "Analysis" widget for "TestServiceUser" role
#    And I send series of requests for an operation
#      | requestConfig                  | responseConfig                         | responseRequiredOnNextCall | valueToUpdate                            |
#      | getIngestionConfiguration.json | validateGetIngestionConfiguration.json | Yes                        | deleteFilterPattern.json                 |
#      | putIngestionConfiguration.json | validatePutIngestionConfiguration.json | No                         | Nil                                      |
#      | getIngestionConfiguration.json | validateGetIngestionConfiguration.json | Yes                        | regexExcludeMultipleWildCardSupport.json |
#      | putIngestionConfiguration.json | validatePutIngestionConfiguration.json | No                         | Nil                                      |
#      | getIngestionConfiguration.json | validateGetIngestionConfiguration.json | No                         | Nil                                      |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                          | body | response code | response message |
#      |        |       |       | Post | extensions/analyzers/start/hostName/collector/GitCollector/* |      | 200           |                  |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                           | body | response code | response message |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/hostName/collector/GitCollector/* |      | 200           | IDLE             |
#    And configure a new REST API for the service "BitBucket"
#    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/Test_Data_Git_Collector/files?limit=10000"
#    And User gets the "\\*(.cpp|.h)$" excluded file count from bitbucket repository
#    When User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And login must be successful for all users
#    When User clicks on IDA dashboard
#    And user click on the collector analysis link and open the log
#    Then filepattern count from Bitbucket repository and IDA UI should match .
