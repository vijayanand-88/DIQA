#@SimplifiedConfiguration
#Feature: This feature verifies the Hive and HDFS config properties in the Hiva and Hdfs xml
#
#  Description:
#  This feature verifies the Hive and HDFS config properties in the Hiva and Hdfs xml's
#Scan Hive and ScanHDFS xml is not available now to verify this feature
#  @SimplifiedConfiguration @sftp @hive_hdfs
#  Scenario:MLP-606: This scenario to validate cataloger hive settings querylog flag as false in catalog hive.xml
#    Given configure a new REST API for the service "Ambari"
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization  | Basic cmFqX29wczpyYWpfb3Bz |
#      | X-Requested-By | ambari                     |
#    And Add a random version for the "idc/SimplifiedConfigurationHiveQueryLogFalse.json" payload
#    And supply payload with file name "idc/SimplifiedConfigurationHiveQueryLogFalse.json"
#    When user makes a REST Call for PUT request with url "clusters/Sandbox"
#    And Status code 200 must be returned
#    And sync the test execution for "15" seconds
#    And configure a new REST API for the service "Ambari"
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization  | Basic cmFqX29wczpyYWpfb3Bz |
#      | X-Requested-By | ambari                     |
#    And supply payload with file name "idc/StopCatalogerService.json"
#    And user makes a REST Call for PUT request with url "clusters/Sandbox/services/IDANODE"
#    And verify the Ambari status with the status code "202"
#    And sync the test execution for "15" seconds
#    And configure a new REST API for the service "Ambari"
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization  | Basic cmFqX29wczpyYWpfb3Bz |
#      | X-Requested-By | ambari                     |
#    And supply payload with file name "idc/StartCatalogerService.json"
#    When user makes a REST Call for PUT request with url "clusters/Sandbox/services/IDANODE"
#    And sync the test execution for "15" seconds
#    And user connects to the sftp server and downloads the "hive" "xml" file for Query""
#    Then verify all the "hive" config parameters in the xml
#      | cataloger.enable.queryLog | false                                  |
#      | cataloger.keytab          | /etc/security/keytabs/cataloger.keytab |
#      | cataloger.krb.conf        | /etc/krb5.conf                         |
#      | cataloger.krb.principal   | hive@PRINCIPAL.COM                     |
#    And delete the downloaded "IdcScanHive.xml" file
#
#
#  @SimplifiedConfiguration @sftp @hive_hdfs
#  Scenario:MLP-606: This scenario to validate cataloger hive settings querylog flag as true in catalog hive.xml
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
#    And user makes a REST Call for PUT request with url "clusters/Sandbox/services/IDANODE"
#    And verify the Ambari status with the status code "202"
#    And sync the test execution for "15" seconds
#    And configure a new REST API for the service "Ambari"
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization  | Basic cmFqX29wczpyYWpfb3Bz |
#      | X-Requested-By | ambari                     |
#    And supply payload with file name "idc/StartCatalogerService.json"
#    When user makes a REST Call for PUT request with url "clusters/Sandbox/services/IDANODE"
#    And sync the test execution for "15" seconds
#    And user connects to the sftp server and downloads the "hive" "xml" file for Query""
#    Then verify all the "hive" config parameters in the xml
#      | cataloger.enable.queryLog | true                                  |
#      | cataloger.keytab          | /etc/security/keytabs/cataloger.keytab |
#      | cataloger.krb.conf        | /etc/krb5.conf                         |
#      | cataloger.krb.principal   | hive@PRINCIPAL.COM                     |
#    And delete the downloaded "IdcScanHive.xml" file
#
#
#  @SimplifiedConfiguration @sftp @hive_hdfs
#  Scenario:MLP-606: This scenario to validate cataloger hdfs settings scan hdfs as false in catalog hive.xml
#    Given configure a new REST API for the service "Ambari"
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization  | Basic cmFqX29wczpyYWpfb3Bz |
#      | X-Requested-By | ambari                     |
#    And Add a random version for the "idc/SimplifiedConfigurationHdfsScanHdfsFalse.json" payload
#    And sync the test execution for "15" seconds
#    And supply payload with file name "idc/SimplifiedConfigurationHdfsScanHdfsFalse.json"
#    When user makes a REST Call for PUT request with url "clusters/Sandbox"
#    And Status code 200 must be returned
#    And sync the test execution for "15" seconds
#    And configure a new REST API for the service "Ambari"
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization  | Basic cmFqX29wczpyYWpfb3Bz |
#      | X-Requested-By | ambari                     |
#    And supply payload with file name "idc/StopCatalogerService.json"
#    And user makes a REST Call for PUT request with url "clusters/Sandbox/services/IDANODE"
#    And verify the Ambari status with the status code "202"
#    And sync the test execution for "15" seconds
#    And configure a new REST API for the service "Ambari"
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization  | Basic cmFqX29wczpyYWpfb3Bz |
#      | X-Requested-By | ambari                     |
#    And supply payload with file name "idc/StartCatalogerService.json"
#    When user makes a REST Call for PUT request with url "clusters/Sandbox/services/IDANODE"
#    And sync the test execution for "15" seconds
#    And user connects to the sftp server and downloads the "hdfs" "xml" file for Query""
#    Then verify all the "hdfs" config parameters in the xml
#      | cataloger.krb.principal       | hdfs@PRINCIPAL.COM                     |
#      | cataloger.manager.host        | localhost                              |
#      | cataloger.manager.port        | 8080                                   |
#      | cataloger.manager.user        | raj_ops                                |
#      | cataloger.scan.hdfs           | false                                  |
#      | cataloger.scan.services       | true                                   |
#    And delete the downloaded "IdcScanHdfs.xml" file
#
#
#  @SimplifiedConfiguration @sftp @hive_hdfs
#  Scenario:MLP-606: This scenario to validate cataloger hdfs settings scan hdfs as true in catalog hive.xml
#    Given configure a new REST API for the service "Ambari"
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization  | Basic cmFqX29wczpyYWpfb3Bz |
#      | X-Requested-By | ambari                     |
#    And Add a random version for the "idc/SimplifiedConfigurationHdfsScanHdfsTrue.json" payload
#    And sync the test execution for "15" seconds
#    And supply payload with file name "idc/SimplifiedConfigurationHdfsScanHdfsTrue.json"
#    When user makes a REST Call for PUT request with url "clusters/Sandbox"
#    And Status code 200 must be returned
#    And sync the test execution for "15" seconds
#    And configure a new REST API for the service "Ambari"
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization  | Basic cmFqX29wczpyYWpfb3Bz |
#      | X-Requested-By | ambari                     |
#    And supply payload with file name "idc/StopCatalogerService.json"
#    And user makes a REST Call for PUT request with url "clusters/Sandbox/services/IDANODE"
#    And verify the Ambari status with the status code "202"
#    And sync the test execution for "15" seconds
#    And configure a new REST API for the service "Ambari"
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization  | Basic cmFqX29wczpyYWpfb3Bz |
#      | X-Requested-By | ambari                     |
#    And supply payload with file name "idc/StartCatalogerService.json"
#    When user makes a REST Call for PUT request with url "clusters/Sandbox/services/IDANODE"
#    And sync the test execution for "15" seconds
#    And user connects to the sftp server and downloads the "hdfs" "xml" file for Query""
#    Then verify all the "hdfs" config parameters in the xml
#      | cataloger.hdfs.user           | hdfs                                   |
#      | cataloger.keytab              | /etc/security/keytabs/cataloger.keytab |
#      | cataloger.krb.conf            | /etc/krb5.conf                         |
#      | cataloger.krb.principal       | hdfs@PRINCIPAL.COM                     |
#      | cataloger.scan.hdfs           | true                                   |
#      | cataloger.scan.services       | false                                  |
#    And delete the downloaded "IdcScanHdfs.xml" file