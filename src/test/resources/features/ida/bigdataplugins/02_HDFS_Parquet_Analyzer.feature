@MLP-26096
Feature:MLP-5942 MLP-26096: DB Reboot changes for Parquet Analyzer

  Scenario:Pre-Condition:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/%      | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/ParquetAnalyzer/% | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/CsvAnalyzer/%     | Analysis |       |       |
      | MultipleIDDelete | Default | monitor/HdfsMonitor/%          | Analysis |       |       |
      | SingleItemDelete | Default | Cluster Demo                   | Cluster  |       |       |
      | SingleItemDelete | Default | Sandbox                        | Cluster  |       |       |



#####################################################################################################################################################################
############## Creating a directory in Ambari Files View and Uploading a parquet file into the directory
##############################################################################################################################################################

  @MLP-26096 @positve @hdfs @regression @sanity
  Scenario Outline:Creating a directory in Ambari Files View and Uploading a file into the directory
    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                                                                                                                                                      | body                                                                                     | response code | response message |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | ParquetAnalyzerTest/ParquetSub1/ParquetSub2/cityFile1.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                       | ida/parquetPayloads/TestData/cityFile1.csv                                               | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | ParquetAnalyzerTest/ParquetSub1/ParquetSub2/userDiffDataTypesParquet.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true    | ida/parquetPayloads/TestData/userDiffDataTypesParquet.parquet                            | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | ParquetAnalyzerTest/ParquetSub1/ParquetSub2/region.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                      | ida/parquetPayloads/TestData/region.parquet                                              | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | ParquetAnalyzerTest/ParquetSub1/ParquetSub2/userdata1.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                   | ida/parquetPayloads/TestData/userdata1.parquet                                           | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | ParquetAnalyzerTest/ParquetSub1/ParquetSub2/avroDiffDataTypes.avro?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true              | ida/parquetPayloads/TestData/avroDiffDataTypes.avro                                      | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | ParquetPatternMatch/tagdetails_allempty_parquet.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                         | ida/parquetPayloads/TestData/tagdetails_allempty_parquet.parquet                         | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | ParquetPatternMatch/tagdetails_allmatch_parquet.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                         | ida/parquetPayloads/TestData/tagdetails_allmatch_parquet.parquet                         | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | ParquetPatternMatch/tagdetails_ratioequalto05emptyfalse_parquet.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true         | ida/parquetPayloads/TestData/tagdetails_ratioequalto05emptyfalse_parquet.parquet         | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | ParquetPatternMatch/tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/parquetPayloads/TestData/tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | ParquetPatternMatch/tagdetails_ratiogreaterthan05matchfulltrue_parquet.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true  | ida/parquetPayloads/TestData/tagdetails_ratiogreaterthan05matchfulltrue_parquet.parquet  | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | ParquetPatternMatch/tagdetails_ratiolesserthan05matchfulltrue_parquet.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true   | ida/parquetPayloads/TestData/tagdetails_ratiolesserthan05matchfulltrue_parquet.parquet   | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | ParquetPatternMatch/tagdetails_ratiolessthan05emptyfalse_parquet.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true        | ida/parquetPayloads/TestData/tagdetails_ratiolessthan05emptyfalse_parquet.parquet        | 201           |                  |



#####################################################################################################################################################################
############## Scenario 1: Run HDFSCataloger Plugin with automatic analysis as false and trigger Parquet Analyzer manually
##############################################################################################################################################################

  Scenario:Update the Host name respect to the docker
    And user update json file "ida/parquetPayloads/DataSource/hdfsdbValidDataSourceConfig.json" file for following values using property loader
      | jsonPath                                              | jsonValues      |
      | $.configurations[0].clusterManager.clusterManagerHost | clusterHostName |

  @positve @regression @sanity @MLP-26096 @IDA-1.1.0
  Scenario Outline: Set the Credentials, Datasource, Bussiness Application and Cataloger for Hdfs Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                        | body                                                                | response code | response message     | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/hdfsValidCredential   | ida/parquetPayloads/Credentials/hdfsdbValidCredentials.json         | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/hdfsInValidCredential | ida/parquetPayloads/Credentials/hdfsdbInValidCredentials.json       | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/hdfsEmptyCredential   | ida/parquetPayloads/Credentials/hdfsdbEmptyCredentials.json         | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/hdfsValidCredential   |                                                                     | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/hdfsInValidCredential |                                                                     | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/hdfsEmptyCredential   |                                                                     | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root                         | ida\hdfsPayloads\Bussiness_Application\BussinessApplication.json    | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/HdfsDataSource          | ida/parquetPayloads/DataSource/hdfsdbValidDataSourceConfig.json     | 204           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/HdfsDataSource          |                                                                     | 200           | HDFSDataSource_valid |          |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root                         | ida\parquetPayloads\Bussiness_Application\BussinessApplication.json | 200           |                      |          |


  Scenario Outline:MLP-26096:#Run the Plugin configurations for HdfsCataloger and ParquetAnalyzer with automatic analysis false.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | body                                                                          | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HdfsCataloger                                                        | ida/parquetPayloads/PluginConfiguration/HdfsConfigAutomaticAnalysisFalse.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HdfsCataloger                                                        |                                                                               | 200           | HdfsCataloger    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetAnalyzer                                                      | ida/parquetPayloads/PluginConfiguration/ParquetAnalyzerConfiguration.json     | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetAnalyzer                                                      |                                                                               | 200           | ParquetAnalyzer  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger        |                                                                               | 200           | IDLE             | $.[?(@.configurationName=='HdfsCataloger')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger         |                                                                               | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger        |                                                                               | 200           | IDLE             | $.[?(@.configurationName=='HdfsCataloger')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/ParquetAnalyzer |                                                                               | 200           | IDLE             | $.[?(@.configurationName=='ParquetAnalyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/ParquetAnalyzer  |                                                                               | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/ParquetAnalyzer |                                                                               | 200           | IDLE             | $.[?(@.configurationName=='ParquetAnalyzer')].status |

   ########################################################Data Sample validation############################################################################
#7123277#
  @MLP-24319 @parquets3analyzer
  Scenario Outline:SC9:user get the Dynamic ID's (Database ID) for the Directory "CSV2" and File "cityFile1.csv,DiffdatatypesWOH.csv,product_sample.parquet and userDiffDataTypes.avro"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive     | catalog | type      | name | asg_scopeid                    | targetFile                                            | jsonpath                     |
      | APPDBPOSTGRES | AsgScope_ID | Default | Directory | all  | parquetExampleEmployee.parquet | payloads/ida/s3ParquetAnalyzerPayloads/API/items.json | $.Directories.Filename.File1 |

  @MLP-24319 @parquets3analyzer
  Scenario Outline: SC9:user hits the FileID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                             | responseCode | inputJson                    | inputFile                                   | outPutFile                                         | outPutJson |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Directories.Filename.File1 | payloads/ida/parquetPayloads/API/items.json | payloads\ida\parquetPayloads\API\Actual\File1.json |            |

