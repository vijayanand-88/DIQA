@MLP-2179
Feature:MLP-2179: AutoStart of the plugins
  Description:  Some plugins like monitor should auto start when the IDA node starts

  @MLP-2179 @autostartplugins @sanity @positive
  Scenario: MLP-2179:Verify whether auto start flag is set to true and the status of the plugin is in RUNNING status for Hive Monitor.
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And supply payload with file name "/ida/new_Hive_Cataloger_Configuration.json"
    When user makes a REST Call for PUT request with url "settings/analyzers/HiveCataloger" with the following query param
      | raw | false |
    And Status code 204 must be returned
    And supply payload with file name "/ida/new_Hive_Monitor_Configuration.json"
    When user makes a REST Call for PUT request with url "settings/analyzers/HiveMonitor" with the following query param
      | raw | false |
    And Status code 204 must be returned
    When user makes a REST Call for Get request with url "extensions/analyzers/status/Cluster Demo/monitor/HiveMonitor/HiveMonitor"
    And Status code 200 must be returned
    And user waits for the final status to be reflected after "3000" milliseconds
    And response message contains value "RUNNING"
    And user makes a REST Call for Get request with url "settings/analyzers/HiveMonitor"
    Then Status code 200 must be returned
    And response message should contain "true" for the path "configurations.HiveMonitor.autoStart"

  @MLP-2179 @autostartplugins @sanity @positive
  Scenario: MLP-2179:Verify whether auto start flag is set to true and the status of the plugin is in RUNNING status for HDFS Monitor.
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And supply payload with file name "/ida/new_Hdfs_Cataloger_Configuration.json"
    When user makes a REST Call for PUT request with url "settings/analyzers/HdfsCataloger" with the following query param
      | raw | false |
    And Status code 204 must be returned
    And supply payload with file name "/ida/new_Hdfs_Monitor_Configuration.json"
    When user makes a REST Call for PUT request with url "settings/analyzers/HdfsMonitor" with the following query param
      | raw | false |
    And Status code 204 must be returned
    When user makes a REST Call for Get request with url "extensions/analyzers/status/Cluster Demo/monitor/HdfsMonitor/HdfsMonitor"
    And Status code 200 must be returned
    And user waits for the final status to be reflected after "3000" milliseconds
    And response message contains value "RUNNING"
    And user makes a REST Call for Get request with url "settings/analyzers/HdfsMonitor"
    Then Status code 200 must be returned
    And response message should contain "true" for the path "configurations.HdfsMonitor.autoStart"

  @MLP-2179 @autostartplugins @sanity @negative
  Scenario: MLP-2179: Verify whether the status is set to IDLE when the auto-start flag is set to false for the HiveMonitor
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And supply payload with file name "/ida/new_Hive_Monitor_autostart_false_Configuration.json"
    When user makes a REST Call for PUT request with url "settings/analyzers/HiveMonitor" with the following query param
      | raw | false |
    And Status code 204 must be returned
    And user waits for the final status to be reflected after "5000" milliseconds
    And user makes a REST Call for Get request with url "extensions/analyzers/status/Cluster Demo/monitor/HiveMonitor/HiveMonitor"
    Then Status code 200 must be returned
    And response message contains value "IDLE"


  @MLP-2179 @autostartplugins @sanity @negative
  Scenario: MLP-2179: Verify whether the status is set to IDLE when the auto-start flag is set to false for the HdfsMonitor
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And supply payload with file name "/ida/new_Hdfs_Monitor_autostart_false_Configuration.json"
    When user makes a REST Call for PUT request with url "settings/analyzers/HdfsMonitor" with the following query param
      | raw | false |
    And Status code 204 must be returned
    And user waits for the final status to be reflected after "5000" milliseconds
    And user makes a REST Call for Get request with url "extensions/analyzers/status/Cluster Demo/monitor/HdfsMonitor/HdfsMonitor"
    Then Status code 200 must be returned
    And response message contains value "IDLE"

  @MLP-2179 @autostartplugins @sanity @positive
  Scenario: MLP-2179: Verify whether the status is set back to RUNNING when the auto-start flag is set to true for the HiveMonitor
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And supply payload with file name "/ida/new_Hive_Monitor_autostart_true_Configuration.json"
    When user makes a REST Call for PUT request with url "settings/analyzers/HiveMonitor" with the following query param
      | raw | false |
    And Status code 204 must be returned
    And user waits for the final status to be reflected after "5000" milliseconds
    Then user makes a REST Call for Get request with url "extensions/analyzers/status/Cluster Demo/monitor/HiveMonitor/HiveMonitor"
    And Status code 200 must be returned
    And response message contains value "RUNNING"


  @MLP-2179 @autostartplugins @sanity @positive
  Scenario: MLP-2179: Verify whether the status is set back to RUNNING when the auto-start flag is set to true for the HdfsMonitor
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And supply payload with file name "/ida/new_Hdfs_Monitor_autostart_true_Configuration.json"
    When user makes a REST Call for PUT request with url "settings/analyzers/HdfsMonitor" with the following query param
      | raw | false |
    And Status code 204 must be returned
    Then user makes a REST Call for Get request with url "extensions/analyzers/status/Cluster Demo/monitor/HdfsMonitor/HdfsMonitor"
    And Status code 200 must be returned
    And user waits for the final status to be reflected after "3000" milliseconds
    And response message contains value "RUNNING"