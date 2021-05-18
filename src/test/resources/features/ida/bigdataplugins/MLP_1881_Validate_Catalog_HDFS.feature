#Feature:MLP-1881: Validate the ScanHDFS file content created by ingestion process
#
#  @MLP-1881 @webtest @sftp @regression @sanity @positive
#  Scenario: Validate the ScanHDFS file generated for the ingestion process for included scan directories in HDFS
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "ida/HDFSIngestionConfigurationInclusionFilter.json"
#    And user makes a REST Call for PUT request with url "configuration/ingestion/Cluster%20Demo"
#    And Status code 204 must be returned
#    And user makes a REST Call for Get request with url "configuration/ingestion/Cluster%20Demo"
#    And Status code 200 must be returned
#    And response message contains value "com.asg.dis.common.ingestion.dom.HdfsConfiguration"
#    And user makes a REST Call for POST request with url "ingestion/start/Cluster%20Demo/cataloger/com.asg.dis.common.ingestion.dom.HdfsConfiguration/com.asg.dis.common.ingestion.dom.HdfsConfiguration"
#    And Status code 204 must be returned
#    When user makes a recursive REST Call for GET request "ingestion/status/Cluster%20Demo/cataloger/com.asg.dis.common.ingestion.dom.HdfsConfiguration/com.asg.dis.common.ingestion.dom.HdfsConfiguration" till the status becomes "IDLE" with maximum threshhold of "5" times
#    And user retrives the file "ScanHDFS.xml" from remote location "/opt/BigDataCatalog/CatalogHDFS"
#    And verify the HDFS scanned content to include the following
#      | icluster     | idirectory    | ifile                          | igroup | icreatedBy | itags   |
#      | Cluster Demo | /qa/remaining | sales_fact_dec_1998 sample.csv | hdfs   | raj_ops    | BigData |
#      | Cluster Demo | /qa/product   | product_sample.csv             | hdfs   | raj_ops    | BigData |
#      | Cluster Demo | /qa/customer  | customer_sample.csv            | hdfs   | raj_ops    | BigData |
#
#  @MLP-1881 @webtest @sftp @regression @sanity @positive
#  Scenario: Validate the ScanHDFS file generated for the ingestion process for excluded scan directories in HDFS
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "ida/HDFSIngestionConfigurationExclusionFilter.json"
#    And user makes a REST Call for PUT request with url "configuration/ingestion/Cluster%20Demo"
#    And Status code 204 must be returned
#    And user makes a REST Call for Get request with url "configuration/ingestion/Cluster%20Demo"
#    And Status code 200 must be returned
#    And response message contains value "com.asg.dis.common.ingestion.dom.HdfsConfiguration"
#    And user makes a REST Call for POST request with url "ingestion/start/Cluster%20Demo/cataloger/com.asg.dis.common.ingestion.dom.HdfsConfiguration/com.asg.dis.common.ingestion.dom.HdfsConfiguration"
#    And Status code 204 must be returned
#    When user makes a recursive REST Call for GET request "ingestion/status/Cluster%20Demo/cataloger/com.asg.dis.common.ingestion.dom.HdfsConfiguration/com.asg.dis.common.ingestion.dom.HdfsConfiguration" till the status becomes "IDLE" with maximum threshhold of "5" times
#    And user retrives the file "ScanHDFS.xml" from remote location "/opt/BigDataCatalog/CatalogHDFS"
#    And verify the hdfs scanned content not to include files and the excluded directory
#      | icluster     | idirectory   | igroup | icreatedBy | itags   |
#      | Cluster Demo | /qa/customer | hdfs   | raj_ops    | BigData |
#





