@MLP-1960
Feature:MLP-1960: Validating the Funtionality of HDFS Monitor

  Scenario:SC1#:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/%      | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/AvroAnalyzer/%    | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/CsvAnalyzer/%     | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/ParquetAnalyzer/% | Analysis |       |       |
      | MultipleIDDelete | Default | monitor/HdfsMonitor/%          | Analysis |       |       |
      | SingleItemDelete | Default | Cluster Demo                   | Cluster  |       |       |
      | SingleItemDelete | Default | Sandbox                        | Cluster  |       |       |

    #########################################################################Set Credentials ########################################################################################
  Scenario: SC2#-MLP_24889_Update the Host name respect to the docker
    And user update json file "ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig.json" file for following values using property loader
      | jsonPath                                              | jsonValues      |
      | $.configurations[0].clusterManager.clusterManagerHost | clusterHostName |

  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC2#-MLP_24889_Set the Credentials, Datasource, Bussiness Application and Cataloger for HDFSDB Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                        | body                                                                         | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/hdfsDBValidCredential | ida/hdfsPayloads/Credentials/hdfsdbValidCredentials.json                     | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root                         | ida\hdfsPayloads\Bussiness_Application\BussinessApplication.json             | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root                         | ida\hdfsPayloads\Bussiness_Application\BussinessApplication_HdfsMonitor.json | 200           |                  |          |

   ######################################################################### Tool Tip validation ###############################################################################

#7132255
  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC2#Get the HDFS Cataloger and DataSource Configuration response
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                               | body                                    | response code | response message | filePath                                  | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | /schemes/analyzers/configurations | response/HDFS/body/ToolTip_Monitor.json | 200           |                  | response/HDFS/actual/ToolTip_Monitor.json |          |

  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline:SC2# Validate ToolTip for all the fields in HDFS Monitor plugin(Type,Plugin,Name,Plugin version,label,BA, Data Source, Credential,Event Condition,Dry Run, Event class,Max Work sixe,node condition,Auto Start,tags,Unique Filter)
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                      | actualValues                              | valueType     | expectedJsonPath                                               | actualJsonPath                                         |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip_Monitor.json | stringCompare | $.Commonfields..[?(@.label=='Type')].tooltip                   | $..[?(@.label=='Type')].tooltip                        |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip_Monitor.json | stringCompare | $.Commonfields..[?(@.label=='Plugin')].tooltip                 | $..[?(@.label=='Plugin')].tooltip                      |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip_Monitor.json | stringCompare | $.Commonfields.Name.tooltip                                    | $.properties[0].value.prototype.properties[2].tooltip  |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip_Monitor.json | stringCompare | $.Commonfields.pluginVersion.tooltip                           | $.properties[0].value.prototype.properties[3].tooltip  |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip_Monitor.json | stringCompare | $.Commonfields.label.tooltip                                   | $.properties[0].value.prototype.properties[4].tooltip  |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip_Monitor.json | stringCompare | $.Commonfields.businessApplicationName.tooltip                 | $.properties[0].value.prototype.properties[15].tooltip |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip_Monitor.json | stringCompare | $.Commonfields.eventCondition.tooltip                          | $.properties[0].value.prototype.properties[5].tooltip  |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip_Monitor.json | stringCompare | $.Commonfields.dryRun.tooltip                                  | $.properties[0].value.prototype.properties[6].tooltip  |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip_Monitor.json | stringCompare | $.Commonfields.eventClass.tooltip                              | $.properties[0].value.prototype.properties[7].tooltip  |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip_Monitor.json | stringCompare | $.Commonfields.maxWorkSize.tooltip                             | $.properties[0].value.prototype.properties[8].tooltip  |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip_Monitor.json | stringCompare | $.Commonfields.nodeCondition.tooltip                           | $.properties[0].value.prototype.properties[10].tooltip |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip_Monitor.json | stringCompare | $.Commonfields.autoStart.tooltip                               | $.properties[0].value.prototype.properties[11].tooltip |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip_Monitor.json | stringCompare | $.Commonfields.tags.tooltip                                    | $.properties[0].value.prototype.properties[12].tooltip |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip_Monitor.json | stringCompare | $.Uniquefilter.hdfs_Monitor.Catalogerconfigurationname.tooltip | $.properties[0].value.prototype.properties[16].tooltip |


  @MLP-1960 @positve @hdfs @regression @sanity
  Scenario Outline:SC#4Creating a root directory in Ambari Files View and Uploading a file into the directory
    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization              | X-Requested-By | type | url                                                      | body | response code | response message |
      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | HDFSMonitor_Test?op=MKDIRS&recursive=true&overwrite=true |      | 200           |                  |

  Scenario: SC4#-MLP_24889_Update the Catalog name in HDFS Monitor config
    And user "update" the json file "ida/hdfsPayloads/Monitor/SC1_new_Hdfs_Monitor_Configuration.json" file for following values
      | jsonPath                                     | jsonValues    | type |
      | $.configurations..catalogerConfigurationName | SC1_CreateDir |      |

  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC4#-MLP_24889_set HDFS Monitor and run
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                       | body                                                             | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/HdfsMonitor                                            | ida/hdfsPayloads/Monitor/SC1_new_Hdfs_Monitor_Configuration.json | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/HdfsMonitor                                            |                                                                  | 200           | HdfsMonitor      |          |
      | IDC         | TestSystemUser | application/json |       |       | Post | extensions/analyzers/start/Cluster%20Demo/monitor/HdfsMonitor/HdfsMonitor |                                                                  | 200           |                  |          |

  Scenario: SC4#-MLP_24889_Update the Host name respect to the docker
    And user "update" the json file "ida/hdfsPayloads/Monitor/SC1_new_Hdfs_Cataloger_Configuration.json" file for following values
      | jsonPath                               | jsonValues                     | type    |
      | $.configurations..nodeCondition        | name=="Cluster Demo"           |         |
      | $.configurations..filter..root         | /HDFSMonitor_Test              |         |
      | $.configurations..name                 | SC1_CreateDir                  |         |
      | $.configurations..tags[*]              | SC1_CreateDir                  |         |
      | $.configurations..filter..tags[*]      | AddDir and Files(Subdir combo) |         |
      | $.configurations..autoStart            | false                          | boolean |
      | $.configurations..analyzeCollectedData | false                          | boolean |


  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC4#-MLP_24889_set HDFS data source with cluter resolve name TRUE and run Hdfs cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | body                                                               | response code | response message     | jsonPath                                           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/license                                                                 | ida\hbasePayloads\DataSource\license_DS.json                       | 204           |                      |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsDataSource                                                | ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig.json       | 204           |                      |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsDataSource                                                |                                                                    | 200           | HDFSDataSource_valid |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsCataloger                                                 | ida/hdfsPayloads/Monitor/SC1_new_Hdfs_Cataloger_Configuration.json | 204           |                      |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsCataloger                                                 |                                                                    | 200           | SC1_CreateDir        |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC1_CreateDir |                                                                    | 200           | IDLE                 | $.[?(@.configurationName=='SC1_CreateDir')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC1_CreateDir  |                                                                    | 200           |                      |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC1_CreateDir |                                                                    | 200           | IDLE                 | $.[?(@.configurationName=='SC1_CreateDir')].status |


