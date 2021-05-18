Feature: To validate the product code,bundle upload functionality and all bundle metadata information

  @webtest
  Scenario: Verify all the bundles got downloaded from ftp location using product codes
    Given user connects to the FTP server and download the files with below parameters
      | hostName | userName | passWord    | ftpPath           | downloadDirectory             | fileToDownload |
      | ftpHost  | ftpUser  | ftpPassword | IDC/1010/bundles/ | SystemHomeDirectory\\bundles\ | .zip           |
    And user performs "unzip" functions with following parameters
      | downloadDirectory             | fileExtension |
      | SystemHomeDirectory\\bundles\ | .zip          |
    And user performs "delete" functions with following parameters
      | downloadDirectory             | fileExtension |
      | SystemHomeDirectory\\bundles\ | .jar          |


  @webtest
  Scenario Outline: Upload all AWS bundles which are downloaded from ftp
    And user upload bundles from "<path>" with  "<serviceurl>" based on the "<productcode>" and validates "<responsecode>"
    Examples:
      | path                          | serviceurl         | productcode         | responsecode |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | IDG-Git-            | 200          |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | IEA-AvroS3-         | 200          |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | IER-JsonS3-         | 200          |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | IEV-AmazonRedshift- | 200          |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | IEW-AmazonSpectrum- | 200          |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | IEX-AmazonS3-       | 200          |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | IEK-CsvS3-          | 200          |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | IEA-AvroS3-         | 200          |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | IEL-DynamoDB-       | 200          |


  @webtest
  Scenario Outline: Upload all the bundles from downloaded  user home directory
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data            |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And user upload bundles from "<path>" with  "<serviceurl>" based on the "<productcode>" and validates "<responsecode>"
    Examples:
      | path                          | serviceurl         | productcode                   | responsecode |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | IEY-Snowflake-                | 200          |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | IEC-Cdap-                     | 200          |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | IDH-AmbariResolver-           | 200          |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | IDH-Hdfs-                     | 200          |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | IDV-Hive-                     | 200          |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | IEN-CNavigator-               | 200          |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | IDG-Git-                      | 200          |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | IED-UnstructuredDataAnalyzer- | 200          |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | IDM-MLAnalyzer-               | 200          |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | IEP-ParquetAnalyzer-          | 200          |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | ID7-TableauConnector-         | 200          |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | ID6-CdapConnector-            | 200          |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | IDN-NotebookConnector-        | 200          |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | IEA-AvroAnalyzer-             | 200          |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | IEA-AvroS3-                   | 200          |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | IEE-AzureCosmosDatabase-      | 200          |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | IEF-AzureSQLDatabase-         | 200          |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | IEG-AzureSQLDataWarehouse-    | 200          |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | IEH-Cassandra-                | 200          |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | IEO-Gemfire-                  | 200          |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | IEQ-AmbariResolver-           | 200          |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | IER-JsonS3-                   | 200          |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | IES-MongoDB-                  | 200          |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | IET-Neo4j-                    | 200          |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | IDK-Oracle-JDBC-              | 200          |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | IDQ-Oracle-JDBC-              | 200          |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | IEU-Postgres-JDBC-            | 200          |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | IEV-AmazonRedshift-           | 200          |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | IEW-AmazonSpectrum-           | 200          |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | IEX-AmazonS3-                 | 200          |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | IEY-Snowflake-                | 200          |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | IEZ-TeraData-                 | 200          |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | IE2-SQLPostProcessor-         | 200          |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | IE2-UDB-                      | 200          |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | IE4-UDB-                      | 200          |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | IEI-Couchbase-                | 200          |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | IEK-CsvS3-                    | 200          |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | IEC-Cdap-                     | 200          |
      | SystemHomeDirectory\\bundles\ | extensions/bundles | IE3-Java-                     | 200          |

  @webtest
  Scenario: Update product version in metadata,bundle list and Verify list of bundles
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for Get request with url "/health" and store value of json path"$.version"
    And user makes a REST Call for GET request with url "extensions/bundles/Analysis?order=false" and save the response in file "rest/payloads/ida/bundleUpload/actualBundleList.json"
    And user "update" the json file "ida/bundleUpload/expectedbundleList.json" file for following values
      | jsonPath   | type  | jsonValues      |
      | $..version | Array | tempStoredValue |
    And user "update" the json file "ida/bundleUpload/expectedBundleMetadata.json" file for following values
      | jsonPath   | type  | jsonValues      |
      | $..version | Array | tempStoredValue |
    And user makes a REST Call for GET request with url "extensions/bundles/Analysis?order=false" and save the response in file "rest/payloads/ida/bundleUpload/actualBundleList.json"
    Then json assert in expected file "ida/bundleUpload/expectedbundleList.json" and actual file "ida/bundleUpload/actualbundleList.json" should be "equal excluding order"
    And user makes a REST Call for GET request with url "extensions/bundles/Analysis/metadata" and save the response in file "rest/payloads/ida/bundleUpload/actualBundleMetadata.json"
    Then json assert in expected file "ida/bundleUpload/expectedBundleMetadata.json" and actual file "ida/bundleUpload/actualBundleMetadata.json" should be "equal excluding order"

  @webtest
  Scenario Outline:Verify the license code for all bundles
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user hits the "<endpoint>" for the "<bundleName>" and validate "<expectedLicenseCode>" with "<responsecode>" using "<jsonPath>"
    Examples:
      | endpoint                     | bundleName                                    | expectedLicenseCode | responsecode | jsonPath       |
      | extensions/bundles/Analysis/ | com.asg.dis.analysis.Python                   | IDY1                | 200          | $..licenseCode |
      | extensions/bundles/Analysis/ | com.asg.dis.analysis.Java                     | IE3                 | 200          | $..licenseCode |
      | extensions/bundles/Analysis/ | com.asg.dis.analysis.Git                      | IDG                 | 200          | $..licenseCode |
      | extensions/bundles/Analysis/ | com.asg.dis.analysis.LocalFileCollector       | IDL                 | 200          | $..licenseCode |
      | extensions/bundles/Analysis/ | com.asg.dis.analysis.DynamoDB                 | IEL                 | 200          | $..licenseCode |
      | extensions/bundles/Analysis/ | com.asg.dis.analysis.CsvS3                    | IEK                 | 200          | $..licenseCode |
      | extensions/bundles/Analysis/ | com.asg.dis.analysis.JsonS3                   | IER                 | 200          | $..licenseCode |
      | extensions/bundles/Analysis/ | com.asg.dis.analysis.AvroS3                   | IEA                 | 200          | $..licenseCode |
      | extensions/bundles/Analysis/ | com.asg.dis.analysis.AWSGlue                  | IE6                 | 200          | $..licenseCode |
      | extensions/bundles/Analysis/ | com.asg.dis.analysis.AWS                      | IDW                 | 200          | $..licenseCode |
      | extensions/bundles/Analysis/ | com.asg.dis.analysis.MongoDB                  | IES                 | 200          | $..licenseCode |
      | extensions/bundles/Analysis/ | com.asg.dis.analysis.Couchbase                | IEI                 | 200          | $..licenseCode |
      | extensions/bundles/Analysis/ | com.asg.dis.analysis.AzureCosmosDatabase      | IEE                 | 200          | $..licenseCode |
      | extensions/bundles/Analysis/ | com.asg.dis.analysis.Cassandra                | IEH                 | 200          | $..licenseCode |
      | extensions/bundles/Analysis/ | com.asg.dis.analysis.Mobius                   | IEM                 | 200          | $..licenseCode |
      | extensions/bundles/Analysis/ | com.asg.dis.analysis.UnstructuredDataAnalyzer | IED                 | 200          | $..licenseCode |
      | extensions/bundles/Analysis/ | com.asg.dis.analysis.AmazonS3                 | IEX                 | 200          | $..licenseCode |
      | extensions/bundles/Analysis/ | com.asg.dis.analysis.AmazonRedShift           | IEV                 | 200          | $..licenseCode |
      | extensions/bundles/Analysis/ | com.asg.dis.analysis.AmazonSpectrum           | IEW                 | 200          | $..licenseCode |
      | extensions/bundles/Analysis/ | com.asg.dis.analysis.TeraDataDB               | IEZ                 | 200          | $..licenseCode |
      | extensions/bundles/Analysis/ | com.asg.dis.analysis.SQLPostProcessor         | IE4                 | 200          | $..licenseCode |
      | extensions/bundles/Analysis/ | com.asg.dis.analysis.Snowflake                | IEY                 | 200          | $..licenseCode |
      | extensions/bundles/Analysis/ | com.asg.dis.analysis.PostgreSQLDB             | IEU                 | 200          | $..licenseCode |
      | extensions/bundles/Analysis/ | com.asg.dis.analysis.OracleDB                 | IDK                 | 200          | $..licenseCode |
      | extensions/bundles/Analysis/ | com.asg.dis.analysis.Cdap                     | null                | 200          | $..licenseCode |
      | extensions/bundles/Analysis/ | com.asg.dis.analysis.Neo4j                    | IET                 | 200          | $..licenseCode |
      | extensions/bundles/Analysis/ | com.asg.dis.analysis.Gemfire                  | IEO                 | 200          | $..licenseCode |
      | extensions/bundles/Analysis/ | com.asg.dis.analysis.AzureSQLDatabase         | IEF                 | 200          | $..licenseCode |
      | extensions/bundles/Analysis/ | com.asg.dis.analysis.AzureSQLDataWarehouse    | IEG                 | 200          | $..licenseCode |
      | extensions/bundles/Analysis/ | com.asg.dis.analysis.CNavigator               | IEN                 | 200          | $..licenseCode |
      | extensions/bundles/Analysis/ | com.asg.dis.ingestion.Hdfs                    | null                | 200          | $..licenseCode |
      | extensions/bundles/Analysis/ | com.asg.dis.ingestion.Hive                    | null                | 200          | $..licenseCode |
      | extensions/bundles/Analysis/ | com.asg.dis.ingestion.BigDataAnalyzer         | null                | 200          | $..licenseCode |
      | extensions/bundles/Analysis/ | com.asg.dis.ingestion.HBase                   | null                | 200          | $..licenseCode |
      | extensions/bundles/Analysis/ | com.asg.dis.ingestion.AmbariResolver          | null                | 200          | $..licenseCode |
      | extensions/bundles/Analysis/ | com.asg.dis.ingestion.AvroAnalyzer            | null                | 200          | $..licenseCode |
      | extensions/bundles/Analysis/ | com.asg.dis.ingestion.ParquetAnalyzer         | null                | 200          | $..licenseCode |
      | extensions/bundles/Analysis/ | com.asg.dis.ingestion.MLAnalyzer              | null                | 200          | $..licenseCode |
      | extensions/bundles/Dataset/  | com.asg.dis.platform.NotebookConnector        | null                | 200          | $..licenseCode |
#      | extensions/bundles/Dataset/  | com.asg.dis.platform.TableauConnector         | ID7                 | 200          | $..licenseCode |
      | extensions/bundles/Dataset/  | com.asg.dis.plat form.CdapConnector           | null                | 200          | $..licenseCode |