#7152591
  @MLP-24319 @parquets3analyzer
  Scenario: SC#9 MLP_24048_Verify the DataSamples values are as expected
    Then file content in "ida\parquetPayloads\API\Actual\File1.json" should be same as the content in "ida\parquetPayloads\API\Expected\File1.json"



  #7157938
  @webtest @MLP-26096
  Scenario:SC1#Verify the data sampling works fine after ParquetAnalyzer is manullay triggered after HdfsCataloger
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ParquetTag1" and clicks on search
    And user performs "facet selection" in "ParquetTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "userDiffDataTypesParquet.parquet" item from search results
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | Username      | Age | Phone  | InCity | longType | floatType | doubleType  | byteType    |
      | Sehwag        | 38  | 123445 | true   | 4353     | 6447474.0 | 5.3636363E7 | UNSUPPORTED |
      | TestUserName1 | 48  | 323445 | false  | 4353     | 6447474.0 | 5.3636363E7 | UNSUPPORTED |


   #7157938
  @positve @regression @sanity @webtest
  Scenario:SC2#Verify data profiling appears for numeric fields in Parquet files.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "ParquetTag1" and clicks on search
    And user performs "facet selection" in "ParquetTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "userDiffDataTypesParquet.parquet" item from search results
    Then user performs click and verify in new window
      | Table  | value | Action               | RetainPrevwindow | indexSwitch |
      | Fields | age   | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | integer       | Description |
      | Average                       | 43            | Statistics  |
      | Maximum value                 | 48            | Statistics  |
      | Minimum value                 | 38            | Statistics  |
      | Median                        | 43            | Statistics  |
      | Number of non null values     | 2             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Standard deviation            | 7.07          | Statistics  |
      | Variance                      | 50            | Statistics  |
      | sum                           | 86            | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value    | Action               | RetainPrevwindow | indexSwitch |
      | Fields | longType | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | long          | Description |
      | Average                       | 4353          | Statistics  |
      | Maximum value                 | 4353          | Statistics  |
      | Minimum value                 | 4353          | Statistics  |
      | Median                        | 4353          | Statistics  |
      | Number of non null values     | 2             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of unique values       | 1             | Statistics  |
      | Percentage of unique values   | 50            | Statistics  |
      | sum                           | 8706          | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value     | Action               | RetainPrevwindow | indexSwitch |
      | Fields | floatType | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | float         | Description |
      | Average                       | 6447474       | Statistics  |
      | Maximum value                 | 6447474.0     | Statistics  |
      | Minimum value                 | 6447474.0     | Statistics  |
      | Median                        | 6447474       | Statistics  |
      | Number of non null values     | 2             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of unique values       | 1             | Statistics  |
      | Percentage of unique values   | 50            | Statistics  |
      | sum                           | 1.2894948E7   | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value      | Action               | RetainPrevwindow | indexSwitch |
      | Fields | doubleType | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | double        | Description |
      | Average                       | 53636363      | Statistics  |
      | Maximum value                 | 5.3636363E7   | Statistics  |
      | Minimum value                 | 5.3636363E7   | Statistics  |
      | Median                        | 53636363      | Statistics  |
      | Number of non null values     | 2             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of unique values       | 1             | Statistics  |
      | Percentage of unique values   | 50            | Statistics  |
      | sum                           | 1.07272726E8  | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page


  #7157938
  @positve @regression @sanity @webtest
  Scenario:SC3#Verify data profiling appears for string,boolean,binary fields in Parquet files.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "ParquetTag1" and clicks on search
    And user performs "facet selection" in "ParquetTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "userDiffDataTypesParquet.parquet" item from search results
    Then user performs click and verify in new window
      | Table  | value    | Action               | RetainPrevwindow | indexSwitch |
      | Fields | username | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | string        | Description |
      | avgLength                     | 9.5           | Statistics  |
      | avgWordCount                  | 1             | Statistics  |
      | Maximum length                | 13            | Statistics  |
      | Maximum value                 | TestUserName1 | Statistics  |
      | maxWordCount                  | 1             | Statistics  |
      | Minimum length                | 6             | Statistics  |
      | Minimum value                 | Sehwag        | Statistics  |
      | minWordCount                  | 1             | Statistics  |
      | mostFrequentWord              | Sehwag        | Statistics  |
      | Number of non null values     | 2             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not presence" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value  | Action               | RetainPrevwindow | indexSwitch |
      | Fields | InCity | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
      | Maximum value      | Statistics |
      | Minimum value      | Statistics |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | boolean       | Description |
      | Number of non null values     | 2             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not presence" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value    | Action               | RetainPrevwindow | indexSwitch |
      | Fields | byteType | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | binary        | Description |
      | Number of non null values     | 2             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not presence" on "Data Distribution" in Item view page

    #7157942
  @webtest
  Scenario:SC4#MLP_26960_Verify ParquetAnalyzer does not analyze non csv files(lastAnalyzedAt attribute will not be there)
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HdfsTag1" and clicks on search
    And user performs "facet selection" in "HdfsTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "userDiffDataTypesParquet.parquet" item from search results
    And user "verify metadata properties" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last Analyzed At  | Lifecycle  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table | value                  | Action               | RetainPrevwindow | indexSwitch |
      | Files | avroDiffDataTypes.avro | click and switch tab | No               |             |
    And user "verify metadata properties" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last Analyzed At  | Lifecycle  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table | value         | Action               | RetainPrevwindow | indexSwitch |
      | Files | cityFile1.csv | click and switch tab | No               |             |
    And user "verify metadata properties" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last Analyzed At  | Lifecycle  |



    #7157936
  @sanity @positive @webtest
  Scenario: SC5# Verify the technology tags got assigned to all ParquetAnalyzed items.
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ParquetTag1" and clicks on search
    And user performs "facet selection" in "ParquetTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "Parquet,ParquetTag1,ParquetTag1,Parquet_BA" should get displayed for the column "dataanalyzer/HiveDataAnalyzer"
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName | ServiceName | directoryName | TableName/Filename               | Column | Tags                                                         | Query          | Action      |
      |             |             | ParquetSub2   | userDiffDataTypesParquet.parquet |        | Hadoop Files,HdfsTag1,HDFS_BA,Parquet,ParquetTag1,Parquet_BA | FileQuery      | TagAssigned |
      |             |             |               | userDiffDataTypesParquet.parquet | age    | Parquet,ParquetTag1,Parquet_BA                               | FileFieldQuery | TagAssigned |
      |             |             | ParquetSub2   |                                  |        | Hadoop Files,HdfsTag1,HDFS_BA                                | DirectoryQuery | TagAssigned |
      | Sandbox     | HDFS        |               |                                  |        | Hadoop Files,HdfsTag1,HDFS_BA                                | ServiceQuery   | TagAssigned |
      | Sandbox     |             |               |                                  |        | Hadoop Files,HdfsTag1,HDFS_BA                                | ClusterQuery   | TagAssigned |


    #7157936
  @sanity @positive @MLP-26096 @webtest @IDA-1.1.0
  Scenario:SC6#Verify log entries/log enhancements(processed Items widget and Processed count) check for ParquetAnalyzer plugin logs.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ParquetTag1" and clicks on search
    And user performs "facet selection" in "ParquetTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "dataanalyzer/ParquetAnalyzer/ParquetAnalyzer%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 2             | Description |
      | Number of errors          | 0             | Description |
    And user "verifies tab section values" has the following values in "Processed Items" Tab in Item View page
      | Sandbox |
      | HDFS    |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "dataanalyzer/ParquetAnalyzer/ParquetAnalyzer%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | logCode       | pluginName       | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | ANALYSIS-0019 |                  |                |
      | INFO | Plugin Name:ParquetAnalyzer, Plugin Type:dataanalyzer, Plugin Version:1.1.0.SNAPSHOT, Node Name:Cluster Demo, Host Name:sandbox.hortonworks.com, Plugin Configuration name:ParquetAnalyzer                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | ANALYSIS-0071 | ParquetAnalyzer  | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin ParquetAnalyzer Configuration: ---  2020-10-01 10:32:00.857 INFO  - ANALYSIS-0073: Plugin ParquetAnalyzer Configuration: name: "ParquetAnalyzer"  2020-10-01 10:32:00.857 INFO  - ANALYSIS-0073: Plugin ParquetAnalyzer Configuration: pluginVersion: "LATEST"  2020-10-01 10:32:00.857 INFO  - ANALYSIS-0073: Plugin ParquetAnalyzer Configuration: label:  2020-10-01 10:32:00.857 INFO  - ANALYSIS-0073: Plugin ParquetAnalyzer Configuration: : ""  2020-10-01 10:32:00.857 INFO  - ANALYSIS-0073: Plugin ParquetAnalyzer Configuration: catalogName: "Default"  2020-10-01 10:32:00.857 INFO  - ANALYSIS-0073: Plugin ParquetAnalyzer Configuration: eventClass: null  2020-10-01 10:32:00.858 INFO  - ANALYSIS-0073: Plugin ParquetAnalyzer Configuration: eventCondition: null  2020-10-01 10:32:00.858 INFO  - ANALYSIS-0073: Plugin ParquetAnalyzer Configuration: nodeCondition: "name==\"Cluster Demo\""  2020-10-01 10:32:00.858 INFO  - ANALYSIS-0073: Plugin ParquetAnalyzer Configuration: maxWorkSize: 100  2020-10-01 10:32:00.858 INFO  - ANALYSIS-0073: Plugin ParquetAnalyzer Configuration: tags:  2020-10-01 10:32:00.858 INFO  - ANALYSIS-0073: Plugin ParquetAnalyzer Configuration: - "ParquetTag1"  2020-10-01 10:32:00.858 INFO  - ANALYSIS-0073: Plugin ParquetAnalyzer Configuration: pluginType: "dataanalyzer"  2020-10-01 10:32:00.858 INFO  - ANALYSIS-0073: Plugin ParquetAnalyzer Configuration: dataSource: null  2020-10-01 10:32:00.858 INFO  - ANALYSIS-0073: Plugin ParquetAnalyzer Configuration: credential: null  2020-10-01 10:32:00.858 INFO  - ANALYSIS-0073: Plugin ParquetAnalyzer Configuration: businessApplicationName: "Parquet_BA"  2020-10-01 10:32:00.858 INFO  - ANALYSIS-0073: Plugin ParquetAnalyzer Configuration: dryRun: false  2020-10-01 10:32:00.858 INFO  - ANALYSIS-0073: Plugin ParquetAnalyzer Configuration: schedule: null  2020-10-01 10:32:00.858 INFO  - ANALYSIS-0073: Plugin ParquetAnalyzer Configuration: filter: null  2020-10-01 10:32:00.859 INFO  - ANALYSIS-0073: Plugin ParquetAnalyzer Configuration: histogramBuckets: 100  2020-10-01 10:32:00.859 INFO  - ANALYSIS-0073: Plugin ParquetAnalyzer Configuration: sparkOptions:  2020-10-01 10:32:00.859 INFO  - ANALYSIS-0073: Plugin ParquetAnalyzer Configuration: - key: "deploy.mode"  2020-10-01 10:32:00.859 INFO  - ANALYSIS-0073: Plugin ParquetAnalyzer Configuration: value: "cluster"  2020-10-01 10:32:00.859 INFO  - ANALYSIS-0073: Plugin ParquetAnalyzer Configuration: - key: "spark.network.timeout"  2020-10-01 10:32:00.859 INFO  - ANALYSIS-0073: Plugin ParquetAnalyzer Configuration: value: "600s"  2020-10-01 10:32:00.859 INFO  - ANALYSIS-0073: Plugin ParquetAnalyzer Configuration: pluginName: "ParquetAnalyzer"  2020-10-01 10:32:00.859 INFO  - ANALYSIS-0073: Plugin ParquetAnalyzer Configuration: runAfter: []  2020-10-01 10:32:00.859 INFO  - ANALYSIS-0073: Plugin ParquetAnalyzer Configuration: dataSample:  2020-10-01 10:32:00.859 INFO  - ANALYSIS-0073: Plugin ParquetAnalyzer Configuration: sampleSize: 25  2020-10-01 10:32:00.859 INFO  - ANALYSIS-0073: Plugin ParquetAnalyzer Configuration: type: "Dataanalyzer"  2020-10-01 10:32:00.859 INFO  - ANALYSIS-0073: Plugin ParquetAnalyzer Configuration: topValues: 10 | ANALYSIS-0073 | ParquetAnalyzer  |                |
      | INFO | Plugin ParquetAnalyzer Start Time:2020-08-10 19:40:34.556, End Time:2020-08-10 19:44:55.548, Processed Count:2, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | ANALYSIS-0072 | HiveDataAnalyzer |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:35.865)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | ANALYSIS-0020 |                  |                |

  @sanity @positive @regression
  Scenario:Delete Cluster , Cataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                          | type     | query | param |
      | SingleItemDelete | Default | Sandbox                                       | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/HdfsCataloger/HdfsCataloger%        | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/ParquetAnalyzer/ParquetAnalyzer% | Analysis |       |       |


  Scenario Outline:MLP-26096:#Run the Plugin configurations for HdfsCataloger and ParquetAnalyzer with dryRun as true.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | body                                                                                | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HdfsCataloger                                                        | ida/parquetPayloads/PluginConfiguration/HdfsConfigDryRunTrue.json                   | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HdfsCataloger                                                        |                                                                                     | 200           | HdfsCataloger    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger        |                                                                                     | 200           | IDLE             | $.[?(@.configurationName=='HdfsCataloger')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger         |                                                                                     | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger        |                                                                                     | 200           | IDLE             | $.[?(@.configurationName=='HdfsCataloger')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetAnalyzer                                                      | ida/parquetPayloads/PluginConfiguration/ParquetAnalyzerConfigurationDryRunTrue.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetAnalyzer                                                      |                                                                                     | 200           | ParquetAnalyzer  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/ParquetAnalyzer |                                                                                     | 200           | IDLE             | $.[?(@.configurationName=='ParquetAnalyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/ParquetAnalyzer  |                                                                                     | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/ParquetAnalyzer |                                                                                     | 200           | IDLE             | $.[?(@.configurationName=='ParquetAnalyzer')].status |


    #7157936
  @MLP-24873 @webtest @regression @sanity
  Scenario: SC7#Verify ParquetAnalyzer doesn't collects Cluster,Service,Database,Table,Column when run with dryrun as true
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ParquetTag1" and clicks on search
    Then user verify "verify non presence" with following values under "Type" section in item search results page
      | Service   |
      | Cluster   |
      | Directory |
      | File      |
      | Field     |
    And user enters the search text "ParquetTag1" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "dataanalyzer/ParquetAnalyzer/ParquetAnalyzer%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 0             |
      | Number of errors          | 0             |
    And user "widget not present" on "Processed Items" in Item view page
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "dataanalyzer/ParquetAnalyzer/ParquetAnalyzer%" should display below info/error/warning
      | type | logValue                                                                                                                             | logCode       | pluginName      | removableText |
      | INFO | Plugin ParquetAnalyzer running on dry run mode                                                                                       | ANALYSIS-0069 | ParquetAnalyzer |               |
      | INFO | Plugin ParquetAnalyzer processed 0 items on dry run mode and not written to the repository                                           | ANALYSIS-0070 | ParquetAnalyzer |               |
      | INFO | Plugin ParquetAnalyzer Start Time:2020-08-04 19:06:26.536, End Time:2020-08-04 19:06:26.804, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | ParquetAnalyzer |               |


     #7157943
  @MLP-26096 @webtest @positive @regression @sanity
  Scenario: SC8#Verify proper error message is shown if mandatory fields are not filled in ParquetAnalyzer configuration page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem            |
      | click      | Settings Icon         |
      | click      | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem   |
      | Open Deployment | Cluster Demo |
    And user "click" on "Add Configuration" button under "Cluster Demo" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute       |
      | Type      | Dataanalyzer    |
      | Plugin    | ParquetAnalyzer |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Name                  | ParquetAnalyzer        |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName | errorMessage                                        |
      | Name      | Name already exists. Please enter a different name. |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Name                  | /////                  |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName | errorMessage                                                               |
      | Name      | Invalid name. Leading/trailing blanks and special characters are forbidden |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"


     #7163867
  @webtest @jdbc @MLP-26096
  Scenario:SC9#Verify proper error message is thrown in UI if Sample Data count/Top Values/Histogram Buckets values are not provided within valid range in ParquetAnalyzer
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem            |
      | click      | Settings Icon         |
      | click      | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem   |
      | Open Deployment | Cluster Demo |
    And user "click" on "Add Configuration" button under "Cluster Demo" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute       |
      | Type      | Dataanalyzer    |
      | Plugin    | ParquetAnalyzer |
    #And user "Click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Sample size           |                        |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName   | errorMessage                          |
      | Sample size | Sample size field should not be empty |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Sample size           | 1001                   |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName   | errorMessage                                         |
      | Sample size | Value of Sample size should not be greater than 1000 |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Top values            |                        |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName  | errorMessage                         |
      | Top values | Top values field should not be empty |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Top values            | 4                      |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName  | errorMessage                                    |
      | Top values | Value of Top values should not be lesser than 5 |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Top values            | 31                     |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName  | errorMessage                                      |
      | Top values | Value of Top values should not be greater than 30 |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Histogram buckets     |                        |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName         | errorMessage                                |
      | Histogram buckets | Histogram buckets field should not be empty |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Histogram buckets     | 4                      |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName         | errorMessage                                           |
      | Histogram buckets | Value of Histogram buckets should not be lesser than 5 |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Histogram buckets     | 21                     |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName         | errorMessage                                             |
      | Histogram buckets | Value of Histogram buckets should not be greater than 20 |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"


