@MLP-1841
Feature:MLP-1841: Stopping the Plugins
Description:  Any currently plugin should abort upon receiving the event, including autostart plugins

  @MLP-1841 @stopplugins @sanity @positive
  Scenario: MLP-1841:Verify the status of the plugin is moved to IDLE status when the HiveMonitor plugin is stopped.
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When user makes a REST Call for POST request with url "extensions/analyzers/stop/Cluster Demo/monitor/HiveMonitor/HiveMonitor"
    Then Status code 204 must be returned
    And user waits for the final status to be reflected after "3000" milliseconds
    And user makes a REST Call for Get request with url "extensions/analyzers/status/Cluster Demo/monitor/HiveMonitor/HiveMonitor"
    And response message contains value "IDLE"

  @MLP-1841 @stopplugins @sanity @positive
  Scenario: MLP-1841:Verify the status of the plugin is moved to IDLE status when the HdfsMonitor plugin is stopped.
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When user makes a REST Call for POST request with url "extensions/analyzers/stop/Cluster Demo/monitor/HdfsMonitor/HdfsMonitor"
    Then Status code 204 must be returned
    And user waits for the final status to be reflected after "3000" milliseconds
    And user makes a REST Call for Get request with url "extensions/analyzers/status/Cluster Demo/monitor/HdfsMonitor/HdfsMonitor"
    And response message contains value "IDLE"

  @MLP-1841 @stopplugins @sanity @sftp @positive
  Scenario: MLP-1841:verify the message.log has the entry for stopping the HiveMonitor.
    Given user connects to the SFTP server and downloads the "messages.log"
    Then user validates the entries in "message.log"
      |logEntry   |
      |HiveMonitor|

  @MLP-1841 @stopplugins @sanity @sftp @positive
  Scenario: MLP-1841:verify the message.log has the entry for stopping the HdfsMonitor.
    Given user connects to the SFTP server and downloads the "messages.log"
    Then user validates the entries in "message.log"
      |logEntry   |
      |HdfsMonitor|

  @MLP-1841 @stopplugins @sanity @positive
  Scenario: MLP-1841:Verify the status of the plugin is moved to RUNNING status when the HiveMonitor plugin is started.
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When user makes a REST Call for POST request with url "extensions/analyzers/start/Cluster Demo/monitor/HiveMonitor/HiveMonitor"
    Then Status code 200 must be returned
    And user waits for the final status to be reflected after "3000" milliseconds
    And user makes a REST Call for Get request with url "extensions/analyzers/status/Cluster Demo/monitor/HiveMonitor/HiveMonitor"
    And response message contains value "RUNNING"

  @MLP-1841 @stopplugins @sanity @positive
  Scenario: MLP-1841:Verify the status of the plugin is moved to RUNNING status when the HdfsMonitor plugin is started.
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When user makes a REST Call for POST request with url "extensions/analyzers/start/Cluster Demo/monitor/HdfsMonitor/HdfsMonitor"
    Then Status code 200 must be returned
    And user waits for the final status to be reflected after "3000" milliseconds
    And user makes a REST Call for Get request with url "extensions/analyzers/status/Cluster Demo/monitor/HdfsMonitor/HdfsMonitor"
    And response message contains value "RUNNING"
