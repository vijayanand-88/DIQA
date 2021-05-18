#@MLP-1306
#Feature:MLP-1306: Capture Hive query logs
#Description: using MonitorHive, get Hive query logs. We’ll need to adapt MonitorHive to configure if we’re interested into DML queries on top of DDL, and then it will need to write the event maybe in a different format. Then the monitor processor can send these events to a different class that will be do the query processing and do whatever we want with them. Which is of course another question, we’ll need to see what we want to do with these queries: write statistics or lineage information into IDC, store these queries in a big data file for batch processing…
#  @MLP-1306 @querylogs @sanity @sftp
#  Scenario: MLP-1306: Verify whether the Query flag is disabled in hive xml
#    Given configure a new REST API for the service "Ambari"
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization  | Basic cmFqX29wczpyYWpfb3Bz |
#      | X-Requested-By | ambari                     |
#    And Add a random version for the "idc/SimplifiedConfigurationHiveQueryLogFalse.json" payload
#    And sync the test execution for "15" seconds
#    And supply payload with file name "idc/SimplifiedConfigurationHiveQueryLogFalse.json"
#    When user makes a REST Call for PUT request with url "clusters/Sandbox"
#    And Status code 200 must be returned
#    And sync the test execution for "15" seconds
#    And configure a new REST API for the service "Ambari"
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization  | Basic cmFqX29wczpyYWpfb3Bz |
#      | X-Requested-By | ambari                     |
#    And supply payload with file name "idc/StopCatalogerService.json"
#    And user makes a REST Call for PUT request with url "clusters/Sandbox/services/CATALOGER"
#    And verify the Ambari status with the status code "202"
#    And sync the test execution for "15" seconds
#    And configure a new REST API for the service "Ambari"
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization  | Basic cmFqX29wczpyYWpfb3Bz |
#      | X-Requested-By | ambari                     |
#    And supply payload with file name "idc/StartCatalogerService.json"
#    When user makes a REST Call for PUT request with url "clusters/Sandbox/services/CATALOGER"
#    And sync the test execution for "15" seconds
#    And user connects to the sftp server and downloads the "xml" "config" file for Query""
#    And user converts the xml file to json file
#    Then cataloger.enable.queryLog in the should be set to "False"
#    And delete the downloaded xml file
#
#  @MLP-1306 @webtest @querylogs @sanity @sftp
#  Scenario:MLP-1306: Verify whether the Monitor Hive query collection when enable query log is set to No
#
#    Given User launch browser and traverse to Ambari login page
#    And user enter credentials for Ambari login
#    When user clicks on cataloger in Ambari left navigation bar
#    And user clicks on Hive Viewer
#    And user clicks on Hive View
#    And user enters the "Query" "1" in Hive query box and clicks on execute
#    And user waits for the query to be succeeded
#    And user connects to the sftp server and downloads the "xml" "query" file for Query"1"
#    And user verifies whether all the event files are moved to catalog Hive
#    Then Query log should not be generated
#
#  @MLP-1306 @querylogs @sanity @sftp
#  Scenario:MLP-1306: Verify whether the Query flag is enabled in hive xml
#
#    Given configure a new REST API for the service "Ambari"
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization  | Basic cmFqX29wczpyYWpfb3Bz |
#      | X-Requested-By | ambari                     |
#    And Add a random version for the "idc/SimplifiedConfigurationHiveQueryLogTrue.json" payload
#    And sync the test execution for "15" seconds
#    And supply payload with file name "idc/SimplifiedConfigurationHiveQueryLogTrue.json"
#    When user makes a REST Call for PUT request with url "clusters/Sandbox"
#    And Status code 200 must be returned
#    And sync the test execution for "15" seconds
#    And configure a new REST API for the service "Ambari"
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization  | Basic cmFqX29wczpyYWpfb3Bz |
#      | X-Requested-By | ambari                     |
#    And supply payload with file name "idc/StopCatalogerService.json"
#    And user makes a REST Call for PUT request with url "clusters/Sandbox/services/CATALOGER"
#    And verify the Ambari status with the status code "202"
#    And sync the test execution for "15" seconds
#    And configure a new REST API for the service "Ambari"
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization  | Basic cmFqX29wczpyYWpfb3Bz |
#      | X-Requested-By | ambari                     |
#    And supply payload with file name "idc/StartCatalogerService.json"
#    When user makes a REST Call for PUT request with url "clusters/Sandbox/services/CATALOGER"
#    And sync the test execution for "15" seconds
#    And user connects to the sftp server and downloads the "xml" "config" file for Query"0"
#    And user converts the xml file to json file
#    Then cataloger.enable.queryLog in the should be set to "True"
#    And delete the downloaded xml file
#
#  @MLP-1306 @webtest @querylogs @sanity @sftp
#  Scenario:MLP-1306: Verify whether the Monitor Hive query collection when enable query log is set to Yes
#
#    Given User launch browser and traverse to Ambari login page
#    And user enter credentials for Ambari login
##    When user clicks on cataloger in Ambari left navigation bar
#    And user clicks on Hive Viewer
#    And user clicks on Hive View
##    And To configure multiple headers and Authorization dynamically for Rest Endpoint
##      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
##      | Content-Type  | application/json                   |
##      | Accept        | application/json                   |
##    And supply payload with file name "/ida/hive_config_payload_with_deltatime_3_seconds.json"
##    When user makes a REST Call for PUT request with url "configuration/ingestion/Cluster Demo" with the following query param
##      | raw | false |
##    Then Status code 204 must be returned
#    And user enters the "Query" "1" in Hive query box and clicks on execute
#    And user waits for the query to be succeeded
#    And user verifies whether all the event files are moved to catalog Hive
##    And user connects to the sftp server and downloads the "xml" "query" file for Query"1"
##    Then the query executed should match with the query "QueryLog_Q1" and only "1" queries should be there
##    And delete the downloaded xml file
#
#  @MLP-1306 @webtest @querylogs @sanity @sftp @MLP-1685
#  Scenario:MLP-1306: Verification of Monitor hive Query for skip queries
#    Given User launch browser and traverse to Ambari login page
#    And user enter credentials for Ambari login
#    When user clicks on cataloger in Ambari left navigation bar
#    And user clicks on Hive Viewer
#    And user clicks on Hive View
#    And user enters the "Query" "2" in Hive query box and clicks on execute
#    And user waits for the query to be succeeded
#    And user verifies whether all the event files are moved to catalog Hive
#    And user connects to the sftp server and downloads the "xml" "query" file for Query"2"
#    Then the query executed should match with the query "QueryLog_Q2" and only "3" queries should be there
#    And delete the downloaded xml file
#
##==========================================================================================================
#
#  @MLP-1953 @webtest @querylogs @sanity @sftp @MLP-1685
#  Scenario:MLP-1953: Verification of Hive query logs for SELECT query
#
#    Given User launch browser and traverse to Ambari login page
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#      | Content-Type  | application/json                   |
#      | Accept        | application/json                   |
#    And supply payload with file name "/ida/hive_config_payload_with_deltatime_300_seconds.json"
#    When user makes a REST Call for PUT request with url "configuration/ingestion/Cluster Demo" with the following query param
#      | raw | false |
#    Then Status code 204 must be returned
#    And user enter credentials for Ambari login
#    And user clicks on Hive Viewer
#    And user clicks on Hive View
#    And user enters the "Query" "8" in Hive query box and clicks on execute
#    And user waits for the query to be succeeded
#    And user captures the list of table columns names generated
#    And user connects to the sftp server and downloads the "event" "text" file for Query"8"
#    And user validates the file contents for Query"8"
#    And user connects to the sftp server and downloads the "catalogHive" "log" file for Query"8"
#    And configure a new REST API for the service "IDC"
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#      | Content-Type  | application/json                   |
#      | Accept        | application/json                   |
#    And supply payload with file name "/ida/hive_config_payload_with_deltatime_3_seconds.json"
#    When user makes a REST Call for PUT request with url "configuration/ingestion/Cluster Demo" with the following query param
#      | raw | false |
#    Then Status code 204 must be returned
#    And user verifies whether all the event files are moved to catalog Hive
#    And user validates the status of cataloger enable query log flag to "true"
#    And user connects to the sftp server and downloads the "xml" "query" file for Query"8"
#    And user validates the contents of the query xml
#    And delete the downloaded xml file
#    And user navigates to IDC UI
#    And user configure the advance search for the login
#    And user searches for the Query"8" in the search box
#    And user searches for the event file releated to the Query "8"
#    And user verifies the input table for the table Name "recharge_details" executed from the query "8" and clicks on it
#    And user validates the table columns names under HAS_COLUMNS
#
#
#  @MLP-1953 @webtest @querylogs @sanity @sftp @MLP-1685
#  Scenario:MLP-1953: Verification of Hive query logs for CREATE query
#
#    Given User launch browser and traverse to Ambari login page
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#      | Content-Type  | application/json                   |
#      | Accept        | application/json                   |
#    And supply payload with file name "/ida/hive_config_payload_with_deltatime_300_seconds.json"
#    When user makes a REST Call for PUT request with url "configuration/ingestion/Cluster Demo" with the following query param
#      | raw | false |
#    Then Status code 204 must be returned
#    And user enter credentials for Ambari login
#    And user clicks on Hive Viewer
#    And user clicks on Hive View
#    And user enters the "Query" "9" in Hive query box and clicks on execute
#    And user waits for the query to be succeeded
#    And user connects to the sftp server and downloads the "event" "text" file for Query"9"
#    And user validates the file contents for Query"9"
#    And user connects to the sftp server and downloads the "catalogHive" "log" file for Query"9"
#    And configure a new REST API for the service "IDC"
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#      | Content-Type  | application/json                   |
#      | Accept        | application/json                   |
#    And supply payload with file name "/ida/hive_config_payload_with_deltatime_3_seconds.json"
#    When user makes a REST Call for PUT request with url "configuration/ingestion/Cluster Demo" with the following query param
#      | raw | false |
#    Then Status code 204 must be returned
#    And user verifies whether all the event files are moved to catalog Hive
#    And user validates the status of cataloger enable query log flag to "true"
#    And user connects to the sftp server and downloads the "xml" "query" file for Query"9"
#    And user validates the contents of the xml for the CREATE query
#    And delete the downloaded xml file
#    And user navigates to IDC UI
#    And user configure the advance search for the login
#    And user searches for the Query"9" in the search box
#    And user searches for the event file releated to the Query "9"
#    Then user verifies the output table for the table Name "customer_shopping_list" executed from the query "9" and clicks on it
#
#
#  @MLP-1953 @webtest @querylogs @sanity @sftp @droptable
#  Scenario:MLP-1953: Verification of Hive query logs for INSERT query
#
#    Given User launch browser and traverse to Ambari login page
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#      | Content-Type  | application/json                   |
#      | Accept        | application/json                   |
#    And supply payload with file name "/ida/hive_config_payload_with_deltatime_300_seconds.json"
#    When user makes a REST Call for PUT request with url "configuration/ingestion/Cluster Demo" with the following query param
#      | raw | false |
#    Then Status code 204 must be returned
#    And user enter credentials for Ambari login
#    And user clicks on Hive Viewer
#    And user clicks on Hive View
#    And user enters the "Query" "10" in Hive query box and clicks on execute
#    And user waits for the query to be succeeded
#    And user connects to the sftp server and downloads the "event" "text" file for Query"10"
#    And user validates the file contents for Query"10"
#    And user connects to the sftp server and downloads the "catalogHive" "log" file for Query"10"
#    And configure a new REST API for the service "IDC"
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#      | Content-Type  | application/json                   |
#      | Accept        | application/json                   |
#    And supply payload with file name "/ida/hive_config_payload_with_deltatime_3_seconds.json"
#    When user makes a REST Call for PUT request with url "configuration/ingestion/Cluster Demo" with the following query param
#      | raw | false |
#    Then Status code 204 must be returned
#    And user verifies whether all the event files are moved to catalog Hive
#    And user validates the status of cataloger enable query log flag to "true"
#    And user connects to the sftp server and downloads the "xml" "query" file for Query"10"
#    And user validates the contents of the xml for the INSERT query
#    And delete the downloaded xml file
#    And user navigates to IDC UI
#    And user configure the advance search for the login
#    And user searches for the Query"10" in the search box
#    And user searches for the event file releated to the Query "10"
#    Then user verifies the output table for the table Name "customer_shopping_list" executed from the query "10" and clicks on it
#
#
#  @MLP-1953 @webtest @querylogs @sanity @sftp @droptable
#  Scenario:MLP-1953: Verification of Hive query logs for Create External Table
#
#    Given User launch browser and traverse to Ambari login page
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#      | Content-Type  | application/json                   |
#      | Accept        | application/json                   |
#    And supply payload with file name "/ida/hive_config_payload_with_deltatime_300_seconds.json"
#    When user makes a REST Call for PUT request with url "configuration/ingestion/Cluster Demo" with the following query param
#      | raw | false |
#    Then Status code 204 must be returned
#    And user enter credentials for Ambari login
#    And user clicks on Hive Viewer
#    And user clicks on Hive View
#    And user enters the "Query" "11" in Hive query box and clicks on execute
#    And user waits for the query to be succeeded
#    And user connects to the sftp server and downloads the "event" "text" file for Query"11"
#    And user validates the file contents for Query"11"
#    And user connects to the sftp server and downloads the "catalogHive" "log" file for Query"11"
#    And configure a new REST API for the service "IDC"
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#      | Content-Type  | application/json                   |
#      | Accept        | application/json                   |
#    And supply payload with file name "/ida/hive_config_payload_with_deltatime_3_seconds.json"
#    When user makes a REST Call for PUT request with url "configuration/ingestion/Cluster Demo" with the following query param
#      | raw | false |
#    Then Status code 204 must be returned
#    And user verifies whether all the event files are moved to catalog Hive
#    And user validates the status of cataloger enable query log flag to "true"
#    And user connects to the sftp server and downloads the "xml" "query" file for Query"11"
#    And user validates the contents of the xml for the CREATE EXTERNAL TABLE query
#    And delete the downloaded xml file
#    And user navigates to IDC UI
#    And user configure the advance search for the login
#    And user searches for the Query"11" in the search box
#    And user searches for the event file releated to the Query "11"
#    Then user verifies the output table for the table Name "cus_shop_list" executed from the query "11" and clicks on it
#
#
#  @MLP-1953 @webtest @querylogs @sanity @sftp @eventFileDeletion
#  Scenario:MLP-1953: Verification of Hive query logs for INSERT DIRECTORY
#
#    Given User launch browser and traverse to Ambari login page
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#      | Content-Type  | application/json                   |
#      | Accept        | application/json                   |
#    And supply payload with file name "/ida/hive_config_payload_with_deltatime_3_seconds.json"
#    When user makes a REST Call for PUT request with url "configuration/ingestion/Cluster Demo" with the following query param
#      | raw | false |
#    Then Status code 204 must be returned
#    And configure a new REST API for the service "IDC"
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#      | Content-Type  | application/json                   |
#      | Accept        | application/json                   |
#    And supply payload with file name "/ida/hive_config_payload_with_deltatime_300_seconds.json"
#    When user makes a REST Call for PUT request with url "configuration/ingestion/Cluster Demo" with the following query param
#      | raw | false |
#    Then Status code 204 must be returned
#    And user enter credentials for Ambari login
#    And user clicks on Hive Viewer
#    And user clicks on Hive View
#    And user enters the "Query" "12" in Hive query box and clicks on execute
#    And user waits for the query to be succeeded
#    And user connects to the sftp server and downloads the "event" "text" file for Query"12"
#    And user validates the file contents for Query"12"
#    And user connects to the sftp server and downloads the "catalogHive" "log" file for Query"12"
#    And configure a new REST API for the service "IDC"
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#      | Content-Type  | application/json                   |
#      | Accept        | application/json                   |
#    And supply payload with file name "/ida/hive_config_payload_with_deltatime_3_seconds.json"
#    When user makes a REST Call for PUT request with url "configuration/ingestion/Cluster Demo" with the following query param
#      | raw | false |
#    Then Status code 204 must be returned
#    And user verifies whether all the event files are moved to catalog Hive
#    And user validates the status of cataloger enable query log flag to "true"
#    And user connects to the sftp server and downloads the "xml" "query" file for Query"12"
#    And user validates the contents of the xml for the INSERT DIRECTORY query
#    And delete the downloaded xml file
#    And user navigates to IDC UI
#    And user configure the advance search for the login
#    And user searches for the Query"12" in the search box
#    And user searches for the event file releated to the Query "12"
#    Then user verifies the output table for the table Name "user/totalCommerce/testcsvfolder" executed from the query "12" and clicks on it
#
##=====================================================================================================================================================================
#
#  @MLP-1953 @webtest @querylogs @sanity @sftp
#  Scenario:MLP-1953: Verification of Hive Query log xml for different queries
#
#    Given User launch browser and traverse to Ambari login page
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#      | Content-Type  | application/json                   |
#      | Accept        | application/json                   |
#    And supply payload with file name "/ida/hive_config_payload_with_deltatime_300_seconds.json"
#    When user makes a REST Call for PUT request with url "configuration/ingestion/Cluster Demo" with the following query param
#      | raw | false |
#    Then Status code 204 must be returned
#    And user enter credentials for Ambari login
#    And user clicks on Hive Viewer
#    And user clicks on Hive View
#    And user enters the "Query" "8" in Hive query box and clicks on execute
#    And user waits for the query to be succeeded
#    And user clicks on Hive Viewer
#    And user clicks on Hive View
#    And user enters the "Query" "8" in Hive query box and clicks on execute
#    And user waits for the query to be succeeded
#    And user clicks on Hive Viewer
#    And user clicks on Hive View
#    And user enters the "Query" "1" in Hive query box and clicks on execute
#    And user waits for the query to be succeeded
#    And user connects to the sftp server and downloads the "catalogHive" "log" file for Query"1,8"
#    And configure a new REST API for the service "IDC"
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#      | Content-Type  | application/json                   |
#      | Accept        | application/json                   |
#    And supply payload with file name "/ida/hive_config_payload_with_deltatime_3_seconds.json"
#    When user makes a REST Call for PUT request with url "configuration/ingestion/Cluster Demo" with the following query param
#      | raw | false |
#    Then Status code 204 must be returned
#    And user verifies whether all the event files are moved to catalog Hive
#    And user validates the status of cataloger enable query log flag to "true"
#    And user connects to the sftp server and downloads the "xml" "query" file for Query"1"
#    Then The overall xml should have "2" operation Tag and "3" execution Tags
#    And delete the downloaded xml file
#
#  @MLP-1953 @webtest @querylogs @sanity @sftp
#  Scenario:MLP-1953: Verification of Hive Query logs when the same query is executed by a different user
#
#    Given User launch browser and traverse to Ambari login page
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#      | Content-Type  | application/json                   |
#      | Accept        | application/json                   |
#    And supply payload with file name "/ida/hive_config_payload_with_deltatime_300_seconds.json"
#    When user makes a REST Call for PUT request with url "configuration/ingestion/Cluster Demo" with the following query param
#      | raw | false |
#    Then Status code 204 must be returned
#    And user enter credentials for Ambari login
#    And user clicks on Hive Viewer
#    And user clicks on Hive View
#    And user enters the "Query" "8" in Hive query box and clicks on execute
#    And user waits for the query to be succeeded
#    And user clicks on Hive Viewer
#    And user clicks on Hive View
#    And user enters the "Query" "8" in Hive query box and clicks on execute
#    And user waits for the query to be succeeded
#    And user logs in as different user from Putty and execute the same query"8" and different query "13"
#    And user connects to the sftp server and downloads the "catalogHive" "log" file for Query"1,13"
#    And configure a new REST API for the service "IDC"
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#      | Content-Type  | application/json                   |
#      | Accept        | application/json                   |
#    And supply payload with file name "/ida/hive_config_payload_with_deltatime_3_seconds.json"
#    When user makes a REST Call for PUT request with url "configuration/ingestion/Cluster Demo" with the following query param
#      | raw | false |
#    Then Status code 204 must be returned
#    And user verifies whether all the event files are moved to catalog Hive
#    And user validates the status of cataloger enable query log flag to "true"
#    And user connects to the sftp server and downloads the "xml" "query" file for Query"13"
#    Then The overall xml should have "2" operation Tag and "4" execution Tags
#    And delete the downloaded xml file
#
#  @MLP-1658 @webtest @querylogs @sanity @sftp @eventFileDeletion
#  Scenario:MLP-1658: Verification of Hive query logs for SELECT query for a single user.
#
#    Given User launch browser and traverse to Ambari login page
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#      | Content-Type  | application/json                   |
#      | Accept        | application/json                   |
#    And supply payload with file name "/ida/hive_config_payload_with_deltatime_300_seconds.json"
#    When user makes a REST Call for PUT request with url "configuration/ingestion/Cluster Demo" with the following query param
#      | raw | false |
#    Then Status code 204 must be returned
#    And user enter credentials for Ambari login
#    And user clicks on Hive Viewer
#    And user clicks on Hive View
#    And user enters the "Query" "8" in Hive query box and clicks on execute
#    And user waits for the query to be succeeded
#    And user clicks on Hive Viewer
#    And user clicks on Hive View
#    And user enters the "Query" "8" in Hive query box and clicks on execute
#    And user waits for the query to be succeeded
#    And user connects to the sftp server and downloads the "catalogHive" "log" file for Query"8"
#    And configure a new REST API for the service "IDC"
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#      | Content-Type  | application/json                   |
#      | Accept        | application/json                   |
#    And supply payload with file name "/ida/hive_config_payload_with_deltatime_3_seconds.json"
#    When user makes a REST Call for PUT request with url "configuration/ingestion/Cluster Demo" with the following query param
#      | raw | false |
#    Then Status code 204 must be returned
#    And user verifies whether all the event files are moved to catalog Hive
#    And user validates the status of cataloger enable query log flag to "true"
#    And user connects to the sftp server and downloads the "xml" "query" file for Query"8"
#    And user validates the operation,execution Tags and their count ="2" in the xml for the query"8"
#    And delete the downloaded xml file
#