#7157937
  @MLP-26096 @webtest @positive @regression @sanity
  Scenario: SC10-Verify captions in ParquetAnalyzer
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem            |
      | mouse hover | Settings Icon         |
      | click       | Settings Icon         |
      | click       | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem   |
      | Open Deployment | Cluster Demo |
    And user "click" on "Add Configuration" button under "Cluster Demo" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute       |
      | Type      | Dataanalyzer    |
      | Plugin    | ParquetAnalyzer |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Type*                |
      | Name*                |
      | Plugin*              |
      | Label                |
      | Business Application |
      | Sample size*         |
      | Histogram buckets*   |
      | Top values*          |
    And user "Click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Plugin version    |
      | Event condition   |
      | Dry Run           |
      | Event class       |
      | Maximum work size |
      | Node condition    |



     #7157937
  @positve @regression @sanity  @MLP-26096 @IDA-1.1.0
  Scenario Outline: Get the Hive Analyzer Configuration response
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                               | body                                        | response code | response message | filePath                                      | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | /schemes/analyzers/configurations | response/parquet/body/ToolTip_Analyzer.json | 200           |                  | response/parquet/actual/ToolTip_Analyzer.json |          |


      #7157937
  @positve @regression @sanity  @MLP-26096 @IDA-1.1.0
  Scenario Outline:SC11# Validate ToolTip for all the fields in parquetAnalyzer plugin.
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                         | actualValues                                  | valueType     | expectedJsonPath                               | actualJsonPath                                                  |
      | response/parquet/expected/ToolTip.json | response/parquet/actual/ToolTip_Analyzer.json | stringCompare | $.Commonfields..[?(@.label=='Type')].tooltip   | $..[?(@.label=='Type')].tooltip                                 |
      | response/parquet/expected/ToolTip.json | response/parquet/actual/ToolTip_Analyzer.json | stringCompare | $.Commonfields.pluginName.tooltip              | $.properties[0].value.prototype.properties[1].tooltip           |
      | response/parquet/expected/ToolTip.json | response/parquet/actual/ToolTip_Analyzer.json | stringCompare | $.Commonfields.PluginConfigName.tooltip        | $.properties[0].value.prototype.properties[2].tooltip           |
      | response/parquet/expected/ToolTip.json | response/parquet/actual/ToolTip_Analyzer.json | stringCompare | $.Commonfields.pluginVersion.tooltip           | $.properties[0].value.prototype.properties[3].tooltip           |
      | response/parquet/expected/ToolTip.json | response/parquet/actual/ToolTip_Analyzer.json | stringCompare | $.Commonfields.label.tooltip                   | $.properties[0].value.prototype.properties[4].tooltip           |
      | response/parquet/expected/ToolTip.json | response/parquet/actual/ToolTip_Analyzer.json | stringCompare | $.Commonfields.businessApplicationName.tooltip | $.properties[0].value.prototype.properties[15].tooltip          |
      | response/parquet/expected/ToolTip.json | response/parquet/actual/ToolTip_Analyzer.json | stringCompare | $.Commonfields.Samplesize.tooltip              | $.properties[0].value.prototype.properties[16].value[0].tooltip |
      | response/parquet/expected/ToolTip.json | response/parquet/actual/ToolTip_Analyzer.json | stringCompare | $.Commonfields.Histogrambuckets.tooltip        | $.properties[0].value.prototype.properties[17].tooltip          |
      | response/parquet/expected/ToolTip.json | response/parquet/actual/ToolTip_Analyzer.json | stringCompare | $.Commonfields.Topvalues.tooltip               | $.properties[0].value.prototype.properties[18].tooltip          |
      | response/parquet/expected/ToolTip.json | response/parquet/actual/ToolTip_Analyzer.json | stringCompare | $.Commonfields.eventCondition.tooltip          | $.properties[0].value.prototype.properties[5].tooltip           |
      | response/parquet/expected/ToolTip.json | response/parquet/actual/ToolTip_Analyzer.json | stringCompare | $.Commonfields.dryRun.tooltip                  | $.properties[0].value.prototype.properties[6].tooltip           |
      | response/parquet/expected/ToolTip.json | response/parquet/actual/ToolTip_Analyzer.json | stringCompare | $.Commonfields.eventClass.tooltip              | $.properties[0].value.prototype.properties[7].tooltip           |
      | response/parquet/expected/ToolTip.json | response/parquet/actual/ToolTip_Analyzer.json | stringCompare | $.Commonfields.maxWorkSize.tooltip             | $.properties[0].value.prototype.properties[8].tooltip           |
      | response/parquet/expected/ToolTip.json | response/parquet/actual/ToolTip_Analyzer.json | stringCompare | $.Commonfields.nodeCondition.tooltip           | $.properties[0].value.prototype.properties[10].tooltip          |
      | response/parquet/expected/ToolTip.json | response/parquet/actual/ToolTip_Analyzer.json | stringCompare | $.Commonfields.autoStart.tooltip               | $.properties[0].value.prototype.properties[11].tooltip          |
      | response/parquet/expected/ToolTip.json | response/parquet/actual/ToolTip_Analyzer.json | stringCompare | $.Commonfields.tags.tooltip                    | $.properties[0].value.prototype.properties[12].tooltip          |


  @sanity @positive @regression
  Scenario:Delete Cluster , Cataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                          | type     | query | param |
      | SingleItemDelete | Default | Sandbox                                       | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/HdfsCataloger/HdfsCataloger%        | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/ParquetAnalyzer/ParquetAnalyzer% | Analysis |       |       |


  Scenario Outline:MLP-26096:#Run the Plugin configurations for HdfsCataloger and ParquetAnalyzer with automatic analysis true.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | body                                                                                | response code | response message                   | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HdfsDataSource                                                       | ida/parquetPayloads/DataSource/hdfsdbValidDataSourceConfig_resolveclusterFALSE.json | 204           |                                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HdfsDataSource                                                       |                                                                                     | 200           | HDFSDataSource_resolveclusterfalse |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HdfsCataloger                                                        | ida/parquetPayloads/PluginConfiguration/HdfsConfigAutomaticAnalysisTrue.json        | 204           |                                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HdfsCataloger                                                        |                                                                                     | 200           | HdfsCataloger                      |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger        |                                                                                     | 200           | IDLE                               | $.[?(@.configurationName=='HdfsCataloger')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger         |                                                                                     | 200           |                                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger        |                                                                                     | 200           | IDLE                               | $.[?(@.configurationName=='HdfsCataloger')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetAnalyzer                                                      | ida/parquetPayloads/PluginConfiguration/ParquetAnalyzerConfiguration.json           | 204           |                                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetAnalyzer                                                      |                                                                                     | 200           | ParquetAnalyzer                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/ParquetAnalyzer |                                                                                     | 200           | IDLE                               | $.[?(@.configurationName=='ParquetAnalyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/ParquetAnalyzer  |                                                                                     | 200           |                                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/ParquetAnalyzer |                                                                                     | 200           | IDLE                               | $.[?(@.configurationName=='ParquetAnalyzer')].status |

  #7163595
  @webtest @MLP-26096
  Scenario:SC12#Verify the data sampling works fine after ParquetAnalyzer is automatically triggered after HdfsCataloger
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ParquetTag1" and clicks on search
    And user performs "facet selection" in "ParquetTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "userDiffDataTypesParquet.parquet" item from search results
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | Username      | Age | Phone  | InCity | longType | floatType | doubleType  | byteType    |
      | Sehwag        | 38  | 123445 | true   | 4353     | 6447474.0 | 5.3636363E7 | UNSUPPORTED |
      | TestUserName1 | 48  | 323445 | false  | 4353     | 6447474.0 | 5.3636363E7 | UNSUPPORTED |


  #7157938
  @positve @regression @sanity @webtest
  Scenario:SC13#Verify data profiling appears for numeric fields in Parquet files.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "ParquetTag1" and clicks on search
    And user performs "facet selection" in "ParquetTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "userDiffDataTypesParquet.parquet" item from search results
    Then user performs click and verify in new window
      | Table  | value | Action               | RetainPrevwindow | indexSwitch |
      | Fields | age   | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | integer       | Description |
      | Average                       | 43            | Statistics  |
      | Maximum value                 | 48            | Statistics  |
      | Minimum value                 | 38            | Statistics  |
      | Median                        | 43            | Statistics  |
      | Number of non null values     | 2             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Standard deviation            | 7.07          | Statistics  |
      | Variance                      | 50            | Statistics  |
      | sum                           | 86            | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value    | Action               | RetainPrevwindow | indexSwitch |
      | Fields | longType | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | long          | Description |
      | Average                       | 4353          | Statistics  |
      | Maximum value                 | 4353          | Statistics  |
      | Minimum value                 | 4353          | Statistics  |
      | Median                        | 4353          | Statistics  |
      | Number of non null values     | 2             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of unique values       | 1             | Statistics  |
      | Percentage of unique values   | 50            | Statistics  |
      | sum                           | 8706          | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value     | Action               | RetainPrevwindow | indexSwitch |
      | Fields | floatType | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | float         | Description |
      | Average                       | 6447474       | Statistics  |
      | Maximum value                 | 6447474.0     | Statistics  |
      | Minimum value                 | 6447474.0     | Statistics  |
      | Median                        | 6447474       | Statistics  |
      | Number of non null values     | 2             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of unique values       | 1             | Statistics  |
      | Percentage of unique values   | 50            | Statistics  |
      | sum                           | 1.2894948E7   | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value      | Action               | RetainPrevwindow | indexSwitch |
      | Fields | doubleType | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | double        | Description |
      | Average                       | 53636363      | Statistics  |
      | Maximum value                 | 5.3636363E7   | Statistics  |
      | Minimum value                 | 5.3636363E7   | Statistics  |
      | Median                        | 53636363      | Statistics  |
      | Number of non null values     | 2             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of unique values       | 1             | Statistics  |
      | Percentage of unique values   | 50            | Statistics  |
      | sum                           | 1.07272726E8  | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page


    #7163595
  @positve @regression @sanity @webtest
  Scenario:SC14#Verify data profiling appears for string,boolean,binary fields in Parquet files.(after auto triggering is done)
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "ParquetTag1" and clicks on search
    And user performs "facet selection" in "ParquetTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "userDiffDataTypesParquet.parquet" item from search results
    Then user performs click and verify in new window
      | Table  | value    | Action               | RetainPrevwindow | indexSwitch |
      | Fields | username | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | string        | Description |
      | avgLength                     | 9.5           | Statistics  |
      | avgWordCount                  | 1             | Statistics  |
      | Maximum length                | 13            | Statistics  |
      | Maximum value                 | TestUserName1 | Statistics  |
      | maxWordCount                  | 1             | Statistics  |
      | Minimum length                | 6             | Statistics  |
      | Minimum value                 | Sehwag        | Statistics  |
      | minWordCount                  | 1             | Statistics  |
      | mostFrequentWord              | TestUserName1 | Statistics  |
      | Number of non null values     | 2             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not presence" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value  | Action               | RetainPrevwindow | indexSwitch |
      | Fields | InCity | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
      | Maximum value      | Statistics |
      | Minimum value      | Statistics |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | boolean       | Description |
      | Number of non null values     | 2             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not presence" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value    | Action               | RetainPrevwindow | indexSwitch |
      | Fields | byteType | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | binary        | Description |
      | Number of non null values     | 2             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not presence" on "Data Distribution" in Item view page

  @sanity @positive @regression
  Scenario:Delete Cluster , Cataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                          | type     | query | param |
      | SingleItemDelete | Default | Cluster Demo                                  | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/HdfsCataloger/HdfsCataloger%        | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/ParquetAnalyzer/ParquetAnalyzer% | Analysis |       |       |

  Scenario:Pre-con1_Update the Host name respect to the docker
    And user update json file "ida/parquetPayloads/DataSource/hdfsdbValidDataSourceConfig.json" file for following values using property loader
      | jsonPath                                              | jsonValues      |
      | $.configurations[0].clusterManager.clusterManagerHost | clusterHostName |

  Scenario Outline:MLP-26096:#Run the Plugin configurations for HdfsCataloger and ParquetAnalyzer with non existing directory in cataloger.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | body                                                                        | response code | response message     | jsonPath                                             |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsDataSource                                                       | ida/parquetPayloads/DataSource/hdfsdbValidDataSourceConfig.json             | 204           |                      |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsDataSource                                                       |                                                                             | 200           | HDFSDataSource_valid |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HdfsCataloger                                                        | ida/parquetPayloads/PluginConfiguration/HdfsConfigNonExistingDirectory.json | 204           |                      |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HdfsCataloger                                                        |                                                                             | 200           | HdfsCataloger        |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger        |                                                                             | 200           | IDLE                 | $.[?(@.configurationName=='HdfsCataloger')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger         |                                                                             | 200           |                      |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger        |                                                                             | 200           | IDLE                 | $.[?(@.configurationName=='HdfsCataloger')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetAnalyzer                                                      | ida/parquetPayloads/PluginConfiguration/ParquetAnalyzerConfiguration.json   | 204           |                      |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetAnalyzer                                                      |                                                                             | 200           | ParquetAnalyzer      |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/ParquetAnalyzer |                                                                             | 200           | IDLE                 | $.[?(@.configurationName=='ParquetAnalyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/ParquetAnalyzer  |                                                                             | 200           |                      |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/ParquetAnalyzer |                                                                             | 200           | IDLE                 | $.[?(@.configurationName=='ParquetAnalyzer')].status |

  @MLP-26096 @webtest @regression @sanity
  Scenario: SC15- Verify ParquetAnalyzer does not analyze anything when the catalog does not contain any items.(HdfsCataloger has invalid Directory)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ParquetTag1" and clicks on search
    Then user verify "verify non presence" with following values under "Type" section in item search results page
      | Service   |
      | Cluster   |
      | Directory |
      | File      |
      | Field     |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "dataanalyzer/ParquetAnalyzer/ParquetAnalyzer%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 0             |
      | Number of errors          | 0             |
    And user "widget not present" on "Processed Items" in Item view page
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "dataanalyzer/ParquetAnalyzer/ParquetAnalyzer%" should display below info/error/warning
      | type | logValue                                            | logCode               | pluginName      | removableText |
      | INFO | No more data which have to be analyzed. Proceeding. | BIGDATA-ANALYZER-0008 | ParquetAnalyzer |               |


  @sanity @positive @regression
  Scenario:Delete Cluster , Cataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                          | type     | query | param |
      | SingleItemDelete | Default | cataloger/HdfsCataloger/HdfsCataloger%        | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/ParquetAnalyzer/ParquetAnalyzer% | Analysis |       |       |

  Scenario:Pre-con2_Update the Host name respect to the docker
    And user update json file "ida/parquetPayloads/DataSource/hdfsdbValidDataSourceConfig.json" file for following values using property loader
      | jsonPath                                              | jsonValues      |
      | $.configurations[0].clusterManager.clusterManagerHost | clusterHostName |

  Scenario Outline:MLP-26096:#Run the Plugin configurations for HdfsCataloger and ParquetAnalyzer for Analyzer rerun scenario.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | body                                                                          | response code | response message     | jsonPath                                             |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsDataSource                                                       | ida/parquetPayloads/DataSource/hdfsdbValidDataSourceConfig.json               | 204           |                      |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsDataSource                                                       |                                                                               | 200           | HDFSDataSource_valid |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HdfsCataloger                                                        | ida/parquetPayloads/PluginConfiguration/HdfsConfigAutomaticAnalysisFalse.json | 204           |                      |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HdfsCataloger                                                        |                                                                               | 200           | HdfsCataloger        |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger        |                                                                               | 200           | IDLE                 | $.[?(@.configurationName=='HdfsCataloger')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger         |                                                                               | 200           |                      |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger        |                                                                               | 200           | IDLE                 | $.[?(@.configurationName=='HdfsCataloger')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetAnalyzer                                                      | ida/parquetPayloads/PluginConfiguration/ParquetAnalyzerConfiguration.json     | 204           |                      |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetAnalyzer                                                      |                                                                               | 200           | ParquetAnalyzer      |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/ParquetAnalyzer |                                                                               | 200           | IDLE                 | $.[?(@.configurationName=='ParquetAnalyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/ParquetAnalyzer  |                                                                               | 200           |                      |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/ParquetAnalyzer |                                                                               | 200           | IDLE                 | $.[?(@.configurationName=='ParquetAnalyzer')].status |


   #7157947
  @MLP-26096 @webtest @positve @hdfs @regression @sanity
  Scenario:SC16_Verify whether the data analysis is not performed once the ParquetAnalyzer runs after ParquetAnalyzer.(analyzer rerun scenario)
    Given User launch browser and traverse to login page
    And user enter credentials for "system Administrator1" role
    And user enters the search text "ParquetTag1" and clicks on search
    And user performs "facet selection" in "ParquetTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "userDiffDataTypesParquet.parquet" item from search results
    Then user performs click and verify in new window
      | Table  | value | Action               | RetainPrevwindow | indexSwitch |
      | Fields | age   | click and switch tab | No               |             |
    And user "store" the value of item "age" of attribute "Last analyzed at" with temporary text
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                     | body | response code | response message | jsonPath                                             |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/ParquetAnalyzer |      | 200           | IDLE             | $.[?(@.configurationName=='ParquetAnalyzer')].status |
      |                  |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/ParquetAnalyzer  |      | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/ParquetAnalyzer |      | 200           | IDLE             | $.[?(@.configurationName=='ParquetAnalyzer')].status |
    And user enters the search text "ParquetTag1" and clicks on search
    And user performs "facet selection" in "ParquetTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "userDiffDataTypesParquet.parquet" item from search results
    Then user performs click and verify in new window
      | Table  | value | Action               | RetainPrevwindow | indexSwitch |
      | Fields | age   | click and switch tab | No               |             |
    Then user "verify equals" the value of item "age" of attribute "Last analyzed at" with temporary text

  @sanity @positive @regression
  Scenario:Delete Cluster , Cataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                          | type     | query | param |
      | SingleItemDelete | Default | Sandbox                                       | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/HdfsCataloger/HdfsCataloger%        | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/ParquetAnalyzer/ParquetAnalyzer% | Analysis |       |       |

  Scenario Outline:MLP-26096:#Run the Plugin configurations for ParquetAnalyzer alone without HdfsCataloger ran.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | body                                                                      | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetAnalyzer                                                      | ida/parquetPayloads/PluginConfiguration/ParquetAnalyzerConfiguration.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetAnalyzer                                                      |                                                                           | 200           | ParquetAnalyzer  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/ParquetAnalyzer |                                                                           | 200           | IDLE             | $.[?(@.configurationName=='ParquetAnalyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/ParquetAnalyzer  |                                                                           | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/ParquetAnalyzer |                                                                           | 200           | IDLE             | $.[?(@.configurationName=='ParquetAnalyzer')].status |


  #7157940
  @MLP-26096 @webtest @regression @sanity
  Scenario: SC17- Verify ParquetAnalyzer is ran without HdfsCataloger and the analyzer log shows proper message.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ParquetTag1" and clicks on search
    Then user verify "verify non presence" with following values under "Type" section in item search results page
      | Service   |
      | Cluster   |
      | Directory |
      | File      |
      | Field     |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "dataanalyzer/ParquetAnalyzer/ParquetAnalyzer%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 0             |
      | Number of errors          | 0             |
    And user "widget not present" on "Processed Items" in Item view page
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "dataanalyzer/ParquetAnalyzer/ParquetAnalyzer%" should display below info/error/warning
      | type | logValue                                            | logCode               | pluginName      | removableText |
      | INFO | No more data which have to be analyzed. Proceeding. | BIGDATA-ANALYZER-0008 | ParquetAnalyzer |               |

  @sanity @positive @regression
  Scenario:Delete Cluster , Cataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                          | type     | query | param |
      | SingleItemDelete | Default | Sandbox                                       | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/HdfsCataloger/HdfsCataloger%        | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/ParquetAnalyzer/ParquetAnalyzer% | Analysis |       |       |

  Scenario:Pre-con3_Update the Host name respect to the docker
    And user update json file "ida/parquetPayloads/DataSource/hdfsdbValidDataSourceConfig.json" file for following values using property loader
      | jsonPath                                              | jsonValues      |
      | $.configurations[0].clusterManager.clusterManagerHost | clusterHostName |

  Scenario Outline:MLP-26096:#Run the Plugin configurations for HdfsCataloger and ParquetAnalyzer with varying analyzer parameters.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | body                                                                                           | response code | response message     | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HdfsDataSource                                                       | ida/parquetPayloads/DataSource/hdfsdbValidDataSourceConfig.json                                | 204           |                      |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HdfsDataSource                                                       |                                                                                                | 200           | HDFSDataSource_valid |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HdfsCataloger                                                        | ida/parquetPayloads/PluginConfiguration/HdfsConfigAutomaticAnalysisFalse.json                  | 204           |                      |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HdfsCataloger                                                        |                                                                                                | 200           | HdfsCataloger        |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetAnalyzer                                                      | ida/parquetPayloads/PluginConfiguration/ParquetAnalyzerConfigurationVaryParametersAutoRun.json | 204           |                      |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetAnalyzer                                                      |                                                                                                | 200           | ParquetAnalyzer      |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger        |                                                                                                | 200           | IDLE                 | $.[?(@.configurationName=='HdfsCataloger')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger         |                                                                                                | 200           |                      |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger        |                                                                                                | 200           | IDLE                 | $.[?(@.configurationName=='HdfsCataloger')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/ParquetAnalyzer |                                                                                                | 200           | IDLE                 | $.[?(@.configurationName=='ParquetAnalyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/ParquetAnalyzer  |                                                                                                | 200           |                      |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/ParquetAnalyzer |                                                                                                | 200           | IDLE                 | $.[?(@.configurationName=='ParquetAnalyzer')].status |



  #7157939
  @webtest @MLP-26096
  Scenario:SC#18_Verify ParquetAnalyzer does data sampling/data profiling properly for parquet files files when sample size/histogram/top values are varied.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ParquetTag1" and clicks on search
    And user performs "facet selection" in "ParquetTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "userDiffDataTypesParquet.parquet" item from search results
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | Username      | Age | Phone  | InCity | longType | floatType | doubleType  | byteType    |
      | Sehwag        | 38  | 123445 | true   | 4353     | 6447474.0 | 5.3636363E7 | UNSUPPORTED |
      | TestUserName1 | 48  | 323445 | false  | 4353     | 6447474.0 | 5.3636363E7 | UNSUPPORTED |
    And user enters the search text "ParquetTag1" and clicks on search
    And user performs "facet selection" in "ParquetTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "userdata1.parquet" item from search results
    Then user performs click and verify in new window
      | Table  | value | Action               | RetainPrevwindow | indexSwitch |
      | Fields | id    | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page


        #7157946
  @MLP-26960 @positve @hdfs @regression @sanity
  Scenario Outline: Renaming the already created file in the existing directory
    Given sync the test execution for "10" seconds
    When configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                                                                                                                                                 | body | response code | response message |
      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | ParquetAnalyzerTest/ParquetSub1/ParquetSub2/userDiffDataTypesParquet.parquet?user.name=raj_ops&op=RENAME&destination=/ParquetAnalyzerTest/ParquetSub1/ParquetSub2/userDiffDataTypesParquet1.parquet |      | 200           | true             |


  Scenario Outline:MLP-26096:#Run the Plugin configurations for HdfsCataloger and ParquetAnalyzer to get and analyze renamed file.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | body                                                                          | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HdfsCataloger                                                        | ida/parquetPayloads/PluginConfiguration/HdfsConfigAutomaticAnalysisFalse.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HdfsCataloger                                                        |                                                                               | 200           | HdfsCataloger    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger        |                                                                               | 200           | IDLE             | $.[?(@.configurationName=='HdfsCataloger')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger         |                                                                               | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger        |                                                                               | 200           | IDLE             | $.[?(@.configurationName=='HdfsCataloger')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetAnalyzer                                                      | ida/parquetPayloads/PluginConfiguration/ParquetAnalyzerConfiguration.json     | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetAnalyzer                                                      |                                                                               | 200           | ParquetAnalyzer  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/ParquetAnalyzer |                                                                               | 200           | IDLE             | $.[?(@.configurationName=='ParquetAnalyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/ParquetAnalyzer  |                                                                               | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/ParquetAnalyzer |                                                                               | 200           | IDLE             | $.[?(@.configurationName=='ParquetAnalyzer')].status |

