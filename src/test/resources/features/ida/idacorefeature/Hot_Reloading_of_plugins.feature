@MLP-1633
Feature:MLP-1633: Hot Reloading of the plugins
  Description: Plugins needs to be allowed dynamically loading and reloading plugins, so we can update a plugin
  from the running plugin service without updating everything.

  @MLP-1633 @hotreloading @sanity @positive
  Scenario: MLP-1633: verify whether the Hive monitor plugins are in RUNNING Status,when the corresponding bundle is uploaded.
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user waits for the final status to be reflected after "2000" milliseconds
    When user makes a REST Call for Get request with url "extensions/analyzers/status/Cluster Demo/monitor/HiveMonitor/HiveMonitor"
    Then Status code 200 must be returned
    And response message contains value "RUNNING"

  @MLP-1633 @hotreloading @sanity @positive
  Scenario: MLP-1633: verify whether the HDFS monitor plugins are in RUNNING Status,when the corresponding bundle is uploaded.
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user waits for the final status to be reflected after "5000" milliseconds
    When user makes a REST Call for Get request with url "extensions/analyzers/status/Cluster Demo/monitor/HdfsMonitor/HdfsMonitor"
    And user waits for the final status to be reflected after "3000" milliseconds
    Then Status code 200 must be returned
    And response message contains value "RUNNING"

  @MLP-1633 @hotreloading @sanity @sftp @positive
  Scenario: MLP-1841:verify the message.log has the entry for running of HiveMonitor.
    Given user connects to the SFTP server and downloads the "messages.log"
    Then user validates the entries in "message.log"
      |logEntry           |
      |HiveMonitor_Running|

  @MLP-1633 @hotreloading @sanity @sftp @positive
  Scenario: MLP-1841:verify the message.log has the entry for running of HdfsMonitor.
    Given user connects to the SFTP server and downloads the "messages.log"
    Then user validates the entries in "message.log"
      |logEntry           |
      |HiveMonitor_Running|