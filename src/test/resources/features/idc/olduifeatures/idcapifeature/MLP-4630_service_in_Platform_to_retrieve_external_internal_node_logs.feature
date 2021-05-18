@MLP-4630
Feature:service in Platform to retrieve external and internal node logs

  @MLP-4630 @sftp @positve @regression @sanity
  Scenario: Clear message log in sftp and run ingestion for a plugin
    Given user connects to the SFTP server and clear the "messages.log"
    And Execute REST API with following parameters
      | Header           | Query | Param | type | url                              | body                                          | response code | response message |
      | application/json |       |       | Put | settings/analyzers/HiveCataloger | idc/MLP_4630_HiveCataloger_Configuration.json | 204           |                  |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                                                                 | body | response code | response message |
      |        |       |       | Post | extensions/analyzers/start/Cluster%20Demo/cataloger/HiveCataloger/* |      | 200           |                  |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                  | body | response code | response message |
      |        |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/* |      | 200           | IDLE             |

  @MLP-4630 @sftp @positve @regression @sanity
  Scenario: Verification of logs of Cluster Demo Node
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
      | Content-Type  | text/plain                         |
    And user makes a REST Call for Get request with url "extensions/analyzers/log/Cluster Demo?length=10000"
    And user connects to the SFTP server and downloads the "Message.log"
    And user retrieves "Messages.log" from sftp and store it in "/queryLog/analyzerLog/Messages.txt" as text format
    And user should able store the response in "src/test/resources/testdata/features/querylog/analyzerLog" and save it as "FullSwaggerLog.txt"
    And user retrieve the absolute analysis log with below parameters
      | sourcePath                              | destinationPath                            | fileContentStartLine                     | fileContentEndLine    |
      | queryLog/analyzerLog/FullSwaggerLog.txt | queryLog/analyzerLog/actualAbsoluteLog.txt | Plugin cataloger/HiveCataloger indicated | Scanning is finished. |
    And user retrieve the absolute analysis log with below parameters
      | sourcePath                        | destinationPath                              | fileContentStartLine                     | fileContentEndLine    |
      | queryLog/analyzerLog/Messages.txt | queryLog/analyzerLog/ExpectedAbsoluteLog.txt | Plugin cataloger/HiveCataloger indicated | Scanning is finished. |
    Then Expected log file "queryLog/analyzerLog/ExpectedAbsoluteLog.txt" in path "queryLog" should match with "queryLog/analyzerLog/actualAbsoluteLog.txt"

  @MLP-4630 @sftp @positve @regression @sanity
  Scenario: Verification of logs of non existence Node
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
      | Content-Type  | text/plain                         |
    And user makes a REST Call for Get request with url "extensions/analyzers/log/Cluster?length=10000"
    And Status code 200 must be returned
    Then response body should be "null"

#  @webtest @MLP-4630 @positive
#  Scenario: MLP-4630 Verification of deleting Cluster demo node
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator" role
#    And user clicks on Administration widget
#    And user clicks on Plugin Manager in Administration dashboard
#    And user clicks on "Cluster Demo" from nodes list
#    And user clicks on Delete button in the Edit Node panel
#    And user clicks on Yes button in alert message
#    And user verifies the node "Cluster Demo" is not displayed under NODES list
#
#  @webtest @MLP-4630 @positive @regression @pluginManager
#  Scenario: MLP-2645 Verification of adding new node to check log
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator" role
#    And user clicks on Administration widget
#    And user clicks on Plugin Manager in Administration dashboard
#    And user clicks on Add new node Button in Plugin Management page
#    And user enters the node name "Cluster Demo" in the name field
#    Then user select "BigData" from Catalog list
#    And user click save button in Create New Node page
#    And user verifies the node "Cluster Demo" is displayed under NODES list

#
#  @MLP-3579 @positive @regression @sanity
#  Scenario: MLP-3579:Verify whether the status of the IDA Node when the status is modified to "DOWN" manually using SET call.
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Content-Type  | application/json                   |
#      | Accept        | application/json                   |
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#    And supply payload with file name "ida/Valid_Node_Status_DOWN.txt"
#    When user makes a REST Call for PUT request with url "extensions/analyzers/status/Cluster Demo"
#    Then Status code 204 must be returned
#    When user makes a REST Call for Get request with url "extensions/analyzers/status/Cluster Demo"
#    Then Status code 200 must be returned
#    And response message contains value "DOWN"
#
#
#  @MLP-4630 @positive @regression @pluginManager
#  Scenario: MLP-4630 Change the status of newly created node to UP
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Content-Type  | application/json                   |
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#    And supply payload with file name "ida/Valid_Node_Status_UP.txt"
#    When user makes a REST Call for PUT request with url "extensions/analyzers/status/Test Node"
#    Then Status code 204 must be returned
#    When user makes a REST Call for Get request with url "extensions/analyzers/status/Test Node"
#    Then Status code 200 must be returned

#  @MLP-4630 @sftp @positve @regression @sanity
#  Scenario: MLP-2645 Updating configuration for Cluster Demo created in previous steps
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#      | Content-Type  | application/json                   |
#      | Accept        | application/json                   |
#    And supply payload with file name "/ida/clusterDemoNodeDefaultConfig.json"
#    And user makes a REST Call for PUT request with url "settings/analyzers/Cluster Demo" with the following query param
#      | raw | false |
#    And Status code 204 must be returned

  @validatecurlforstopservicecomponet @MLP-4630
  Scenario: This scenario to validate curl request to stop catalogHive server
    Given configure a new REST API for the service "Ambari"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization  | Basic cmFqX29wczpyYWpfb3Bz |
      | X-Requested-By | ambari                     |
    And supply payload with file name "ida/StopServiceComponent.json"
    When user makes a REST Call for PUT request with url "clusters/Sandbox/services/IDANODE/components/IDANODE"
    Then Status code 202 must be returned
    And user makes recursive GET request for below parameters
      | Header | Query | Param | type         | url                                                  | body | response code | response message | jsonPath |
      |        |       |       | RecursiveGet | clusters/Sandbox/services/IDANODE/components/IDANODE |      | 200           | INSTALLED        | $..state |
    And sync the test execution for "30" seconds


  @validatecurlforstartservicecomponet @MLP-4630
  Scenario: This scenario to validate curl request to start catalogHive server
    Given configure a new REST API for the service "Ambari"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization  | Basic cmFqX29wczpyYWpfb3Bz |
      | X-Requested-By | ambari                     |
    And supply payload with file name "ida/StartServiceComponent.json"
    When user makes a REST Call for PUT request with url "clusters/Sandbox/services/IDANODE/components/IDANODE"
    Then Status code 202 must be returned
    And user makes recursive GET request for below parameters
      | Header | Query | Param | type         | url                                                  | body | response code | response message | jsonPath |
      |        |       |       | RecursiveGet | clusters/Sandbox/services/IDANODE/components/IDANODE |      | 200           | STARTED          | $..state |
    And sync the test execution for "30" seconds

  @MLP-4630 @sftp @positve @regression @sanity
  Scenario: Run Ingestion for new cluster demo configuration
    Given user connects to the SFTP server and clear the "messages.log"
    And Execute REST API with following parameters
      | Header           | Query | Param | type | url                                                                 | body | response code | response message |
      | application/json |       |       | Post | extensions/analyzers/start/Cluster%20Demo/cataloger/HiveCataloger/* |      | 200           |                  |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                  | body | response code | response message |
      |        |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/* |      | 200           | IDLE             |

  @MLP-4630 @sftp @positve @regression @sanity
  Scenario: Verification of logs of newly created Node
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
      | Content-Type  | text/plain                         |
    And user makes a REST Call for Get request with url "extensions/analyzers/log/Cluster Demo?length=10000"
    And user connects to the SFTP server and downloads the "Message.log"
    And user retrieves "Messages.log" from sftp and store it in "/queryLog/analyzerLog/Messages.txt" as text format
    And user should able store the response in "src/test/resources/testdata/features/querylog/analyzerLog" and save it as "FullSwaggerLog.txt"
    And user retrieve the absolute analysis log with below parameters
      | sourcePath                              | destinationPath                            | fileContentStartLine                     | fileContentEndLine    |
      | queryLog/analyzerLog/FullSwaggerLog.txt | queryLog/analyzerLog/actualAbsoluteLog.txt | Plugin cataloger/HiveCataloger indicated | Scanning is finished. |
    And user retrieve the absolute analysis log with below parameters
      | sourcePath                        | destinationPath                              | fileContentStartLine                     | fileContentEndLine    |
      | queryLog/analyzerLog/Messages.txt | queryLog/analyzerLog/ExpectedAbsoluteLog.txt | Plugin cataloger/HiveCataloger indicated | Scanning is finished. |
    Then Expected log file "queryLog/analyzerLog/ExpectedAbsoluteLog.txt" in path "queryLog" should match with "queryLog/analyzerLog/actualAbsoluteLog.txt"