#7157946 Bugs MLP-26016 and MLP-26548 are raised.
  @webtest @MLP-26096
  Scenario:SC19#Verify the data sampling works fine for renamed file.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ParquetTag1" and clicks on search
    And user performs "facet selection" in "ParquetTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "userDiffDataTypesParquet1.parquet" item from search results
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | Username      | Age | Phone  | InCity | longType | floatType | doubleType  | byteType    |
      | Sehwag        | 38  | 123445 | true   | 4353     | 6447474.0 | 5.3636363E7 | UNSUPPORTED |
      | TestUserName1 | 48  | 323445 | false  | 4353     | 6447474.0 | 5.3636363E7 | UNSUPPORTED |



  #7157938
  @positve @regression @sanity @webtest
  Scenario:SC20#Verify data profiling appears for numeric fields in Parquet files.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "ParquetTag1" and clicks on search
    And user performs "facet selection" in "ParquetTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "userDiffDataTypesParquet1.parquet" item from search results
    Then user performs click and verify in new window
      | Table  | value | Action               | RetainPrevwindow | indexSwitch |
      | Fields | age   | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | integer       | Description |
      | Average                       | 43            | Statistics  |
      | Maximum value                 | 48            | Statistics  |
      | Minimum value                 | 38            | Statistics  |
      | Median                        | 43            | Statistics  |
      | Number of non null values     | 2             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Standard deviation            | 7.07          | Statistics  |
      | Variance                      | 50            | Statistics  |
      | sum                           | 86            | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value    | Action               | RetainPrevwindow | indexSwitch |
      | Fields | longType | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | long          | Description |
      | Average                       | 4353          | Statistics  |
      | Maximum value                 | 4353          | Statistics  |
      | Minimum value                 | 4353          | Statistics  |
      | Median                        | 4353          | Statistics  |
      | Number of non null values     | 2             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of unique values       | 1             | Statistics  |
      | Percentage of unique values   | 50            | Statistics  |
      | sum                           | 8706          | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value     | Action               | RetainPrevwindow | indexSwitch |
      | Fields | floatType | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | float         | Description |
      | Average                       | 6447474       | Statistics  |
      | Maximum value                 | 6447474.0     | Statistics  |
      | Minimum value                 | 6447474.0     | Statistics  |
      | Median                        | 6447474       | Statistics  |
      | Number of non null values     | 2             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of unique values       | 1             | Statistics  |
      | Percentage of unique values   | 50            | Statistics  |
      | sum                           | 1.2894948E7   | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value      | Action               | RetainPrevwindow | indexSwitch |
      | Fields | doubleType | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | double        | Description |
      | Average                       | 53636363      | Statistics  |
      | Maximum value                 | 5.3636363E7   | Statistics  |
      | Minimum value                 | 5.3636363E7   | Statistics  |
      | Median                        | 53636363      | Statistics  |
      | Number of non null values     | 2             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of unique values       | 1             | Statistics  |
      | Percentage of unique values   | 50            | Statistics  |
      | sum                           | 1.07272726E8  | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page


    #7157946
  @positve @regression @sanity @webtest
  Scenario:SC21#Verify data profiling appears for string,boolean,binary fields for renamed file.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "ParquetTag1" and clicks on search
    And user performs "facet selection" in "ParquetTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "userDiffDataTypesParquet1.parquet" item from search results
    Then user performs click and verify in new window
      | Table  | value    | Action               | RetainPrevwindow | indexSwitch |
      | Fields | username | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | string        | Description |
      | avgLength                     | 9.5           | Statistics  |
      | avgWordCount                  | 1             | Statistics  |
      | Maximum length                | 13            | Statistics  |
      | Maximum value                 | TestUserName1 | Statistics  |
      | maxWordCount                  | 1             | Statistics  |
      | Minimum length                | 6             | Statistics  |
      | Minimum value                 | Sehwag        | Statistics  |
      | minWordCount                  | 1             | Statistics  |
      | mostFrequentWord              | Sehwag        | Statistics  |
      | Number of non null values     | 2             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not presence" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value  | Action               | RetainPrevwindow | indexSwitch |
      | Fields | InCity | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
      | Maximum value      | Statistics |
      | Minimum value      | Statistics |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | boolean       | Description |
      | Number of non null values     | 2             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not presence" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value    | Action               | RetainPrevwindow | indexSwitch |
      | Fields | byteType | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | binary        | Description |
      | Number of non null values     | 2             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not presence" on "Data Distribution" in Item view page

      ############################################# Policy Patterns - PII Tagging ##########################################################
  Scenario Outline:Create root tag and sub tag for ParquetS3 and Update policy tags for ParquetAnalyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                     | body                                                          | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | tags/Default/structures | ida/parquetPayloads/policyEngine/HdfsparquetTagStructure.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | policy/tagging/actions  | ida/parquetPayloads/policyEngine/Hdfsparquet_policy1.1.0.json | 204           |                  |          |

  Scenario:Pre-con4_Update the Host name respect to the docker
    And user update json file "ida/parquetPayloads/DataSource/hdfsdbValidDataSourceConfig.json" file for following values using property loader
      | jsonPath                                              | jsonValues      |
      | $.configurations[0].clusterManager.clusterManagerHost | clusterHostName |

  Scenario Outline:MLP-26096:#Run the Plugin configurations for HdfsCataloger and ParquetAnalyzer to get and analyze renamed file.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | body                                                                      | response code | response message     | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HdfsDataSource                                                       | ida/parquetPayloads/DataSource/hdfsdbValidDataSourceConfig.json           | 204           |                      |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HdfsDataSource                                                       |                                                                           | 200           | HDFSDataSource_valid |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HdfsCataloger                                                        | ida/parquetPayloads/PluginConfiguration/HdfsConfigPIITags.json            | 204           |                      |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HdfsCataloger                                                        |                                                                           | 200           | HdfsCataloger        |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger        |                                                                           | 200           | IDLE                 | $.[?(@.configurationName=='HdfsCataloger')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger         |                                                                           | 200           |                      |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger        |                                                                           | 200           | IDLE                 | $.[?(@.configurationName=='HdfsCataloger')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetAnalyzer                                                      | ida/parquetPayloads/PluginConfiguration/ParquetAnalyzerConfiguration.json | 204           |                      |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetAnalyzer                                                      |                                                                           | 200           | ParquetAnalyzer      |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/ParquetAnalyzer |                                                                           | 200           | IDLE                 | $.[?(@.configurationName=='ParquetAnalyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/ParquetAnalyzer  |                                                                           | 200           |                      |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/ParquetAnalyzer |                                                                           | 200           | IDLE                 | $.[?(@.configurationName=='ParquetAnalyzer')].status |


  @positve @regression @sanity  @PIITag
  Scenario:SC22MLP_26096_Verify PIItags for Parquet File fields ,typePattern can be set as:string or .*str.* minimumRatio:0.5, Match Empty=false, Match Full=false.
  Verify Tag is set for the column when typePattern(String) and dataPattern/minimumRatio matches with the column type/value ratio in Parquet file field.
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                                          | Column    | Tags                                                          | Query          | Action      |
      | tagdetails_allmatch_parquet.parquet                         | GENDER    | Parquet,ParquetHdfsGenderPII_SC1Tag,Parquet_BA,ParquetTag1    | FileFieldQuery | TagAssigned |
      | tagdetails_allmatch_parquet.parquet                         | SSN       | Parquet,ParquetHdfsSSNPII_SC1Tag,Parquet_BA,ParquetTag1       | FileFieldQuery | TagAssigned |
      | tagdetails_allmatch_parquet.parquet                         | IPADDRESS | Parquet,ParquetHdfsIPAddressPII_SC1Tag,Parquet_BA,ParquetTag1 | FileFieldQuery | TagAssigned |
      | tagdetails_allmatch_parquet.parquet                         | FULL_NAME | Parquet,ParquetHdfsFullNamePII_SC1Tag,Parquet_BA,ParquetTag1  | FileFieldQuery | TagAssigned |
      | tagdetails_allmatch_parquet.parquet                         | EMAIL     | Parquet,ParquetHdfsEmailPII_SC1Tag,Parquet_BA,ParquetTag1     | FileFieldQuery | TagAssigned |
      | tagdetails_allempty_parquet.parquet                         | EMAIL     | Parquet,ParquetHdfsEmailPII_SC1Tag,Parquet_BA,ParquetTag1     | FileFieldQuery | TagAssigned |
      | tagdetails_allempty_parquet.parquet                         | SSN       | Parquet,ParquetHdfsSSNPII_SC1Tag,Parquet_BA,ParquetTag1       | FileFieldQuery | TagAssigned |
      | tagdetails_allempty_parquet.parquet                         | IPADDRESS | Parquet,ParquetHdfsIPAddressPII_SC1Tag,Parquet_BA,ParquetTag1 | FileFieldQuery | TagAssigned |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet        | EMAIL     | Parquet,ParquetHdfsEmailPII_SC1Tag,Parquet_BA,ParquetTag1     | FileFieldQuery | TagAssigned |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet        | GENDER    | Parquet,ParquetHdfsGenderPII_SC1Tag,Parquet_BA,ParquetTag1    | FileFieldQuery | TagAssigned |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet        | IPADDRESS | Parquet,ParquetHdfsIPAddressPII_SC1Tag,Parquet_BA,ParquetTag1 | FileFieldQuery | TagAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | GENDER    | Parquet,ParquetHdfsGenderPII_SC1Tag,Parquet_BA,ParquetTag1    | FileFieldQuery | TagAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | SSN       | Parquet,ParquetHdfsSSNPII_SC1Tag,Parquet_BA,ParquetTag1       | FileFieldQuery | TagAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | IPADDRESS | Parquet,ParquetHdfsIPAddressPII_SC1Tag,Parquet_BA,ParquetTag1 | FileFieldQuery | TagAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | FULL_NAME | Parquet,ParquetHdfsFullNamePII_SC1Tag,Parquet_BA,ParquetTag1  | FileFieldQuery | TagAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | EMAIL     | Parquet,ParquetHdfsEmailPII_SC1Tag,Parquet_BA,ParquetTag1     | FileFieldQuery | TagAssigned |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet         | GENDER    | Parquet,ParquetHdfsGenderPII_SC1Tag,Parquet_BA,ParquetTag1    | FileFieldQuery | TagAssigned |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet         | SSN       | Parquet,ParquetHdfsSSNPII_SC1Tag,Parquet_BA,ParquetTag1       | FileFieldQuery | TagAssigned |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet         | IPADDRESS | Parquet,ParquetHdfsIPAddressPII_SC1Tag,Parquet_BA,ParquetTag1 | FileFieldQuery | TagAssigned |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet         | FULL_NAME | Parquet,ParquetHdfsFullNamePII_SC1Tag,Parquet_BA,ParquetTag1  | FileFieldQuery | TagAssigned |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet         | EMAIL     | Parquet,ParquetHdfsEmailPII_SC1Tag,Parquet_BA,ParquetTag1     | FileFieldQuery | TagAssigned |


  @positve @regression @sanity  @PIITag
  Scenario:SC23#MLP_26096_Verify PItags not set for Parquet File columns , typePattern can be set as:  NUMBER or .*VAR1.* or .*FLOAT.* or .*NUM.*  minimumRatio:0.5
  Verify Tag is not set for the column when typePattern(other than String) and dataPattern/minimumRatio matches with the column type/value ratio in Parquet file field.
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                                          | Column    | Tags                           | Query          | Action         |
      | tagdetails_allmatch_parquet.parquet                         | GENDER    | ParquetHdfsGenderPII_SC2Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_parquet.parquet                         | SSN       | ParquetHdfsSSNPII_SC2Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_parquet.parquet                         | IPADDRESS | ParquetHdfsIPAddressPII_SC2Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_parquet.parquet                         | FULL_NAME | ParquetHdfsFullNamePII_SC2Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_parquet.parquet                         | EMAIL     | ParquetHdfsEmailPII_SC2Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_parquet.parquet                         | EMAIL     | ParquetHdfsEmailPII_SC2Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_parquet.parquet                         | SSN       | ParquetHdfsSSNPII_SC2Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_parquet.parquet                         | IPADDRESS | ParquetHdfsIPAddressPII_SC2Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_parquet.parquet                         | GENDER    | ParquetHdfsGenderPII_SC2Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_parquet.parquet                         | FULL_NAME | ParquetHdfsFullNamePII_SC2Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet        | EMAIL     | ParquetHdfsEmailPII_SC2Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet        | GENDER    | ParquetHdfsGenderPII_SC2Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet        | IPADDRESS | ParquetHdfsIPAddressPII_SC2Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet        | SSN       | ParquetHdfsSSNPII_SC2Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet        | FULL_NAME | ParquetHdfsFullNamePII_SC2Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | GENDER    | ParquetHdfsGenderPII_SC2Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | SSN       | ParquetHdfsSSNPII_SC2Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | IPADDRESS | ParquetHdfsIPAddressPII_SC2Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | FULL_NAME | ParquetHdfsFullNamePII_SC2Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | EMAIL     | ParquetHdfsEmailPII_SC2Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet         | GENDER    | ParquetHdfsGenderPII_SC2Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet         | SSN       | ParquetHdfsSSNPII_SC2Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet         | IPADDRESS | ParquetHdfsIPAddressPII_SC2Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet         | FULL_NAME | ParquetHdfsFullNamePII_SC2Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet         | EMAIL     | ParquetHdfsEmailPII_SC2Tag     | FileFieldQuery | TagNotAssigned |


  @positve @regression @sanity  @PIITag
  Scenario:SC24#MLP_26096_Verify PItags for Parquet File columns  , namePattern can be set as:.*FULL.*,.*IP.*,GENDER,.*EMAIL.*,SSN.*, minimumRatio:0.5
  Verify Tag is set for the column when namePattern and dataPattern/minimumRatio matches with the column name/value ratio in Parquet File Columns.
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                                          | Column    | Tags                                                          | Query          | Action      |
      | tagdetails_allmatch_parquet.parquet                         | GENDER    | Parquet,ParquetHdfsGenderPII_SC3Tag,Parquet_BA,ParquetTag1    | FileFieldQuery | TagAssigned |
      | tagdetails_allmatch_parquet.parquet                         | SSN       | Parquet,ParquetHdfsSSNPII_SC3Tag,Parquet_BA,ParquetTag1       | FileFieldQuery | TagAssigned |
      | tagdetails_allmatch_parquet.parquet                         | IPADDRESS | Parquet,ParquetHdfsIPAddressPII_SC3Tag,Parquet_BA,ParquetTag1 | FileFieldQuery | TagAssigned |
      | tagdetails_allmatch_parquet.parquet                         | FULL_NAME | Parquet,ParquetHdfsFullNamePII_SC3Tag,Parquet_BA,ParquetTag1  | FileFieldQuery | TagAssigned |
      | tagdetails_allmatch_parquet.parquet                         | EMAIL     | Parquet,ParquetHdfsEmailPII_SC3Tag,Parquet_BA,ParquetTag1     | FileFieldQuery | TagAssigned |
      | tagdetails_allempty_parquet.parquet                         | EMAIL     | Parquet,ParquetHdfsEmailPII_SC3Tag,Parquet_BA,ParquetTag1     | FileFieldQuery | TagAssigned |
      | tagdetails_allempty_parquet.parquet                         | SSN       | Parquet,ParquetHdfsSSNPII_SC3Tag,Parquet_BA,ParquetTag1       | FileFieldQuery | TagAssigned |
      | tagdetails_allempty_parquet.parquet                         | IPADDRESS | Parquet,ParquetHdfsIPAddressPII_SC3Tag,Parquet_BA,ParquetTag1 | FileFieldQuery | TagAssigned |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet        | EMAIL     | Parquet,ParquetHdfsEmailPII_SC3Tag,Parquet_BA,ParquetTag1     | FileFieldQuery | TagAssigned |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet        | GENDER    | Parquet,ParquetHdfsGenderPII_SC3Tag,Parquet_BA,ParquetTag1    | FileFieldQuery | TagAssigned |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet        | IPADDRESS | Parquet,ParquetHdfsIPAddressPII_SC3Tag,Parquet_BA,ParquetTag1 | FileFieldQuery | TagAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | GENDER    | Parquet,ParquetHdfsGenderPII_SC3Tag,Parquet_BA,ParquetTag1    | FileFieldQuery | TagAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | SSN       | Parquet,ParquetHdfsSSNPII_SC3Tag,Parquet_BA,ParquetTag1       | FileFieldQuery | TagAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | IPADDRESS | Parquet,ParquetHdfsIPAddressPII_SC3Tag,Parquet_BA,ParquetTag1 | FileFieldQuery | TagAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | FULL_NAME | Parquet,ParquetHdfsFullNamePII_SC3Tag,Parquet_BA,ParquetTag1  | FileFieldQuery | TagAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | EMAIL     | Parquet,ParquetHdfsEmailPII_SC3Tag,Parquet_BA,ParquetTag1     | FileFieldQuery | TagAssigned |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet         | GENDER    | Parquet,ParquetHdfsGenderPII_SC3Tag,Parquet_BA,ParquetTag1    | FileFieldQuery | TagAssigned |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet         | SSN       | Parquet,ParquetHdfsSSNPII_SC3Tag,Parquet_BA,ParquetTag1       | FileFieldQuery | TagAssigned |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet         | IPADDRESS | Parquet,ParquetHdfsIPAddressPII_SC3Tag,Parquet_BA,ParquetTag1 | FileFieldQuery | TagAssigned |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet         | FULL_NAME | Parquet,ParquetHdfsFullNamePII_SC3Tag,Parquet_BA,ParquetTag1  | FileFieldQuery | TagAssigned |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet         | EMAIL     | Parquet,ParquetHdfsEmailPII_SC3Tag,Parquet_BA,ParquetTag1     | FileFieldQuery | TagAssigned |


  @positve @regression @sanity  @PIITag
  Scenario:SC25#MLP_26096_Verify PIItags not set for Parquet file columns , namePattern set as: .*F1ULL.*,IP1,1GENDER,.*EM1AIL.*,SSN11.*, minimumRatio:0.5
  Verify Tag is not set for the column when namePattern(does not match) and dataPattern/minimumRatio that does not matches with the column name/value ratio in Parquet file fields.
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                                          | Column    | Tags                           | Query          | Action         |
      | tagdetails_allmatch_parquet.parquet                         | GENDER    | ParquetHdfsGenderPII_SC4Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_parquet.parquet                         | SSN       | ParquetHdfsSSNPII_SC4Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_parquet.parquet                         | IPADDRESS | ParquetHdfsIPAddressPII_SC4Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_parquet.parquet                         | FULL_NAME | ParquetHdfsFullNamePII_SC4Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_parquet.parquet                         | EMAIL     | ParquetHdfsEmailPII_SC4Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_parquet.parquet                         | EMAIL     | ParquetHdfsEmailPII_SC4Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_parquet.parquet                         | SSN       | ParquetHdfsSSNPII_SC4Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_parquet.parquet                         | IPADDRESS | ParquetHdfsIPAddressPII_SC4Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_parquet.parquet                         | GENDER    | ParquetHdfsGenderPII_SC42Tag   | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_parquet.parquet                         | FULL_NAME | ParquetHdfsFullNamePII_SC4Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet        | EMAIL     | ParquetHdfsEmailPII_SC4Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet        | GENDER    | ParquetHdfsGenderPII_SC4Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet        | IPADDRESS | ParquetHdfsIPAddressPII_SC4Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet        | SSN       | ParquetHdfsSSNPII_SC4Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet        | FULL_NAME | ParquetHdfsFullNamePII_SC4Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | GENDER    | ParquetHdfsGenderPII_SC4Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | SSN       | ParquetHdfsSSNPII_SC4Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | IPADDRESS | ParquetHdfsIPAddressPII_SC4Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | FULL_NAME | ParquetHdfsFullNamePII_SC4Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | EMAIL     | ParquetHdfsEmailPII_SC4Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet         | GENDER    | ParquetHdfsGenderPII_SC4Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet         | SSN       | ParquetHdfsSSNPII_SC4Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet         | IPADDRESS | ParquetHdfsIPAddressPII_SC4Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet         | FULL_NAME | ParquetHdfsFullNamePII_SC4Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet         | EMAIL     | ParquetHdfsEmailPII_SC4Tag     | FileFieldQuery | TagNotAssigned |


  Scenario:SC26#MLP_26096_Verify PItags for Parquet file fields , valid name and type pattern minimumRatio:0.2
  Verify Tag is set for the column when dataPattern and minimumRatio(lesser than 0.5) is passed which has a regexp that matches with the data in column in redshift table.
  (Ex: 0.2 - 2 or more rows should have matcning column values)- Match Empty is False
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                                   | Column    | Tags                           | Query          | Action      |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet | GENDER    | ParquetHdfsGenderPII_SC5Tag    | FileFieldQuery | TagAssigned |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet | SSN       | ParquetHdfsSSNPII_SC5Tag       | FileFieldQuery | TagAssigned |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet | IPADDRESS | ParquetHdfsIPAddressPII_SC5Tag | FileFieldQuery | TagAssigned |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet | FULL_NAME | ParquetHdfsFullNamePII_SC5Tag  | FileFieldQuery | TagAssigned |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet | EMAIL     | ParquetHdfsEmailPII_SC5Tag     | FileFieldQuery | TagAssigned |


  Scenario:SC27#MLP_26096_Verify PIItags for Parquet file fields , minimumRatio:0.6 matchfull true and matchempty false
  Verify Tag is not set for the column when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the data in column in redshift table.
  (Ex: 0.6 - 6 or more rows should have matcning column values including empty) - Match Empty is False -10 rows , 2 rows empty/1 row blank, 4 rows match,3 rows does not match
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                                          | Column    | Tags                           | Query          | Action         |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | IPADDRESS | ParquetHdfsIPAddressPII_SC6Tag | FileFieldQuery | TagAssigned    |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | EMAIL     | ParquetHdfsEmailPII_SC6Tag     | FileFieldQuery | TagAssigned    |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | GENDER    | ParquetHdfsGenderPII_SC6Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | FULL_NAME | ParquetHdfsFullNamePII_SC6Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | SSN       | ParquetHdfsSSNPII_SC6Tag       | FileFieldQuery | TagNotAssigned |


  Scenario:SC28#MLP_26096_Verify PIItags for Parquet File fields , minimumRatio:1 matchfull false and matchempty false
  Verify Tag is set for the column when dataPattern and minimumRatio(1-full match) is passed which has a regexp that matches with the data in column in redshift table.
  (Ex: 1 - all rows should match) - Match Empty is false
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                  | Column    | Tags                           | Query          | Action      |
      | tagdetails_allmatch_parquet.parquet | GENDER    | ParquetHdfsGenderPII_SC8Tag    | FileFieldQuery | TagAssigned |
      | tagdetails_allmatch_parquet.parquet | SSN       | ParquetHdfsSSNPII_SC8Tag       | FileFieldQuery | TagAssigned |
      | tagdetails_allmatch_parquet.parquet | IPADDRESS | ParquetHdfsIPAddressPII_SC8Tag | FileFieldQuery | TagAssigned |
      | tagdetails_allmatch_parquet.parquet | FULL_NAME | ParquetHdfsFullNamePII_SC8Tag  | FileFieldQuery | TagAssigned |
      | tagdetails_allmatch_parquet.parquet | EMAIL     | ParquetHdfsEmailPII_SC8Tag     | FileFieldQuery | TagAssigned |

  Scenario:SC29#MLP_26096_Verify PIItags for Parquet file fields , minimumRatio:0.5 matchfull false and matchempty false
  Verify Tag is set for the column when dataPattern and minimumRatio(equal to 0.5) is passed which has a regexp that matches with the data in column in redshift table.
  (Ex: 0.5 - 5 or more rows should have matching column values) - Match Empty is false.
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                                  | Column    | Tags                           | Query          | Action      |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet | GENDER    | ParquetHdfsGenderPII_SC9Tag    | FileFieldQuery | TagAssigned |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet | SSN       | ParquetHdfsSSNPII_SC9Tag       | FileFieldQuery | TagAssigned |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet | IPADDRESS | ParquetHdfsIPAddressPII_SC9Tag | FileFieldQuery | TagAssigned |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet | FULL_NAME | ParquetHdfsFullNamePII_SC9Tag  | FileFieldQuery | TagAssigned |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet | EMAIL     | ParquetHdfsEmailPII_SC9Tag     | FileFieldQuery | TagAssigned |


  Scenario:SC30#MLP_26096_Verify PIItags for DynamoDB tables , minimumRatio:0.2 matchfull false and matchempty false,namePattern can be set as:FULL.*,IPADDRESS,GENDER,.*MAIL,.*SSN.*
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                                   | Column    | Tags                            | Query          | Action      |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet | GENDER    | ParquetHdfsGenderPII_SC10Tag    | FileFieldQuery | TagAssigned |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet | SSN       | ParquetHdfsSSNPII_SC10Tag       | FileFieldQuery | TagAssigned |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet | IPADDRESS | ParquetHdfsIPAddressPII_SC10Tag | FileFieldQuery | TagAssigned |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet | FULL_NAME | ParquetHdfsFullNamePII_SC10Tag  | FileFieldQuery | TagAssigned |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet | EMAIL     | ParquetHdfsEmailPII_SC10Tag     | FileFieldQuery | TagAssigned |


  @positve @regression @sanity  @PIITag
  Scenario:SC31#MLP_26096_Verify PItags not set for Parquet file fields , namePattern set as: FULL1.*,IPAD1DRESS,GENDER1,.*1MAIL,.*1SSN.*, minimumRatio:0.2
  Verify Tag is not set for the column when namePattern(does not match),typePattern,dataPattern,minimumRatio is passed which has any of the regexp and ratio that does not matches with the data in Parquet file fields.
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                                          | Column    | Tags                            | Query          | Action         |
      | tagdetails_allmatch_parquet.parquet                         | GENDER    | ParquetHdfsGenderPII_SC11Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_parquet.parquet                         | SSN       | ParquetHdfsSSNPII_SC11Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_parquet.parquet                         | IPADDRESS | ParquetHdfsIPAddressPII_SC11Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_parquet.parquet                         | FULL_NAME | ParquetHdfsFullNamePII_SC11Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_parquet.parquet                         | EMAIL     | ParquetHdfsEmailPII_SC11Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_parquet.parquet                         | EMAIL     | ParquetHdfsEmailPII_SC11Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_parquet.parquet                         | SSN       | ParquetHdfsSSNPII_SC11Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_parquet.parquet                         | IPADDRESS | ParquetHdfsIPAddressPII_SC11Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_parquet.parquet                         | GENDER    | ParquetHdfsGenderPII_SC11Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_parquet.parquet                         | FULL_NAME | ParquetHdfsFullNamePII_SC11Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet        | EMAIL     | ParquetHdfsEmailPII_SC11Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet        | GENDER    | ParquetHdfsGenderPII_SC11Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet        | IPADDRESS | ParquetHdfsIPAddressPII_SC11Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet        | SSN       | ParquetHdfsSSNPII_SC11Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet        | FULL_NAME | ParquetHdfsFullNamePII_SC11Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | GENDER    | ParquetHdfsGenderPII_SC11Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | SSN       | ParquetHdfsSSNPII_SC11Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | IPADDRESS | ParquetHdfsIPAddressPII_SC11Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | FULL_NAME | ParquetHdfsFullNamePII_SC11Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | EMAIL     | ParquetHdfsEmailPII_SC11Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet         | GENDER    | ParquetHdfsGenderPII_SC11Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet         | SSN       | ParquetHdfsSSNPII_SC11Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet         | IPADDRESS | ParquetHdfsIPAddressPII_SC11Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet         | FULL_NAME | ParquetHdfsFullNamePII_SC11Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet         | EMAIL     | ParquetHdfsEmailPII_SC11Tag     | FileFieldQuery | TagNotAssigned |

  @positve @regression @sanity  @PIITag
  Scenario:SC32#MLP_26096_Verify PItags not set for Parquet file fields , name pattern (Invalid columns) minimumRatio:0.2 matchfull false and matchempty false.
  Verify Tag is not set for the column when namePattern,typePattern(does not match),dataPattern,minimumRatio is passed which has any of the regexp and ratio that does not matches with the data in parquet file fields.
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                                          | Column    | Tags                            | Query          | Action         |
      | tagdetails_allmatch_parquet.parquet                         | GENDER    | ParquetHdfsGenderPII_SC12Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_parquet.parquet                         | SSN       | ParquetHdfsSSNPII_SC12Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_parquet.parquet                         | IPADDRESS | ParquetHdfsIPAddressPII_SC12Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_parquet.parquet                         | FULL_NAME | ParquetHdfsFullNamePII_SC12Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_parquet.parquet                         | EMAIL     | ParquetHdfsEmailPII_SC12Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_parquet.parquet                         | EMAIL     | ParquetHdfsEmailPII_SC12Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_parquet.parquet                         | SSN       | ParquetHdfsSSNPII_SC12Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_parquet.parquet                         | IPADDRESS | ParquetHdfsIPAddressPII_SC12Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_parquet.parquet                         | GENDER    | ParquetHdfsGenderPII_SC12Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_parquet.parquet                         | FULL_NAME | ParquetHdfsFullNamePII_SC12Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet        | EMAIL     | ParquetHdfsEmailPII_SC12Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet        | GENDER    | ParquetHdfsGenderPII_SC12Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet        | IPADDRESS | ParquetHdfsIPAddressPII_SC12Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet        | SSN       | ParquetHdfsSSNPII_SC12Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet        | FULL_NAME | ParquetHdfsFullNamePII_SC12Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | GENDER    | ParquetHdfsGenderPII_SC12Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | SSN       | ParquetHdfsSSNPII_SC12Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | IPADDRESS | ParquetHdfsIPAddressPII_SC12Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | FULL_NAME | ParquetHdfsFullNamePII_SC12Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | EMAIL     | ParquetHdfsEmailPII_SC12Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet         | GENDER    | ParquetHdfsGenderPII_SC12Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet         | SSN       | ParquetHdfsSSNPII_SC12Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet         | IPADDRESS | ParquetHdfsIPAddressPII_SC12Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet         | FULL_NAME | ParquetHdfsFullNamePII_SC12Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet         | EMAIL     | ParquetHdfsEmailPII_SC12Tag     | FileFieldQuery | TagNotAssigned |

  @positve @regression @sanity  @PIITag
  Scenario:SC33#MLP_26096_Verify PItags not set for Parquet file fields , data pattern (Invalid regex) minimumRatio:0.2 matchfull false and matchempty false
  Verify Tag is not set for the column when namePattern,typePattern,dataPattern and minimumRatio(does not match) is passed which has any of the regexp and ratio that does not matches with the data in parquet file fields.
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                                          | Column    | Tags                            | Query          | Action         |
      | tagdetails_allmatch_parquet.parquet                         | GENDER    | ParquetHdfsGenderPII_SC13Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_parquet.parquet                         | SSN       | ParquetHdfsSSNPII_SC13Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_parquet.parquet                         | IPADDRESS | ParquetHdfsIPAddressPII_SC13Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_parquet.parquet                         | FULL_NAME | ParquetHdfsFullNamePII_SC13Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_parquet.parquet                         | EMAIL     | ParquetHdfsEmailPII_SC13Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_parquet.parquet                         | EMAIL     | ParquetHdfsEmailPII_SC13Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_parquet.parquet                         | SSN       | ParquetHdfsSSNPII_SC13Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_parquet.parquet                         | IPADDRESS | ParquetHdfsIPAddressPII_SC13Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_parquet.parquet                         | GENDER    | ParquetHdfsGenderPII_SC13Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_parquet.parquet                         | FULL_NAME | ParquetHdfsFullNamePII_SC13Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet        | EMAIL     | ParquetHdfsEmailPII_SC13Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet        | GENDER    | ParquetHdfsGenderPII_SC13Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet        | IPADDRESS | ParquetHdfsIPAddressPII_SC13Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet        | SSN       | ParquetHdfsSSNPII_SC13Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet        | FULL_NAME | ParquetHdfsFullNamePII_SC13Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | GENDER    | ParquetHdfsGenderPII_SC13Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | SSN       | ParquetHdfsSSNPII_SC13Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | IPADDRESS | ParquetHdfsIPAddressPII_SC13Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | FULL_NAME | ParquetHdfsFullNamePII_SC13Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | EMAIL     | ParquetHdfsEmailPII_SC13Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet         | GENDER    | ParquetHdfsGenderPII_SC13Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet         | SSN       | ParquetHdfsSSNPII_SC13Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet         | IPADDRESS | ParquetHdfsIPAddressPII_SC13Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet         | FULL_NAME | ParquetHdfsFullNamePII_SC13Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet         | EMAIL     | ParquetHdfsEmailPII_SC13Tag     | FileFieldQuery | TagNotAssigned |

  Scenario:SC34#MLP_26096_Verify PIItags for Parquet file fields , minimumRatio:0.5 matchfull false and matchempty true.
  Verify Tag is not set for the column when Ignore empty and null is true and all the column values in DB are blank/null.(dataPattern/minimumRatio/MatchEmpty:True/MatchFull:False)
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                  | Column    | Tags                            | Query          | Action      |
      | tagdetails_allempty_parquet.parquet | EMAIL     | ParquetHdfsEmailPII_SC14Tag     | FileFieldQuery | TagAssigned |
      | tagdetails_allempty_parquet.parquet | SSN       | ParquetHdfsSSNPII_SC14Tag       | FileFieldQuery | TagAssigned |
      | tagdetails_allempty_parquet.parquet | IPADDRESS | ParquetHdfsIPAddressPII_SC14Tag | FileFieldQuery | TagAssigned |

  Scenario:SC35#MLP_26096_Verify PIItags for Parquet file fields , minimumRatio:0.6 matchfull true and matchempty false
  Verify Multiple Tag is not set for the column when Whole word Match:true and Tag is set when reran with Whole word Match:false when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the exact data in column in redshift table.
  (Ex: 0.6 - 6 or more rows should have matcning column values - dataPattern and minimumRatio passed).
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                                         | Column   | Tags                           | Query          | Action         |
      | tagdetails_ratiogreaterthan05matchfulltrue_parquet.parquet | COMMENTS | ParquetHdfsFullMatchPII_SC1Tag | FileFieldQuery | TagNotAssigned |

  Scenario:SC36#MLP_26096_Verify PIItags for Parquet file fields , minimumRatio:0.2 matchfull true and matchempty false
  Verify Multiple Tag is not set for the column when Whole word Match:true and Tag is set when reran with Whole word Match:false when dataPattern and minimumRatio(lesser than 0.5) is passed which has a regexp that matches with the exact data in column in redshift table.
  (Ex: 0.2 - 2 or more rows should have matcning column values - namePattern,typePattern,dataPattern and minimumRatio passed).
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                                        | Column   | Tags                           | Query          | Action         |
      | tagdetails_ratiolesserthan05matchfulltrue_parquet.parquet | COMMENTS | ParquetHdfsFullMatchPII_SC3Tag | FileFieldQuery | TagNotAssigned |


  Scenario Outline:Policy2:Create root tag and sub tag for HDFS Parquet Anlayzer and Update policy tags for ParquetAnalyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                    | body                                                           | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | policy/tagging/actions | ida/parquetPayloads/policyEngine/Hdfsparquet1_policy1.1.0.json | 204           |                  |          |

  Scenario Outline:MLP-26096:#ReRun the Plugin configurations for ParquetAnalyzer.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | body | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger        |      | 200           | IDLE             | $.[?(@.configurationName=='HdfsCataloger')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger         |      | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger        |      | 200           | IDLE             | $.[?(@.configurationName=='HdfsCataloger')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/ParquetAnalyzer |      | 200           | IDLE             | $.[?(@.configurationName=='ParquetAnalyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/ParquetAnalyzer  |      | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/ParquetAnalyzer |      | 200           | IDLE             | $.[?(@.configurationName=='ParquetAnalyzer')].status |


  Scenario:SC37#MLP_26096_Verify PIItags for Parquet file fields , minimumRatio:0.6 matchfull false and matchempty true
  Verify Tag is not set for the column when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the data in parquet file fields.
  (Ex: 0.6 - 6 or more rows should have matcning column values including empty) - Match Empty is False -10 rows , 2 rows empty/1 row blank, 4 rows match,3 rows does not match
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                                          | Column    | Tags                           | Query          | Action      |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | IPADDRESS | ParquetHdfsIPAddressPII_SC7Tag | FileFieldQuery | TagAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | EMAIL     | ParquetHdfsEmailPII_SC7Tag     | FileFieldQuery | TagAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | FULL_NAME | ParquetHdfsFullNamePII_SC7Tag  | FileFieldQuery | TagAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | GENDER    | ParquetHdfsGenderPII_SC7Tag    | FileFieldQuery | TagAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | SSN       | ParquetHdfsSSNPII_SC7Tag       | FileFieldQuery | TagAssigned |

  Scenario:SC38#MLP_26096_Verify PIItags for Parquet file fields , minimumRatio:0.6 matchfull true and matchempty false
  Verify Multiple Tag is not set for the column when Whole word Match:true and Tag is set when reran with Whole word Match:false when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the exact data in column in redshift table.
  (Ex: 0.6 - 6 or more rows should have matcning column values - dataPattern and minimumRatio passed).
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                                         | Column   | Tags                           | Query          | Action      |
      | tagdetails_ratiogreaterthan05matchfulltrue_parquet.parquet | COMMENTS | ParquetHdfsFullMatchPII_SC2Tag | FileFieldQuery | TagAssigned |


  Scenario:SC39#MLP_26096_Verify PIItags for Parquet file fields , minimumRatio:0.2 matchfull true and matchempty false
  Verify Multiple Tag is not set for the column when Whole word Match:true and Tag is set when reran with Whole word Match:false when dataPattern and minimumRatio(lesser than 0.5) is passed which has a regexp that matches with the exact data in column in redshift table.
  (Ex: 0.2 - 2 or more rows should have matcning column values - namePattern,typePattern,dataPattern and minimumRatio passed).
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                                        | Column   | Tags                           | Query          | Action      |
      | tagdetails_ratiolesserthan05matchfulltrue_parquet.parquet | COMMENTS | ParquetHdfsFullMatchPII_SC4Tag | FileFieldQuery | TagAssigned |




