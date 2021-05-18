#@MLP-1880
#Feature:MLP-1880: Validate the ScanHIVE file content created by ingestion process
#
#  @MLP-1880 @webtest @sftp @regression @sanity @positive
#  Scenario:MLP-1880: Validate the ScanHIVE.xml file generated for the ingestion process run on HIVE tables
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "ida/HIVEIngestionConfiguration.json"
#    And user makes a REST Call for PUT request with url "configuration/ingestion/Cluster%20Demo"
#    And Status code 204 must be returned
#    And user makes a REST Call for Get request with url "configuration/ingestion/Cluster%20Demo"
#    And Status code 200 must be returned
#    And response message contains value "com.asg.dis.common.ingestion.dom.HiveConfiguration"
#    And user makes a REST Call for POST request with url "ingestion/start/Cluster%20Demo/cataloger/com.asg.dis.common.ingestion.dom.HiveConfiguration/com.asg.dis.common.ingestion.dom.HiveConfiguration"
#    And Status code 204 must be returned
#    When user makes a recursive REST Call for GET request "ingestion/status/Cluster%20Demo/cataloger/com.asg.dis.common.ingestion.dom.HiveConfiguration/com.asg.dis.common.ingestion.dom.HiveConfiguration" till the status becomes "IDLE" with maximum threshhold of "5" times
#    And user retrives the file "ScanHive.xml" from remote location "/opt/BigDataCatalog/CatalogHive"
#    Then verify the HIVE scanned content to include the following clusterName dbSystemName
#      | cluster      | dbSystem |
#      | Cluster Demo | Hive     |
#    And verify the HIVE scanned content to include the following datatype content
#      | dataType | xmiid  | dataLength | dataScale | stage   | def    |
#      | int      | int    |            |           | BigData | int    |
#      | string   | string |            |           | BigData | string |
#    And verify the HIVE scanned content to include the following database content
#      | database | dblocation                    | dbstorageType | dbtags              | dbdef |
#      | idaqa    | /apps/hive/warehouse/idaqa.db | rbd/hive      | LandingArea,BigData |       |
#    And verify the HIVE scanned content to include the following table content
#      | table    | tbucketsNumber | tcreatedBy | tdelimitedFields                      | tfilesCount | tinputType                               | tlocation                              | tmodifiedAt | tmodifiedBy | tpartitionedBy | tserdeLibrary                                      | ttags               | tstorageType |
#      | employee | -1             | root       | field.delim=\u0009, line.delim=\u000a | 6           | org.apache.hadoop.mapred.TextInputFormat | /apps/hive/warehouse/idaqa.db/employee |             |             |                | org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe | LandingArea,BigData | managed      |
#    And verify the HIVE scanned content to include the following colummn content
#      | column      | cdataOfType | cdataType | cxmiid                     | ctags               |
#      | eid         | int         | int       | idaqa.employee.eid         | LandingArea,BigData |
#      | name        | string      | string    | idaqa.employee.name        | LandingArea,BigData |
#      | salary      | string      | string    | idaqa.employee.salary      | LandingArea,BigData |
#      | destination | string      | string    | idaqa.employee.destination | LandingArea,BigData |