#########################################################Add a Parent Directory#############################################################################
  @MLP-1960 @positve @hdfs @regression @sanity
  Scenario Outline:SC#5Creating a New Parent directory in Ambari Files View and Uploading a file into the directory
    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                | body | response code | response message |
      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | HDFSMonitor_Test/NewFolder?op=MKDIRS&recursive=true&overwrite=true |      | 200           |                  |


  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC5#-MLP_24889_Wait for Delta time and check if the Cataloger ran successfully
    And sync the test execution for "30" seconds
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | body | response code | response message | jsonPath                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC1_CreateDir |      | 200           | IDLE             | $.[?(@.configurationName=='SC1_CreateDir')].status |

  Scenario Outline: SC5 MLP_24889_Verify whether HDFS monitor triggers HDFS Cataloger(Filter criteria is met) when new Directory is created in Ambari .
    And user update the json file "ida/hdfsPayloads/API/SC2_Filter.json" file for following values
      | jsonPath                                                | jsonValues                                  |
      | $..selections.['asg.tagPathsHierarchy_ss'][*]           | SC1_CreateDir                               |
      | $..selections.['asg.parentTypeNamePathHierarchy_ss'][*] | Cluster/Sandbox/Service/HDFS/Directory/ROOT |
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                       | body                                          | response code | response message | filePath                                          | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | components/itemlist?query=SC1_CreateDir&limitFacet=10&offset=0&limit=2500 | payloads/ida/hdfsPayloads/API/SC2_Filter.json | 200           |                  | response\HDFS\TableFilter\Actual\SC10_Filter.json |          |

  @MLP-24048  @sanity @positive
  Scenario Outline: SC#5 MLP_24889_Compare the tables with respect to filters
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                     | actualValues                                      | valueType         | expectedJsonPath           | actualJsonPath                   |
      | response\HDFS\TableFilter\Expected\SC1_Filter.json | response\HDFS\TableFilter\Actual\SC10_Filter.json | stringListCompare | $.SC7.Directory.name       | $..[?(@.type=='Directory')].name |
      | response\HDFS\TableFilter\Expected\SC1_Filter.json | response\HDFS\TableFilter\Actual\SC10_Filter.json | stringListCompare | $.SC7.Directory.files.name | $..[?(@.type=='File')].name      |


  ##############################################Add Sub-Directory and new Parent Directory#######################################################################

  @MLP-1960 @positve @hdfs @regression @sanity
  Scenario Outline:SC#6Creating a New Sub-Directory directory in Ambari Files View and Uploading a file into the directory
    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                        | body | response code | response message |
      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | HDFSMonitor_Test/NewFolder/Sub-Dir?op=MKDIRS&recursive=true&overwrite=true |      | 200           |                  |
      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | HDFSMonitor_Test/NewFolder1?op=MKDIRS&recursive=true&overwrite=true        |      | 200           |                  |


  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC6#-MLP_24889_Wait for Delta time and check if the Cataloger ran successfully
    And sync the test execution for "30" seconds
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | body | response code | response message | jsonPath                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC1_CreateDir |      | 200           | IDLE             | $.[?(@.configurationName=='SC1_CreateDir')].status |

  Scenario Outline: SC6 MLP_24889_Verify whether HDFS monitor triggers HDFS Cataloger(Filter criteria is met) when new Sub-Directory(Eg:tmp -> test2,tmp/test -> test3,tmp/test1 ->test4) is created under existing parent Directory in Ambari
    And user update the json file "ida/hdfsPayloads/API/SC2_Filter.json" file for following values
      | jsonPath                                                | jsonValues                                  |
      | $..selections.['asg.tagPathsHierarchy_ss'][*]           | SC1_CreateDir                               |
      | $..selections.['asg.parentTypeNamePathHierarchy_ss'][*] | Cluster/Sandbox/Service/HDFS/Directory/ROOT |
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                       | body                                          | response code | response message | filePath                                          | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | components/itemlist?query=SC1_CreateDir&limitFacet=10&offset=0&limit=2500 | payloads/ida/hdfsPayloads/API/SC2_Filter.json | 200           |                  | response\HDFS\TableFilter\Actual\SC11_Filter.json |          |

  @MLP-24048  @sanity @positive
  Scenario Outline: SC#6 MLP_24889_Compare the tables with respect to filters
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                     | actualValues                                      | valueType         | expectedJsonPath           | actualJsonPath                   |
      | response\HDFS\TableFilter\Expected\SC1_Filter.json | response\HDFS\TableFilter\Actual\SC11_Filter.json | stringListCompare | $.SC8.Directory.name       | $..[?(@.type=='Directory')].name |
      | response\HDFS\TableFilter\Expected\SC1_Filter.json | response\HDFS\TableFilter\Actual\SC11_Filter.json | stringListCompare | $.SC8.Directory.files.name | $..[?(@.type=='File')].name      |

   ##############################################Add files to Sub-Directory and Parent Directory#######################################################################

  @MLP-1960 @positve @hdfs @regression @sanity
  Scenario Outline:SC#7Creating a New Sub-Directory directory in Ambari Files View and Uploading a file into the directory
    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                                                                                                                                      | body                                                   | response code | response message |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | HDFSMonitor_Test/NewFolder/uploadFile1.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                      | ida/hdfsPayloads/TestData/HdfsAutomationTestData1.csv  | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | HDFSMonitor_Test/NewFolder/dummy.pdf?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                            | ida/hdfsPayloads/TestData/dummy.pdf                    | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | HDFSMonitor_Test/NewFolder/Sub-Dir/CALC-1985.doc?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                | ida/hdfsPayloads/TestData/CALC-1985.doc                | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | HDFSMonitor_Test/NewFolder/Sub-Dir/insert_cycling_cassandra.txt?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/hdfsPayloads/TestData/insert_cycling_cassandra.txt | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | HDFSMonitor_Test/NewFolder1/hdfs (1).zip?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                        | ida/hdfsPayloads/TestData/hdfs (1).zip                 | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | HDFSMonitor_Test/NewFolder1/userdata1.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                   | ida/hdfsPayloads/TestData/userdata1.parquet            | 201           |                  |

  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC7#-MLP_24889_Wait for Delta time and check if the Cataloger ran successfully
    And sync the test execution for "30" seconds
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | body | response code | response message | jsonPath                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC1_CreateDir |      | 200           | IDLE             | $.[?(@.configurationName=='SC1_CreateDir')].status |

  Scenario Outline: SC7 MLP_24889_Verify whether HDFS monitor triggers HDFS Cataloger(Filter criteria is met) when new Files are add in Sub directory and parent Folder level in Ambari
    And user update the json file "ida/hdfsPayloads/API/SC2_Filter.json" file for following values
      | jsonPath                                                | jsonValues                                  |
      | $..selections.['asg.tagPathsHierarchy_ss'][*]           | SC1_CreateDir                               |
      | $..selections.['asg.parentTypeNamePathHierarchy_ss'][*] | Cluster/Sandbox/Service/HDFS/Directory/ROOT |
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                       | body                                          | response code | response message | filePath                                          | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | components/itemlist?query=SC1_CreateDir&limitFacet=10&offset=0&limit=2500 | payloads/ida/hdfsPayloads/API/SC2_Filter.json | 200           |                  | response\HDFS\TableFilter\Actual\SC12_Filter.json |          |

  @MLP-24048  @sanity @positive
  Scenario Outline: SC#7 MLP_24889_Compare the tables with respect to filters
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                     | actualValues                                      | valueType         | expectedJsonPath           | actualJsonPath                   |
      | response\HDFS\TableFilter\Expected\SC1_Filter.json | response\HDFS\TableFilter\Actual\SC12_Filter.json | stringListCompare | $.SC9.Directory.name       | $..[?(@.type=='Directory')].name |
      | response\HDFS\TableFilter\Expected\SC1_Filter.json | response\HDFS\TableFilter\Actual\SC12_Filter.json | stringListCompare | $.SC9.Directory.files.name | $..[?(@.type=='File')].name      |