########################################################################################################################################################################
############### Deleting the created directory and parquet file in Ambari
###############################################################################################################################################################
  @MLP-26096 @positve @hdfs @regression @sanity
  Scenario Outline: Delete the created files in Ambari
    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization              | X-Requested-By | type   | url                                          | body | response code | response message |
      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Delete | ParquetAnalyzerTest?op=DELETE&recursive=true |      | 200           | true             |
      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Delete | ParquetPatternMatch?op=DELETE&recursive=true |      | 200           | true             |

    #################### Deleting the credentials , Data Source & Bussiness Application######################

  @positve @regression @sanity  @MLP-26096 @IDA-1.1.0
  Scenario Outline:Deleting the Credentials and configuration
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                                                  | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/hdfsValidCredential                                             |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/hdfsInValidCredential                                           |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/hdfsEmptyCredential                                             |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/HdfsDataSource                                                    |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/HdfsCataloger                                                     |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ParquetAnalyzer                                                   |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | policy/tagging/analysis?dataType=STRUCTURED&pluginName=ParquetAnalyzer&technologies= |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | /tags/Default/tags/ParquetHdfsPII                                                    |      | 204           |                  |          |

  @positve @regression @sanity  @IDA-1.1.0
  Scenario:Delete Bussiness Application
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name       | type                | query | param |
      | SingleItemDelete | Default | HDFS_BA    | BusinessApplication |       |       |
      | SingleItemDelete | Default | Parquet_BA | BusinessApplication |       |       |