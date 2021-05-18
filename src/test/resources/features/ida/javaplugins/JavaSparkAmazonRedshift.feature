@MLP-10512
Feature:Verification of Java Spark Lineage with Amazon Redshift Data Source


  @javaspark @MLP-10512
  Scenario Outline: SC#1-Configurations for Plugins - Git, Amazon Redshift Cataloger, Java Parser and Java Spark Lineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                         | body                                                                                   | response code | response message         | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/Git_Credentials        | ida/javaSparkPayloads/MLP-10512_redshift/Plugin_Payloads/gitCredentials.json           | 200           |                          |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/GitCollectorDataSource   | ida/javaSparkPayloads/MLP-10512_redshift/Plugin_Payloads/GitCollectorDataSource.json   | 204           |                          |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/GitCollectorDataSource   |                                                                                        | 200           | GitCollectorDataSource   |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/GitCollector             | ida/javaSparkPayloads/MLP-10512_redshift/Plugin_Payloads/GitCollector.json             | 204           |                          |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/GitCollector             |                                                                                        | 200           | GitCollector             |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/Redshift_Credentials   | ida/javaSparkPayloads/MLP-10512_redshift/Plugin_Payloads/redShiftCredentials.json      | 200           |                          |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/AmazonRedshiftDataSource | ida/javaSparkPayloads/MLP-10512_redshift/Plugin_Payloads/AmazonRedshiftDataSource.json | 204           |                          |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/AmazonRedshiftDataSource |                                                                                        | 200           | AmazonRedshiftDataSource |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/AmazonRedshiftCataloger  | ida/javaSparkPayloads/MLP-10512_redshift/Plugin_Payloads/AmazonRedshiftCataloger.json  | 204           |                          |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/AmazonRedshiftCataloger  |                                                                                        | 200           | AmazonRedshiftCataloger  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/JavaParser               | ida/javaSparkPayloads/MLP-10512_redshift/Plugin_Payloads/JavaParser.json               | 204           |                          |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/JavaParser               |                                                                                        | 200           | JavaParser               |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/JavaSparkLineage         | ida/javaSparkPayloads/MLP-10512_redshift/Plugin_Payloads/JavaSparkLineage.json         | 204           |                          |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/JavaSparkLineage         |                                                                                        | 200           | JavaSparkLineage         |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/HdfsCataloger          | ida/javaSparkPayloads/HdfsCataloger.json                              | 204           |                        |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/HdfsCataloger          |                                                                       | 200           | javaSparkLineage       |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/BigDataAnalyzer        | ida/javaSparkPayloads/BigDataAnalyzer.json                            | 204           |                        |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/BigDataAnalyzer        |                                                                       | 200           | javaSparkLineage       |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/ParquetAnalyzer        | ida/javaSparkPayloads/ParquetAnalyzer.json                            | 204           |                        |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/ParquetAnalyzer        |                                                                       | 200           | javaSparkLineage       |          |


  @javaspark @MLP-10513
  Scenario Outline: SC#2-Run the Plugin configurations for Git, Amazon Redshift Cataloger, Java Parser, Java Linker and JavaJDBCLineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                             | body                                                                | response code | response message | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector                       |                                                                     | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status            |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector                        | ida/javaSparkPayloads/MLP-10512_redshift/Plugin_Payloads/Empty.json | 200           |                  |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector                       |                                                                     | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status            |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/AmazonRedshiftCataloger |                                                                     | 200           | IDLE             | $.[?(@.configurationName=='AmazonRedshiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/AmazonRedshiftCataloger  | ida/javaSparkPayloads/MLP-10512_redshift/Plugin_Payloads/Empty.json | 200           |                  |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/AmazonRedshiftCataloger |                                                                     | 200           | IDLE             | $.[?(@.configurationName=='AmazonRedshiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaParser                              |                                                                     | 200           | IDLE             | $.[?(@.configurationName=='JavaParser')].status              |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/parser/JavaParser/JavaParser                               | ida/javaSparkPayloads/MLP-10512_redshift/Plugin_Payloads/Empty.json | 200           |                  |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaParser                              |                                                                     | 200           | IDLE             | $.[?(@.configurationName=='JavaParser')].status              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaSparkLineage/JavaSparkLineage                 |                                                                     | 200           | IDLE             | $.[?(@.configurationName=='JavaSparkLineage')].status        |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/lineage/JavaSparkLineage/JavaSparkLineage                  | ida/javaSparkPayloads/MLP-10512_redshift/Plugin_Payloads/Empty.json | 200           |                  |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaSparkLineage/JavaSparkLineage                 |                                                                     | 200           | IDLE             | $.[?(@.configurationName=='JavaSparkLineage')].status        |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/HdfsCataloger/HdfsCataloger                   |                                             | 200           | IDLE             | $.[?(@.configurationName=='HdfsCataloger')].status          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/HdfsCataloger/HdfsCataloger                    | ida/javaSparkPayloads/JavaSparkLineage.json | 200           |                  |                                                             |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/HdfsCataloger/HdfsCataloger                   |                                             | 200           | IDLE             | $.[?(@.configurationName=='HdfsCataloger')].status          |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/BigDataAnalyzer/BigDataAnalyzer            |                                             | 200           | IDLE             | $.[?(@.configurationName=='BigDataAnalyzer')].status        |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/BigDataAnalyzer/ParquetAnalyzer            |                                             | 200           | IDLE             | $.[?(@.configurationName=='ParquetAnalyzer')].status        |


  ###############################TechnologyTagValidation#################################

  @webtest @MLP-10513 @sanity @positive @regression
  Scenario: SC#3_Verify the technology tags got assigned to all Cataloged items like Function, DF tables and Lineage HOPS
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Java_RedshiftDataSource" and clicks on search
    And user performs "facet selection" in "Java_RedshiftDataSource" attribute under "Tags" facets in Item Search results page
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag                                    | fileName                      | userTag                 |
      | Default     | File       | Metadata Type | Git,Java_RedshiftDataSource,Java,Spark | Spark_RedshiftToParquet.java  | Java_RedshiftDataSource |
      | Default     | SourceTree | Metadata Type | Java_RedshiftDataSource,Java,Spark     | Spark_CsvToRedshift           | Java_RedshiftDataSource |
      | Default     | Table      | Metadata Type | Java_RedshiftDataSource,Redshift       | writeqa_redshiftdepartment    | Java_RedshiftDataSource |
      | Default     | Class      | Metadata Type | Java_RedshiftDataSource,Java           | Spark_Redshift_Multiple_Write | Java_RedshiftDataSource |
      | Default     | Function   | Metadata Type | Java_RedshiftDataSource,Java,Spark     | doReadRedShift                | Java_RedshiftDataSource |
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag         | fileName                      | userTag                 |
      | Default     | Class      | Metadata Type | Programming | Spark_Redshift_Multiple_Write | Java_RedshiftDataSource |
      | Default     | Function   | Metadata Type | Programming | doReadRedShift                | Java_RedshiftDataSource |
      | Default     | SourceTree | Metadata Type | Programming | Spark_CsvToRedshift           | Java_RedshiftDataSource |
    And user enters the search text "Java_RedshiftDataSource" and clicks on search
    And user performs "facet selection" in "Java_RedshiftDataSource" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "doReadRedShift" item from search results
    Then user performs click and verify in new window
      | Table        | value                                      | Action               | RetainPrevwindow | indexSwitch |
      | Lineage Hops | custid => writeqa_redshiftcustomers.custid | click and switch tab | No               |             |
    And verify "verifies presence" of technology tags in navigated items
      | Tag  | Java_RedshiftDataSource,Java,Spark         |
      | item | custid => writeqa_redshiftcustomers.custid |


    ###############################Lineage Hops Validation in UI ###################################

  #6638630# #6638631# #6638632# #6638633#
  @webtest @javaspark @MLP-10512 @regression @positive @MLP-14276
  Scenario: SC4_Verify Lineage Hops in UI for doReadRedShift function
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Java_RedshiftDataSource" and clicks on search
    And user performs "facet selection" in "Java_RedshiftDataSource" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "doReadRedShift" item from search results
    Then user performs click and verify in new window
      | Table        | value                                            | Action                       | RetainPrevwindow | indexSwitch | filePath                                                                      | jsonPath    |
      | Lineage Hops | custid => writeqa_redshiftcustomers.custid       | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10512_redshift/Lineage_Payloads/doReadRedShift.json | $.custid    |
      | Lineage Hops | custname => writeqa_redshiftcustomers.custname   | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10512_redshift/Lineage_Payloads/doReadRedShift.json | $.custname  |
      | Lineage Hops | redshiftcustomers.address => jdbcDF_r1.address   | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10512_redshift/Lineage_Payloads/doReadRedShift.json | $.address   |
      | Lineage Hops | redshiftcustomers.city => jdbcDF_r1.city         | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10512_redshift/Lineage_Payloads/doReadRedShift.json | $.city      |
      | Lineage Hops | redshiftcustomers.custid => jdbcDF_r1.custid     | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10512_redshift/Lineage_Payloads/doReadRedShift.json | $.custid1   |
      | Lineage Hops | redshiftcustomers.custname => jdbcDF_r1.custname | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10512_redshift/Lineage_Payloads/doReadRedShift.json | $.custname1 |

  @webtest @javaspark @MLP-10512 @regression @positive @MLP-14276
  Scenario: SC5_Verify Lineage Hops in UI for doReadRedShiftJDBC function
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Java_RedshiftDataSource" and clicks on search
    And user performs "facet selection" in "Java_RedshiftDataSource" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "doReadRedshiftJDBC" item from search results
    Then user performs click and verify in new window
      | Table        | value                                               | Action                       | RetainPrevwindow | indexSwitch | filePath                                                                          | jsonPath     |
      | Lineage Hops | deptblock => writeqa_redshiftdepartment.deptblock   | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10512_redshift/Lineage_Payloads/doReadRedShiftJDBC.json | $.deptblock  |
      | Lineage Hops | deptid => writeqa_redshiftdepartment.deptid         | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10512_redshift/Lineage_Payloads/doReadRedShiftJDBC.json | $.deptid     |
      | Lineage Hops | deptname => writeqa_redshiftdepartment.deptname     | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10512_redshift/Lineage_Payloads/doReadRedShiftJDBC.json | $.deptname   |
      | Lineage Hops | redshiftdepartment.deptblock => jdbcDF_r2.deptblock | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10512_redshift/Lineage_Payloads/doReadRedShiftJDBC.json | $.deptblock1 |
      | Lineage Hops | redshiftdepartment.deptid => jdbcDF_r2.deptid       | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10512_redshift/Lineage_Payloads/doReadRedShiftJDBC.json | $.deptid1    |
      | Lineage Hops | redshiftdepartment.deptname => jdbcDF_r2.deptname   | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10512_redshift/Lineage_Payloads/doReadRedShiftJDBC.json | $.deptname1  |

  @webtest @javaspark @MLP-10512 @regression @positive @MLP-14276
  Scenario: SC6_Verify Lineage Hops in UI for doReadRedshiftMultipleWrite function
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Java_RedshiftDataSource" and clicks on search
    And user performs "facet selection" in "Java_RedshiftDataSource" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "doReadRedshiftMultipleWrite" item from search results
    Then user performs click and verify in new window
      | Table        | value                                       | Action                       | RetainPrevwindow | indexSwitch | filePath                                                                                  | jsonPath    |
      | Lineage Hops | job_desc => qa_java_redshiftjobs1.job_desc  | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10512_redshift/Lineage_Payloads/doReadRedshiftMultipleWrite.json | $.job_desc  |
      | Lineage Hops | job_desc => qa_java_redshiftjobs2.job_desc  | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10512_redshift/Lineage_Payloads/doReadRedshiftMultipleWrite.json | $.job_desc1 |
      | Lineage Hops | job_id => qa_java_redshiftjobs1.job_id      | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10512_redshift/Lineage_Payloads/doReadRedshiftMultipleWrite.json | $.job_id    |
      | Lineage Hops | job_id => qa_java_redshiftjobs2.job_id      | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10512_redshift/Lineage_Payloads/doReadRedshiftMultipleWrite.json | $.job_id1   |
      | Lineage Hops | max_lvl => qa_java_redshiftjobs1.max_lvl    | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10512_redshift/Lineage_Payloads/doReadRedshiftMultipleWrite.json | $.max_lvl   |
      | Lineage Hops | max_lvl => qa_java_redshiftjobs2.max_lvl    | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10512_redshift/Lineage_Payloads/doReadRedshiftMultipleWrite.json | $.max_lvl1  |
      | Lineage Hops | min_lvl => qa_java_redshiftjobs1.min_lvl    | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10512_redshift/Lineage_Payloads/doReadRedshiftMultipleWrite.json | $.min_lvl   |
      | Lineage Hops | min_lvl => qa_java_redshiftjobs2.min_lvl    | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10512_redshift/Lineage_Payloads/doReadRedshiftMultipleWrite.json | $.min_lvl1  |
      | Lineage Hops | redshiftjobs.job_desc => jdbcDF_r3.job_desc | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10512_redshift/Lineage_Payloads/doReadRedshiftMultipleWrite.json | $.job_desc3 |
      | Lineage Hops | redshiftjobs.job_id => jdbcDF_r3.job_id     | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10512_redshift/Lineage_Payloads/doReadRedshiftMultipleWrite.json | $.job_id3   |
      | Lineage Hops | redshiftjobs.max_lvl => jdbcDF_r3.max_lvl   | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10512_redshift/Lineage_Payloads/doReadRedshiftMultipleWrite.json | $.max_lvl3  |
      | Lineage Hops | redshiftjobs.min_lvl => jdbcDF_r3.min_lvl   | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10512_redshift/Lineage_Payloads/doReadRedshiftMultipleWrite.json | $.min_lvl3  |

  @webtest @javaspark @MLP-10512 @regression @positive @MLP-14276
  Scenario: SC7_Verify Lineage Hops in UI for doReadRedshiftOverwrite function
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Java_RedshiftDataSource" and clicks on search
    And user performs "facet selection" in "Java_RedshiftDataSource" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "doReadRedshiftOverwrite" item from search results
    Then user performs click and verify in new window
      | Table        | value                                             | Action                       | RetainPrevwindow | indexSwitch | filePath                                                                              | jsonPath     |
      | Lineage Hops | address => writeqa_ow_redshiftpersons.address     | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10512_redshift/Lineage_Payloads/doReadRedshiftOverwrite.json | $.address    |
      | Lineage Hops | city => writeqa_ow_redshiftpersons.city           | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10512_redshift/Lineage_Payloads/doReadRedshiftOverwrite.json | $.city       |
      | Lineage Hops | firstname => writeqa_ow_redshiftpersons.firstname | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10512_redshift/Lineage_Payloads/doReadRedshiftOverwrite.json | $.firstname  |
      | Lineage Hops | lastname => writeqa_ow_redshiftpersons.lastname   | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10512_redshift/Lineage_Payloads/doReadRedshiftOverwrite.json | $.lastname   |
      | Lineage Hops | personid => writeqa_ow_redshiftpersons.personid   | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10512_redshift/Lineage_Payloads/doReadRedshiftOverwrite.json | $.personid   |
      | Lineage Hops | redshiftpersons.address => jdbcDF_r4.address      | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10512_redshift/Lineage_Payloads/doReadRedshiftOverwrite.json | $.address1   |
      | Lineage Hops | redshiftpersons.city => jdbcDF_r4.city            | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10512_redshift/Lineage_Payloads/doReadRedshiftOverwrite.json | $.city1      |
      | Lineage Hops | redshiftpersons.firstname => jdbcDF_r4.firstname  | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10512_redshift/Lineage_Payloads/doReadRedshiftOverwrite.json | $.firstname1 |
      | Lineage Hops | redshiftpersons.lastname => jdbcDF_r4.lastname    | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10512_redshift/Lineage_Payloads/doReadRedshiftOverwrite.json | $.lastname1  |
      | Lineage Hops | redshiftpersons.personid => jdbcDF_r4.personid    | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10512_redshift/Lineage_Payloads/doReadRedshiftOverwrite.json | $.personid1  |

    ###############################Lineage Hops - Source and Target Validations in API ###################################

  #6638630# #6638631# #6638632# #6638633#
  @javaspark @MLP-10512 @regression @positive @MLP-14276
  Scenario Outline:SC8-user connects to database and retrieves Lineage Hops Ids in order ot find Source and Target Data
    Given user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive    | catalog | type       | name                          | asg_scopeid | targetFile                                                                         | jsonpath     |
      | APPDBPOSTGRES | ClassID    | Default | Class      | Spark_Redshift_Format_Select  |             | response/java/javaSpark/javaSparkRedshift/Lineage/doReadRedShift.json              |              |
      | APPDBPOSTGRES | FunctionID | Default |            | doReadRedShift                |             | response/java/javaSpark/javaSparkRedshift/Lineage/doReadRedShift.json              |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                               |             | response/java/javaSpark/javaSparkRedshift/Lineage/doReadRedShift.json              | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | Spark_Redshift_JDBC           |             | response/java/javaSpark/javaSparkRedshift/Lineage/doReadRedshiftJDBC.json          |              |
      | APPDBPOSTGRES | FunctionID | Default |            | doReadRedshiftJDBC            |             | response/java/javaSpark/javaSparkRedshift/Lineage/doReadRedshiftJDBC.json          |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                               |             | response/java/javaSpark/javaSparkRedshift/Lineage/doReadRedshiftJDBC.json          | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | Spark_Redshift_Multiple_Write |             | response/java/javaSpark/javaSparkRedshift/Lineage/doReadRedshiftMultipleWrite.json |              |
      | APPDBPOSTGRES | FunctionID | Default |            | doReadRedshiftMultipleWrite   |             | response/java/javaSpark/javaSparkRedshift/Lineage/doReadRedshiftMultipleWrite.json |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                               |             | response/java/javaSpark/javaSparkRedshift/Lineage/doReadRedshiftMultipleWrite.json | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | Spark_Redshift_Overwrite      |             | response/java/javaSpark/javaSparkRedshift/Lineage/doReadRedshiftOverwrite.json     |              |
      | APPDBPOSTGRES | FunctionID | Default |            | doReadRedshiftOverwrite       |             | response/java/javaSpark/javaSparkRedshift/Lineage/doReadRedshiftOverwrite.json     |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                               |             | response/java/javaSpark/javaSparkRedshift/Lineage/doReadRedshiftOverwrite.json     | $.functionID |


  @javaspark @MLP-10512 @regression @positive @MLP-14276
  Scenario Outline: SC9-user retrieves the Lineage From and Lineage To data for lineage hop ids
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user get source and target name from REST "<url>" for each "<item>" lineage hop ids from "<inputFile>" and store source and target  name in "<outputFile>"
    Examples:
      | url                                                                      | item                        | inputFile                                                                          | outputFile                                                                                  |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | doReadRedShift              | response/java/javaSpark/javaSparkRedshift/Lineage/doReadRedShift.json              | response/java/javaSpark/javaSparkRedshift/Lineage/JavaSparkLineageRedshiftSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | doReadRedshiftJDBC          | response/java/javaSpark/javaSparkRedshift/Lineage/doReadRedshiftJDBC.json          | response/java/javaSpark/javaSparkRedshift/Lineage/JavaSparkLineageRedshiftSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | doReadRedshiftMultipleWrite | response/java/javaSpark/javaSparkRedshift/Lineage/doReadRedshiftMultipleWrite.json | response/java/javaSpark/javaSparkRedshift/Lineage/JavaSparkLineageRedshiftSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | doReadRedshiftOverwrite     | response/java/javaSpark/javaSparkRedshift/Lineage/doReadRedshiftOverwrite.json     | response/java/javaSpark/javaSparkRedshift/Lineage/JavaSparkLineageRedshiftSourceTarget.json |

  @javaspark @MLP-10512 @regression @positive @MLP-14276
  Scenario Outline: SC10-Lineage Hops Final Validation using API
    Given expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                                                         | actual_json                                                                                                   | item                        |
      | ida/javaSparkPayloads/MLP-10512_redshift/ExpectedLineageTargets/expectedJavaSparkLineageRedshift.json | Constant.REST_DIR/response/java/javaSpark/javaSparkRedshift/Lineage/JavaSparkLineageRedshiftSourceTarget.json | doReadRedShift              |
      | ida/javaSparkPayloads/MLP-10512_redshift/ExpectedLineageTargets/expectedJavaSparkLineageRedshift.json | Constant.REST_DIR/response/java/javaSpark/javaSparkRedshift/Lineage/JavaSparkLineageRedshiftSourceTarget.json | doReadRedshiftJDBC          |
      | ida/javaSparkPayloads/MLP-10512_redshift/ExpectedLineageTargets/expectedJavaSparkLineageRedshift.json | Constant.REST_DIR/response/java/javaSpark/javaSparkRedshift/Lineage/JavaSparkLineageRedshiftSourceTarget.json | doReadRedshiftMultipleWrite |
      | ida/javaSparkPayloads/MLP-10512_redshift/ExpectedLineageTargets/expectedJavaSparkLineageRedshift.json | Constant.REST_DIR/response/java/javaSpark/javaSparkRedshift/Lineage/JavaSparkLineageRedshiftSourceTarget.json | doReadRedshiftOverwrite     |

    ##########################################################################################################################################################################
  #---------------------- DELETING THE AMAZON CLUSTER FROM POSTGRES DB --------------------------#

  Scenario Outline: sc#11 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                             | type    | targetFile                                           | jsonpath                     |
      | APPDBPOSTGRES | Default | collector/GitCollector/GitCollector/%DYN                         |         | response/java/JavaSparkLineage_Redshift/itemIds.json | $..has_Analysis.id           |
      | APPDBPOSTGRES | Default | Java_RedshiftDataSource                                          | Tag     | response/java/JavaSparkLineage_Redshift/itemIds.json | $..Tag.id                    |
      | APPDBPOSTGRES | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster | response/java/JavaSparkLineage_Redshift/itemIds.json | $..Cluster.id                |
      | APPDBPOSTGRES | Default | GitCollector/redshift                                            | Project | response/java/JavaSparkLineage_Redshift/itemIds.json | $..Project.id                |
      | APPDBPOSTGRES | Default | cataloger/AmazonRedshiftCataloger/AmazonRedshiftCataloger/%DYN   |         | response/java/JavaSparkLineage_Redshift/itemIds.json | $..AmazonRedshiftAnalysis.id |
      | APPDBPOSTGRES | Default | lineage/JavaSparkLineage/JavaSparkLineage/%DYN                   |         | response/java/JavaSparkLineage_Redshift/itemIds.json | $..JavaSparkAnalysis.id      |
      | APPDBPOSTGRES | Default | parser/JavaParser/JavaParser/%DYN                                |         | response/java/JavaSparkLineage_Redshift/itemIds.json | $..JavaParserAnalysis.id     |


  Scenario Outline: sc#12 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                          | responseCode | inputJson                    | inputFile                                            |
      | items/Default/Default.has_Analysis:::dynamic | 204          | $..has_Analysis.id           | response/java/JavaSparkLineage_Redshift/itemIds.json |
      | items/Default/Default.Tag:::dynamic          | 204          | $..Tag.id                    | response/java/JavaSparkLineage_Redshift/itemIds.json |
      | items/Default/Default.Cluster:::dynamic      | 204          | $..Cluster.id                | response/java/JavaSparkLineage_Redshift/itemIds.json |
      | items/Default/Default.Project:::dynamic      | 204          | $..Project.id                | response/java/JavaSparkLineage_Redshift/itemIds.json |
      | items/Default/Default.Analysis:::dynamic     | 204          | $..JavaSparkAnalysis.id      | response/java/JavaSparkLineage_Redshift/itemIds.json |
      | items/Default/Default.Analysis:::dynamic     | 204          | $..AmazonRedshiftAnalysis.id | response/java/JavaSparkLineage_Redshift/itemIds.json |
      | items/Default/Default.Analysis:::dynamic     | 204          | $..JavaParserAnalysis.id     | response/java/JavaSparkLineage_Redshift/itemIds.json |


###############################Deleting Configurations ###################################

  @MLP-10512 @sanity @positive @regression
  Scenario Outline: SC#4-Delete Configurations the following Plugins for Git and Amazon Redshift
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                         | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/Git_Credentials        |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/GitCollectorDataSource   |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/GitCollector             |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/Redshift_Credentials   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/AmazonRedshiftDataSource |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/AmazonRedshiftCataloger  |      | 204           |                  |          |