##################################################Modify File Name ##############################################################

   #715648
  @MLP-3422 @webtest @positve @hdfs @regression @sanity
  Scenario: SC8#-MLP_24889_Verify whether the last cataloged at value and store in temp String.
    Given User launch browser and traverse to login page
    And user enter credentials for "system Administrator1" role
    And user enters the search text "SC1_CreateDir" and clicks on search
    And user performs "definite facet selection" in "SC1_CreateDir" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "CALC-1985.doc" item from search results
    And user "store as Static" the value of item "CALC-1985.doc" of attribute "Last catalogued at" with temporary text

  @MLP-1960 @positve @hdfs @regression @sanity
  Scenario Outline:SC#8Modify the existing file and upload
    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                                                                                                                       | body                                                | response code | response message |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | HDFSMonitor_Test/NewFolder/Sub-Dir/CALC-1985.doc?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/hdfsPayloads/TestData/UpdatedFile/CALC-1985.doc | 201           |                  |

  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC8#-MLP_24889_Wait for Delta time and check if the Cataloger ran successfully
    And sync the test execution for "30" seconds
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | body | response code | response message | jsonPath                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC1_CreateDir |      | 200           | IDLE             | $.[?(@.configurationName=='SC1_CreateDir')].status |

  @MLP-3422 @webtest @positve @hdfs @regression @sanity
  Scenario: SC8#-MLP_24889_Verify whether the last cataloged at value change for the second run when the Amabari files are modified
    Given User launch browser and traverse to login page
    And user enter credentials for "system Administrator1" role
    And user enters the search text "SC1_CreateDir" and clicks on search
    And user performs "definite facet selection" in "SC1_CreateDir" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "CALC-1985.doc" item from search results
    Then user "verify not equals" the value of item "CALC-1985.doc" of attribute "Last catalogued at" with temporary text


    ####################################HDFS monitor trigger only the appropriate cataloger when Multiple Hdfs cataloger are configured with Hdfs monitor pointing to Hdfscataloger with valid filter config##############

  Scenario: SC9#-MLP_24889_Update the Catalog name in HDFS Monitor config
    And user "update" the json file "ida/hdfsPayloads/Monitor/SC1_new_Hdfs_Monitor_Configuration.json" file for following values
      | jsonPath                                     | jsonValues    | type |
      | $.configurations..catalogerConfigurationName | SC2_CreateDir |      |

  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC9#-MLP_24889_set HDFS Monitor and run (Single monitor)
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                            | body                                                             | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/HdfsMonitor | ida/hdfsPayloads/Monitor/SC1_new_Hdfs_Monitor_Configuration.json | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/HdfsMonitor |                                                                  | 200           | HdfsMonitor      |          |

  Scenario: SC9#-MLP_24889_Update the Host name respect to the docker
    And user "update" the json file "ida/hdfsPayloads/Monitor/SC1_new_Hdfs_Cataloger_Configuration_dual.json" file for following values
      | jsonPath                         | jsonValues             | type    |
      | $.HdfsCat1..nodeCondition        | name=="Cluster Demo"   |         |
      | $.HdfsCat1..filter..root         | /HDFSMonitor_Test      |         |
      | $.HdfsCat1..name                 | SC2_CreateDir          |         |
      | $.HdfsCat1..tags[*]              | SC2_CreateDir          |         |
      | $.HdfsCat1..filter..tags[*]      | Filetoavailable        |         |
      | $.HdfsCat1..autoStart            | false                  | boolean |
      | $.HdfsCat1..analyzeCollectedData | false                  | boolean |
      | $.HdfsCat2..nodeCondition        | name=="Cluster Demo"   |         |
      | $.HdfsCat2..filter..root         | /HDFSMonitor_Test      |         |
      | $.HdfsCat2..name                 | SC3_CreateDir          |         |
      | $.HdfsCat2..tags[*]              | SC3_CreateDir          |         |
      | $.HdfsCat2..filter..tags[*]      | Fileshouldnotavailable |         |
      | $.HdfsCat2..autoStart            | false                  | boolean |
      | $.HdfsCat2..analyzeCollectedData | false                  | boolean |

  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC9#-MLP_24889_verify HDFS monitor trigger only the appropriate cataloger when Multiple Hdfs cataloger are configured with Hdfs monitor pointing to Hdfscataloger with valid filter config (Reanme the same filter hdfs filter item in Ambari)
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | bodyFile                                                                         | path       | response code | response message | jsonPath                                           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsCataloger/SC2_CreateDir                                   | payloads/ida/hdfsPayloads/Monitor/SC1_new_Hdfs_Cataloger_Configuration_dual.json | $.HdfsCat1 | 204           |                  |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsCataloger/SC2_CreateDir                                   |                                                                                  |            | 200           | SC2_CreateDir    |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsCataloger/SC3_CreateDir                                   | payloads/ida/hdfsPayloads/Monitor/SC1_new_Hdfs_Cataloger_Configuration_dual.json | $.HdfsCat2 | 204           |                  |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsCataloger/SC3_CreateDir                                   |                                                                                  |            | 200           | SC3_CreateDir    |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC2_CreateDir |                                                                                  |            | 200           | IDLE             | $.[?(@.configurationName=='SC2_CreateDir')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC2_CreateDir  |                                                                                  |            | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC2_CreateDir |                                                                                  |            | 200           | IDLE             | $.[?(@.configurationName=='SC2_CreateDir')].status |

  Scenario Outline: SC9 MLP_24889_Verify the cataloger collected all the fiels and directory in first run (manual Trigger)
    And user update the json file "ida/hdfsPayloads/API/SC2_Filter.json" file for following values
      | jsonPath                                                | jsonValues                                  |
      | $..selections.['asg.tagPathsHierarchy_ss'][*]           | SC2_CreateDir                               |
      | $..selections.['asg.parentTypeNamePathHierarchy_ss'][*] | Cluster/Sandbox/Service/HDFS/Directory/ROOT |
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                       | body                                          | response code | response message | filePath                                          | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | components/itemlist?query=SC2_CreateDir&limitFacet=10&offset=0&limit=2500 | payloads/ida/hdfsPayloads/API/SC2_Filter.json | 200           |                  | response\HDFS\TableFilter\Actual\SC13_Filter.json |          |

  @MLP-24048  @sanity @positive
  Scenario Outline: SC#9 MLP_24889_Compare the tables with respect to filters (Manual Trigger)
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                     | actualValues                                      | valueType         | expectedJsonPath            | actualJsonPath                   |
      | response\HDFS\TableFilter\Expected\SC1_Filter.json | response\HDFS\TableFilter\Actual\SC13_Filter.json | stringListCompare | $.SC10.Directory.name       | $..[?(@.type=='Directory')].name |
      | response\HDFS\TableFilter\Expected\SC1_Filter.json | response\HDFS\TableFilter\Actual\SC13_Filter.json | stringListCompare | $.SC10.Directory.files.name | $..[?(@.type=='File')].name      |


  @MLP-1960 @positve @hdfs @regression @sanity
  Scenario Outline: SC9#Upload a new empty directory in Ambari
    When configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                 | body | response code | response message |
      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | HDFSMonitor_Test/NewFolder2?op=MKDIRS&recursive=true&overwrite=true |      | 200           |                  |

  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC9#-MLP_24889_Wait for Delta time and check if the Cataloger ran successfully
    And sync the test execution for "30" seconds
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | body | response code | response message | jsonPath                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC2_CreateDir |      | 200           | IDLE             | $.[?(@.configurationName=='SC2_CreateDir')].status |


  @webtest @MLP-24329
  Scenario: SC9 verify HDFS monitor trigger only the appropriate cataloger when Multiple Hdfs cataloger are configured with Hdfs monitor pointing to Hdfscataloger with valid filter config (Add Directory in Ambari).
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HDFSMonitor_Test" and clicks on search
    And user performs "facet selection" in "SC2_CreateDir" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "HDFSMonitor_Test" item from search results
    Then user performs click and verify in new window
      | Table         | value                        | Action                 | RetainPrevwindow | indexSwitch |
      | has_Directory | NewFolder1                   | click and switch tab   | No               |             |
      | Files         | userdata1.parquet            | verify widget contains | No               |             |
      | Files         | hdfs (1).zip                 | verify widget contains | No               | 0           |
      | has_Directory | NewFolder                    | click and switch tab   | No               |             |
      | Files         | uploadFile1.csv              | verify widget contains | No               |             |
      | Files         | dummy.pdf                    | verify widget contains | No               |             |
      | has_Directory | Sub-Dir                      | click and switch tab   | No               |             |
      | Files         | CALC-1985.doc                | verify widget contains | No               |             |
      | Files         | insert_cycling_cassandra.txt | verify widget contains | No               | 1           |
      | has_Directory | NewFolder2                   | verify widget contains | No               |             |

    ###########################################################Second Config didn't collected any Items ##################################

  @webtest @MLP-24329
  Scenario: SC10 MLP_24889_Verify the cataloger doesn't collect any Metadata items
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC3_CreateDir" and clicks on search
    Then user verify "non presence of facets" with following values under "Metadata Type" section in item search results page
      | Directory |
      | File      |
      | Analysis  |


  Scenario:SC10#:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                    | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/SC2_CreateDir/% | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/SC3_CreateDir/% | Analysis |       |       |
      | MultipleIDDelete | Default | monitor/HdfsMonitor/HdfsMonitor/%       | Analysis |       |       |
      | SingleItemDelete | Default | Cluster Demo                            | Cluster  |       |       |
      | SingleItemDelete | Default | Sandbox                                 | Cluster  |       |       |


  ####################################Multiple Monitor and Multiple Cataloger############################################


  @MLP-1960 @positve @hdfs @regression @sanity
  Scenario Outline:SC#11Creating a New Sub-Directory directory in Ambari Files View and Uploading a file into the directory
    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                                                                                                               | body                                                  | response code | response message |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | HDFSMonitor_Test1/NewFolder/subfile1.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/hdfsPayloads/TestData/HdfsAutomationTestData1.csv | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | HDFSMonitor_Test2/NewFolder/subfile2.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/hdfsPayloads/TestData/HdfsAutomationTestData1.csv | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | HDFSMonitor_Test3/NewFolder/subfile3.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/hdfsPayloads/TestData/HdfsAutomationTestData1.csv | 201           |                  |

  Scenario: SC11#-MLP_24889_Update the Host name respect to the docker
    And user "update" the json file "ida/hdfsPayloads/Monitor/SC1_new_Hdfs_Cataloger_Configuration_dual.json" file for following values
      | jsonPath                    | jsonValues           | type    |
      | $.HdfsCat3..nodeCondition   | name=="Cluster Demo" |         |
      | $.HdfsCat3..filter..root    | /HDFSMonitor_Test1   |         |
      | $.HdfsCat3..name            | SC4_CreateDir        |         |
      | $.HdfsCat3..tags[*]         | SC4_CreateDir        |         |
      | $.HdfsCat3..filter..tags[*] | Filter4              |         |
      | $.HdfsCat3..autoStart       | false                | boolean |
      | $.HdfsCat4..nodeCondition   | name=="Cluster Demo" |         |
      | $.HdfsCat4..filter..root    | /HDFSMonitor_Test2   |         |
      | $.HdfsCat4..name            | SC5_CreateDir        |         |
      | $.HdfsCat4..tags[*]         | SC5_CreateDir        |         |
      | $.HdfsCat4..filter..tags[*] | Filter5              |         |
      | $.HdfsCat4..autoStart       | false                | boolean |
      | $.HdfsCat5..nodeCondition   | name=="Cluster Demo" |         |
      | $.HdfsCat5..filter..root    | /HDFSMonitor_Test3   |         |
      | $.HdfsCat5..name            | SC6_CreateDir        |         |
      | $.HdfsCat5..tags[*]         | SC6_CreateDir        |         |
      | $.HdfsCat5..filter..tags[*] | Filter6              |         |
      | $.HdfsCat5..autoStart       | false                | boolean |

  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC11#-MLP_24889_set HDFS data source with cluter resolve name TRUE and run Hdfs cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                               | body                                                         | response code | response message     | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/license                  | ida\hbasePayloads\DataSource\license_DS.json                 | 204           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/HdfsDataSource | ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig.json | 204           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/HdfsDataSource |                                                              | 200           | HDFSDataSource_valid |          |

  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC11#-MLP_24889_verify HDFS monitor trigger only the appropriate cataloger when Multiple Hdfs cataloger are configured with Hdfs monitor pointing to Hdfscataloger with valid filter config (Reanme the same filter hdfs filter item in Ambari)
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | bodyFile                                                                         | path       | response code | response message | jsonPath                                           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsCataloger/SC4_CreateDir                                   | payloads/ida/hdfsPayloads/Monitor/SC1_new_Hdfs_Cataloger_Configuration_dual.json | $.HdfsCat3 | 204           |                  |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsCataloger/SC4_CreateDir                                   |                                                                                  |            | 200           | SC4_CreateDir    |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsCataloger/SC5_CreateDir                                   | payloads/ida/hdfsPayloads/Monitor/SC1_new_Hdfs_Cataloger_Configuration_dual.json | $.HdfsCat4 | 204           |                  |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsCataloger/SC5_CreateDir                                   |                                                                                  |            | 200           | SC5_CreateDir    |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsCataloger/SC6_CreateDir                                   | payloads/ida/hdfsPayloads/Monitor/SC1_new_Hdfs_Cataloger_Configuration_dual.json | $.HdfsCat5 | 204           |                  |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsCataloger/SC6_CreateDir                                   |                                                                                  |            | 200           | SC6_CreateDir    |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC4_CreateDir |                                                                                  |            | 200           | IDLE             | $.[?(@.configurationName=='SC4_CreateDir')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC4_CreateDir  |                                                                                  |            | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC4_CreateDir |                                                                                  |            | 200           | IDLE             | $.[?(@.configurationName=='SC4_CreateDir')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC5_CreateDir |                                                                                  |            | 200           | IDLE             | $.[?(@.configurationName=='SC5_CreateDir')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC5_CreateDir  |                                                                                  |            | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC5_CreateDir |                                                                                  |            | 200           | IDLE             | $.[?(@.configurationName=='SC5_CreateDir')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC6_CreateDir |                                                                                  |            | 200           | IDLE             | $.[?(@.configurationName=='SC6_CreateDir')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC6_CreateDir  |                                                                                  |            | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC6_CreateDir |                                                                                  |            | 200           | IDLE             | $.[?(@.configurationName=='SC6_CreateDir')].status |

  Scenario: SC11#-MLP_24889_Update the Catalog name in HDFS Monitor config
    And user "update" the json file "ida/hdfsPayloads/Monitor/SC1_new_Hdfs_Monitor_Configuration_dual.json" file for following values
      | jsonPath                               | jsonValues    | type |
      | $.Monitor1..catalogerConfigurationName | SC4_CreateDir |      |
      | $.Monitor1..name                       | HdfsMonitor4  |      |
      | $.Monitor2..catalogerConfigurationName | SC5_CreateDir |      |
      | $.Monitor2..name                       | HdfsMonitor5  |      |
      | $.Monitor3..catalogerConfigurationName | SC6_CreateDir |      |
      | $.Monitor3..name                       | HdfsMonitor6  |      |


  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC11#-MLP_24889_set HDFS Monitor and run (Multiple monitor)
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                        | bodyFile                                                                       | path       | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/HdfsMonitor/HdfsMonitor4                                | payloads/ida/hdfsPayloads/Monitor/SC1_new_Hdfs_Monitor_Configuration_dual.json | $.Monitor1 | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/HdfsMonitor/HdfsMonitor4                                |                                                                                |            | 200           | HdfsMonitor4     |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/HdfsMonitor/HdfsMonitor5                                | payloads/ida/hdfsPayloads/Monitor/SC1_new_Hdfs_Monitor_Configuration_dual.json | $.Monitor2 | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/HdfsMonitor/HdfsMonitor5                                |                                                                                |            | 200           | HdfsMonitor5     |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/HdfsMonitor/HdfsMonitor6                                | payloads/ida/hdfsPayloads/Monitor/SC1_new_Hdfs_Monitor_Configuration_dual.json | $.Monitor3 | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/HdfsMonitor/HdfsMonitor6                                |                                                                                |            | 200           | HdfsMonitor6     |          |
      | IDC         | TestSystemUser | application/json |       |       | Post | extensions/analyzers/start/Cluster%20Demo/monitor/HdfsMonitor/HdfsMonitor4 |                                                                                |            | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Post | extensions/analyzers/start/Cluster%20Demo/monitor/HdfsMonitor/HdfsMonitor5 |                                                                                |            | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Post | extensions/analyzers/start/Cluster%20Demo/monitor/HdfsMonitor/HdfsMonitor6 |                                                                                |            | 200           |                  |          |


  @MLP-1960 @positve @hdfs @regression @sanity
  Scenario Outline: SC#11Renaming the already created file in the existing directory
    Given sync the test execution for "30" seconds
    When configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                                                      | body | response code | response message |
      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | HDFSMonitor_Test2/NewFolder?user.name=raj_ops&op=RENAME&destination=/HDFSMonitor_Test2/NewFolder_Renamed |      | 200           | true             |

  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC11#-MLP_24889_Verify whether two cataloger are triggered automatically
    And sync the test execution for "30" seconds
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | body | response code | response message | jsonPath                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC4_CreateDir |      | 200           | IDLE             | $.[?(@.configurationName=='SC4_CreateDir')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC5_CreateDir |      | 200           | IDLE             | $.[?(@.configurationName=='SC5_CreateDir')].status |

  @webtest @MLP-24329
  Scenario: SC11 verify HDFS monitor trigger only the appropriate cataloger when Multiple Hdfs cataloger are configured with Hdfs monitor pointing to Hdfscataloger with valid filter config (Add Directory in Ambari).
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC5_CreateDir" and clicks on search
    And user performs "facet selection" in "SC5_CreateDir" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "HDFSMonitor_Test2" item from search results
    Then user performs click and verify in new window
      | Table         | value             | Action                 | RetainPrevwindow | indexSwitch |
      | has_Directory | NewFolder         | verify widget contains | No               |             |
      | has_Directory | NewFolder_Renamed | verify widget contains | No               |             |

  Scenario:SC11#:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/%      | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/AvroAnalyzer/%    | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/CsvAnalyzer/%     | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/ParquetAnalyzer/% | Analysis |       |       |
      | MultipleIDDelete | Default | monitor/HdfsMonitor/%          | Analysis |       |       |
      | SingleItemDelete | Default | Cluster Demo                   | Cluster  |       |       |
      | SingleItemDelete | Default | Sandbox                        | Cluster  |       |       |

    ########################################################File Analyzer run Auto Trigger######################################################################################


  Scenario: SC12#-MLP_24889_Update the Catalog name in HDFS Monitor config
    And user "update" the json file "ida/hdfsPayloads/Monitor/SC1_new_Hdfs_Monitor_Configuration.json" file for following values
      | jsonPath                                     | jsonValues    | type |
      | $.configurations..catalogerConfigurationName | SC7_CreateDir |      |

  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC12#-MLP_24889_set HDFS Monitor and run
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                            | body                                                             | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/HdfsMonitor | ida/hdfsPayloads/Monitor/SC1_new_Hdfs_Monitor_Configuration.json | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/HdfsMonitor |                                                                  | 200           | HdfsMonitor      |          |

  @MLP-1960 @positve @hdfs @regression @sanity
  Scenario Outline:SC#12Creating a new directory in existing folder
    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                                                                                                                           | body                                                          | response code | response message |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | AutoTrigger/CSV/cityFile1.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                        | ida/hdfsPayloads/TestData/cityFile1.csv                       | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | AutoTrigger/Avro/userDiffDataTypes.avro?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true              | ida/hdfsPayloads/TestData/userDiffDataTypes.avro              | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | AutoTrigger/Parquet/userDiffDataTypesParquet.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/parquetPayloads/TestData/userDiffDataTypesParquet.parquet | 201           |                  |


  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC12#-MLP_24889_set HDFS File Analyzers
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                | bodyFile                                                                             | path      | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/ParquetAnalyzer/ParquetAnalyzer | payloads/ida/hdfsPayloads/Monitor/SC1_new_Hdfs_FileAnalyzers_Configuration_dual.json | $.PARQUET | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/ParquetAnalyzer/ParquetAnalyzer |                                                                                      |           | 200           | ParquetAnalyzer  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CsvAnalyzer/CsvAnalyzer         | payloads/ida/hdfsPayloads/Monitor/SC1_new_Hdfs_FileAnalyzers_Configuration_dual.json | $.CSV     | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CsvAnalyzer/CsvAnalyzer         |                                                                                      |           | 200           | CsvAnalyzer      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/AvroAnalyzer/AvroAnalyzer       | payloads/ida/hdfsPayloads/Monitor/SC1_new_Hdfs_FileAnalyzers_Configuration_dual.json | $.AVRO    | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/AvroAnalyzer/AvroAnalyzer       |                                                                                      |           | 200           | AvroAnalyzer     |          |


  Scenario: SC12#-MLP_24889_Update the Host name respect to the docker
    And user "update" the json file "ida/hdfsPayloads/Monitor/SC1_new_Hdfs_Cataloger_Configuration.json" file for following values
      | jsonPath                               | jsonValues            | type    |
      | $.configurations..nodeCondition        | name=="Cluster Demo"  |         |
      | $.configurations..filter..root         | /AutoTrigger          |         |
      | $.configurations..name                 | SC7_CreateDir         |         |
      | $.configurations..tags[*]              | SC7_CreateDir         |         |
      | $.configurations..filter..tags[*]      | Three extension files |         |
      | $.configurations..autoStart            | false                 | boolean |
      | $.configurations..analyzeCollectedData | true                  | boolean |


  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC12#-MLP_24889_set HDFS data source with cluter resolve name TRUE and run Hdfs cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | body                                                               | response code | response message     | jsonPath                                           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/license                                                                 | ida\hbasePayloads\DataSource\license_DS.json                       | 204           |                      |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsDataSource                                                | ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig.json       | 204           |                      |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsDataSource                                                |                                                                    | 200           | HDFSDataSource_valid |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsCataloger                                                 | ida/hdfsPayloads/Monitor/SC1_new_Hdfs_Cataloger_Configuration.json | 204           |                      |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsCataloger                                                 |                                                                    | 200           | SC7_CreateDir        |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC7_CreateDir |                                                                    | 200           | IDLE                 | $.[?(@.configurationName=='SC7_CreateDir')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC7_CreateDir  |                                                                    | 200           |                      |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC7_CreateDir |                                                                    | 200           | IDLE                 | $.[?(@.configurationName=='SC7_CreateDir')].status |


  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC12#-MLP_24889_Check if the File Analyzers are completed
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | body | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/ParquetAnalyzer |      | 200           | IDLE             | $.[?(@.configurationName=='ParquetAnalyzer')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/CsvAnalyzer/CsvAnalyzer         |      | 200           | IDLE             | $.[?(@.configurationName=='CsvAnalyzer')].status     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/AvroAnalyzer/AvroAnalyzer       |      | 200           | IDLE             | $.[?(@.configurationName=='AvroAnalyzer')].status    |

  @webtest
  Scenario: SC#12 Verify Data Profiling happened for all the files(CSV,AVRO,PARQUET) post File Analayzer run
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1_CsvAnalyzer" and clicks on search
    And user performs "definite facet selection" in "SC1_CsvAnalyzer" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "AutoTrigger [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "AutoTrigger" item from search results
    Then user performs click and verify in new window
      | Table         | value         | Action               | RetainPrevwindow | indexSwitch |
      | has_Directory | CSV           | click and switch tab | No               |             |
      | Files         | cityFile1.csv | click and switch tab | No               |             |
      | Fields        | _c5           | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | Last Analyzed At | Lifecycle |
    And user navigates to the index "2" to perform actions
    Then user performs click and verify in new window
      | Table         | value                            | Action               | RetainPrevwindow | indexSwitch |
      | has_Directory | Parquet                          | click and switch tab | No               |             |
      | Files         | userDiffDataTypesParquet.parquet | click and switch tab | No               |             |
      | Fields        | age                              | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | Last Analyzed At | Lifecycle |
    And user navigates to the index "2" to perform actions
    Then user performs click and verify in new window
      | Table         | value                  | Action               | RetainPrevwindow | indexSwitch |
      | has_Directory | Avro                   | click and switch tab | No               |             |
      | Files         | userDiffDataTypes.avro | click and switch tab | No               |             |
      | Fields        | phone                  | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | Last Analyzed At | Lifecycle |

  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC12#-MLP_24889_Stop HDFS monitor
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                        | body | response code | response message | jsonPath                                         |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/stop/Cluster%20Demo/monitor/HdfsMonitor/HdfsMonitor   |      | 204           |                  |                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/monitor/HdfsMonitor/HdfsMonitor |      | 200           | IDLE             | $.[?(@.configurationName=='HdfsMonitor')].status |

      ############################################################Log Enhancemnt #################################################################################

   #7152592
  #Bug-ID-26015
  @sanity @positive @webtest @MLP-24889 @IDA-1.1.0
  Scenario:CommonCase:MLP_24889_Verify the Processed Items widget presence and Logging Enhancement validation
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Hadoop Files" and clicks on search
    And user performs "facet selection" in "Hadoop Files" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "monitor/HdfsMonitor/HdfsMonitor/%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 0             |
      | Number of errors          | 0             |
    Then Analysis log "monitor/HdfsMonitor/HdfsMonitor/%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | logCode       | pluginName  | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | ANALYSIS-0019 |             |                |
      | INFO | ANALYSIS-0071: Plugin Name:HdfsMonitor, Plugin Type:monitor, Plugin Version:1.1.0.SNAPSHOT, Node Name:Cluster Demo, Host Name:sandbox.hortonworks.com, Plugin Configuration name:HdfsMonitor                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | ANALYSIS-0071 | HdfsMonitor | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin HdfsMonitor Configuration: ---  2020-08-27 17:47:52.792 INFO  - ANALYSIS-0073: Plugin HdfsMonitor Configuration: name: "HdfsMonitor"  2020-08-27 17:47:52.792 INFO  - ANALYSIS-0073: Plugin HdfsMonitor Configuration: pluginVersion: "LATEST"  2020-08-27 17:47:52.793 INFO  - ANALYSIS-0073: Plugin HdfsMonitor Configuration: label:  2020-08-27 17:47:52.793 INFO  - ANALYSIS-0073: Plugin HdfsMonitor Configuration: : ""  2020-08-27 17:47:52.793 INFO  - ANALYSIS-0073: Plugin HdfsMonitor Configuration: catalogName: "Default"  2020-08-27 17:47:52.793 INFO  - ANALYSIS-0073: Plugin HdfsMonitor Configuration: autoStart: true  2020-08-27 17:47:52.793 INFO  - ANALYSIS-0073: Plugin HdfsMonitor Configuration: eventClass: null  2020-08-27 17:47:52.793 INFO  - ANALYSIS-0073: Plugin HdfsMonitor Configuration: eventCondition: null  2020-08-27 17:47:52.794 INFO  - ANALYSIS-0073: Plugin HdfsMonitor Configuration: nodeCondition: "name==\"Cluster Demo\""  2020-08-27 17:47:52.794 INFO  - ANALYSIS-0073: Plugin HdfsMonitor Configuration: maxWorkSize: 100  2020-08-27 17:47:52.794 INFO  - ANALYSIS-0073: Plugin HdfsMonitor Configuration: tags: []  2020-08-27 17:47:52.794 INFO  - ANALYSIS-0073: Plugin HdfsMonitor Configuration: pluginType: "monitor"  2020-08-27 17:47:52.794 INFO  - ANALYSIS-0073: Plugin HdfsMonitor Configuration: dataSource: null  2020-08-27 17:47:52.795 INFO  - ANALYSIS-0073: Plugin HdfsMonitor Configuration: credential: null  2020-08-27 17:47:52.795 INFO  - ANALYSIS-0073: Plugin HdfsMonitor Configuration: businessApplicationName: hdfsmonitorba  2020-08-27 17:47:52.795 INFO  - ANALYSIS-0073: Plugin HdfsMonitor Configuration: dryRun: false  2020-08-27 17:47:52.795 INFO  - ANALYSIS-0073: Plugin HdfsMonitor Configuration: schedule: null  2020-08-27 17:47:52.795 INFO  - ANALYSIS-0073: Plugin HdfsMonitor Configuration: filter: null  2020-08-27 17:47:52.795 INFO  - ANALYSIS-0073: Plugin HdfsMonitor Configuration: catalogerConfigurationName: "SC7_CreateDir"  2020-08-27 17:47:52.796 INFO  - ANALYSIS-0073: Plugin HdfsMonitor Configuration: pluginName: "HdfsMonitor"  2020-08-27 17:47:52.796 INFO  - ANALYSIS-0073: Plugin HdfsMonitor Configuration: type: "monitor" | ANALYSIS-0073 | HdfsMonitor |                |
      | INFO | ANALYSIS-0072: Plugin HdfsMonitor Start Time:2020-08-27 17:47:52.790, End Time:2020-08-27 17:48:18.933, Processed Count:0, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | ANALYSIS-0072 | HdfsMonitor |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:01:55.385)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | ANALYSIS-0020 |             |                |

  Scenario:SC12#:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                    | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/SC4_CreateDir/% | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/SC5_CreateDir/% | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/SC6_CreateDir/% | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/%               | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/AvroAnalyzer/%             | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/CsvAnalyzer/%              | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/ParquetAnalyzer/%          | Analysis |       |       |
      | MultipleIDDelete | Default | monitor/HdfsMonitor/%                   | Analysis |       |       |
      | SingleItemDelete | Default | Cluster Demo                            | Cluster  |       |       |
      | SingleItemDelete | Default | Sandbox                                 | Cluster  |       |       |


    ###################################Delete Folder in Amabri , Config and BA in DD UI

  @MLP-1960  @MLP-1960 @positve @hdfs @regression @sanity
  Scenario Outline:SC13:Delete folder in Ambaris
    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization               | X-Requested-By | type   | url                                         | body | response code | response message |
      | HdfsNameNode | Basic cmFq X29wczpyYWpfb3Bz | ambari         | Delete | /AutoTrigger?op=DELETE&recursive=true       |      | 200           | true             |
      | HdfsNameNode | Basic cmFq X29wczpyYWpfb3Bz | ambari         | Delete | /HDFSMonitor_Test?op=DELETE&recursive=true  |      | 200           | true             |
      | HdfsNameNode | Basic cmFq X29wczpyYWpfb3Bz | ambari         | Delete | /HDFSMonitor_Test1?op=DELETE&recursive=true |      | 200           | true             |
      | HdfsNameNode | Basic cmFq X29wczpyYWpfb3Bz | ambari         | Delete | /HDFSMonitor_Test2?op=DELETE&recursive=true |      | 200           | true             |
      | HdfsNameNode | Basic cmFq X29wczpyYWpfb3Bz | ambari         | Delete | /HDFSMonitor_Test3?op=DELETE&recursive=true |      | 200           | true             |

  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline:SC14:MLP-24889:Deleting the Credentials
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                        | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/hdfsDBValidCredential |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CsvAnalyzer             |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AvroAnalyzer            |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ParquetAnalyzer         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/HdfsCataloger           |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/HdfsMonitor             |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/HdfsDataSource          |      | 204           |                  |          |


  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario:SC16:Delete Bussiness Application
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name            | type                | query | param |
      | SingleItemDelete | Default | HDFS_BA         | BusinessApplication |       |       |
      | SingleItemDelete | Default | HDFS_MONITOR_BA | BusinessApplication |       |       |
