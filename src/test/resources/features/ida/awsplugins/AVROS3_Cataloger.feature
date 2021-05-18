@MLP-14874 @MLP-8708
Feature:Support for S3 AVRO Cataloger

  ##############################################################################PRECONDITION##################################################################################

  @aws @precondition
  Scenario: Update AWS secret key and access from config file
    Given User update the below "S3 Readonly credentials" in following files using json path
      | filePath                                                   | accessKeyPath | secretKeyPath |
      | ida/s3AvroPayloads/Credentials/avroS3ValidCredentials.json | $..accessKey  | $..secretKey  |

  @cr-data @sanity @positive
  Scenario Outline: SC#1 Set the Credentials for Avro S3 Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                           | body                                                         | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/license                              | ida\hbasePayloads\DataSource\license_DS.json                 | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/ValidAVROCredentials     | ida/s3AvroPayloads/Credentials/avroS3ValidCredentials.json   | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/IncorrectAVROCredentials | ida/s3AvroPayloads/Credentials/avroS3InValidCredentials.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/EmptyAVROCredentials     | ida/s3AvroPayloads/Credentials/avroS3EmptyCredentials.json   | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/ValidAVROCredentials     |                                                              | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/IncorrectAVROCredentials |                                                              | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/EmptyAVROCredentials     |                                                              | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/EDIBusValidCredentials   | idc/EdiBusPayloads/credentials/EDIBusValidCredentials.json   | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/EDIBusValidCredentials   |                                                              | 200           |                  |          |



   ##############################################################################UI VALIDATION##################################################################################

  @MLP-14874 @webtest
  Scenario: SC#1.1 Verify whether the background of the panel is displayed in green when test connection is successful for AvroS3DataSource in LocalNode
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data Sources Page"
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute        |
      | Data Source Type | AvroS3DataSource |
    And user should scroll to the left of the screen
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*       |
      | Label       |
      | Region*     |
      | Credential* |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute            |
      | Name*     | AvroS3DataSourceTest |
      | Label     | AvroS3DataSourceTest |
    And user "select dropdown" in Add Data Source Page
      | fieldName   | attribute                         |
      | Region      | US East (N. Virginia) [us-east-1] |
      | Credential* | ValidAVROCredentials              |
      | Node        | LocalNode                         |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Successful datasource connection" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"
    And user "click" on "Save" button in "Add Data Sources Page"

#  @MLP-14874 @webtest
#  Scenario: SC#3_1-Verify whether the background of the panel is displayed in green when test connection is successful for AvroS3DataSource in GoogleCloud node
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user performs following actions in the sidebar
#      | actionType  | actionItem          |
#      | mouse hover | Settings Icon       |
#      | click       | Settings Icon       |
#      | click       | Manage Data Sources |
#    And user "click" on "Add Data Source" button in Manage Data Sources
#    And user "select dropdown" in Add Configuration Page in Manage Configurations
#      | fieldName        | attribute        |
#      | Data Source Type | AvroS3DataSource |
#    And user should scroll to the left of the screen
#    Then user "Verify the presnce of captions" in Plugin Configuration page
#      | Name           |
#      | Plugin Version |
#      | Label          |
#      | Region         |
#      | Credential     |
#    And user "enter text" in Add Data Source Page
#      | fieldName | attribute              |
#      | Name      | AvroS3DataSourceTestGC |
#      | Label     | AvroS3DataSourceTestGC |
#    And user "select dropdown" in Add Data Source Page
#      | fieldName      | attribute                         |
#      | Plugin Version | LATEST                            |
#      | Region         | US East (N. Virginia) [us-east-1] |
#      | Credential     | ValidAVROCredentials              |
#      | Deployment     | GoogleCloud                       |
#    And user "click" on "Test Connection" button in "Add Data Sources pop up"
#    And user verifies "Successful datasource connection" is "displayed" in "Step1 Add Data Source pop up"
#    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"
#    And user "click" on "Save" button in "Add Data Sources Page"

  @MLP-14874 @webtest
  Scenario: SC#1.1 Verify whether the background of the panel is displayed in red when test connection is not successful for AvroS3DataSource in LocalNode
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data Sources Page"
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute        |
      | Data Source Type | AvroS3DataSource |
    And user should scroll to the left of the screen
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*       |
      | Label       |
      | Region*     |
      | Credential* |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute             |
      | Name*     | AvroS3DataSourceTest2 |
      | Label     | AvroS3DataSourceTest2 |
    And user "select dropdown" in Add Data Source Page
      | fieldName   | attribute                         |
      | Region*     | US East (N. Virginia) [us-east-1] |
      | Credential* | IncorrectAVROCredentials          |
      | Node        | LocalNode                         |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute            |
      | Credential | EmptyAVROCredentials |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"

  ##############################################################################UI VALIDATION AFTER PLUGIN RUN ###################################################################################

  @cr-data @sanity @positive
  Scenario: SC#2 Set the Avro S3 Datasource
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                 | body                                                           | response code | response message      | jsonPath |
      | application/json | raw   | false | Put  | settings/analyzers/AvroS3DataSource | ida/s3AvroPayloads/DataSource/AvroS3ValidDataSourceConfig.json | 204           |                       |          |
      |                  |       |       | Get  | settings/analyzers/AvroS3DataSource |                                                                | 200           | AvroS3ValidDataSource |          |

  @sanity @positive @regression
  Scenario Outline: SC#2 Create BusinessApplication tag and run the plugin configuration with the new field for Avro S3
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                              | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/s3AvroPayloads/AvroS3BusinessApplication.json | 200           |                  |          |

  @aws
  Scenario: MLP-8708:SC#2 Create a bucket and folder with various file formats in S3 Amazon storage
    Given user "Create" a bucket "avroasgqatestautomation1" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName               | keyPrefix    | dirPath                      | recursive |
      | avroasgqatestautomation1 | AutoTestData | ida/s3AvroPayloads/TestData/ | true      |

  @cr-data @sanity @positive
  Scenario Outline:MLP-8708:SC#2 Run the Plugin configurations of AvroS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                               | body                                                        | response code | response message | jsonPath                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Cataloger                                | ida/s3AvroPayloads/PluginConfiguration/sc1AvroS3Config.json | 204           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Cataloger                                |                                                             | 200           | AvroS3Catalog    |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                             | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Catalog')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/*  | ida/s3AvroPayloads/PluginConfiguration/empty.json           | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                             | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Catalog')].status |


  Scenario: ProcessedCount Verification for AvroS3 cataloger with no filters
    Given Load the count of the type values to a Map
      | analysis                                | type      | DBName | queryName | queryPage | actualcount |
      | cataloger/AvroS3Cataloger/AvroS3Catalog | Analysis  |        |           |           | 1           |
      | cataloger/AvroS3Cataloger/AvroS3Catalog | Cluster   |        |           |           | 1           |
      | cataloger/AvroS3Cataloger/AvroS3Catalog | Service   |        |           |           | 1           |
      | cataloger/AvroS3Cataloger/AvroS3Catalog | Directory |        |           |           | 5           |
      | cataloger/AvroS3Cataloger/AvroS3Catalog | File      |        |           |           | 8           |
      | cataloger/AvroS3Cataloger/AvroS3Catalog | Field     |        |           |           | 6           |
    Given Verify the Processed Count with the API call
      | Action                    | type      | node      | configName    | analysisItemName                        |
      | ItemViewMap               | Analysis  |           |               | cataloger/AvroS3Cataloger/AvroS3Catalog |
      | ItemViewMap               | Cluster   |           |               |                                         |
      | ItemViewMap               | Service   |           |               |                                         |
      | ItemViewMap               | Directory |           |               |                                         |
      | ItemViewMap               | File      |           |               |                                         |
      | ItemViewMap               | Field     |           |               |                                         |
      | VerifyCountInItemView     |           |           |               |                                         |
      | VerifyCountInPluginConfig |           | LocalNode | AvroS3Catalog |                                         |

  @MLP-8708 @webtest @aws @regression @sanity @IDA-10.0 @MLPQA-18062 @MLPQA-18064 @MLPQA-12097
  Scenario: MLP-8708:SC#2 Verify Technology tag appears correctly in S3Cataloger cataloged items
    Given user gets amazon bucket "avroasgqatestautomation1" file count in "AutoTestData/TestAvro" directory and store in temp variable
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagSC1Avro" and clicks on search
    And user performs "facet selection" in "tagSC1Avro" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then results panel "file count" should be displayed as "tempStoredvalue" in Item Search results page
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name | facet         | Tag                                      | fileName      | userTag    |
      | Default     | File | Metadata Type | tagSC1Avro,Avro,test_BA_AvroS3,Amazon S3 | employee.avro | tagSC1Avro |

  @MLP-8708 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: SC#2 Verify the facet counts are exact once the Avro S3 items are cataloged.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagSC1Avro" and clicks on search
    And user performs "facet selection" in "tagSC1Avro" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Service   | 1     |
      | Cluster   | 1     |
      | Analysis  | 1     |
      | Directory | 5     |
      | File      | 8     |
      | Field     | 6     |

 ##############################################################################VALIDATING THE DATA IN METABILITY##################################################################################
    #6549303
#  @sanity @positive @webtest @edibus
#  Scenario: SC#2.1 MLP-9043_Verify the Avro S3 items are replicated to EDI
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "tagSC1Avro" and clicks on search
#    And user performs "facet selection" in "tagSC1Avro" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Avro" attribute under "Tags" facets in Item Search results page
#    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
#      | File      |
#      | Field     |
#      | Directory |
#      | Analysis  |
#      | Cluster   |
#      | Service   |
#    And user connects Rochade Server and "clears" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                      |
#      | AP-DATA      | S3AVRO      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
#    And user update json file "idc/EdiBusPayloads/AvroConfig.json" file for following values using property loader
#      | jsonPath                                           | jsonValues    |
#      | $..configurations[-1:].['EDI access'].['EDI host'] | EDIHostName   |
#      | $..configurations[-1:].['EDI access'].['EDI port'] | EDIPortNumber |
#    And configure a new REST API for the service "IDC"
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                             | body                                               | response code | response message | jsonPath                                        |
#      | application/json |       |       | Put          | settings/analyzers/EDIBusDataSource                             | idc/EdiBusPayloads/datasource/EDIBusDS_Avros3.json | 204           |                  |                                                 |
#      |                  |       |       | Put          | settings/analyzers/EDIBus                                       | idc/EdiBusPayloads/AvroConfig.json                 | 204           |                  |                                                 |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusAvro |                                                    | 200           | IDLE             | $.[?(@.configurationName=='EDIBusAvro')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusAvro  |                                                    | 200           |                  |                                                 |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusAvro |                                                    | 200           | IDLE             | $.[?(@.configurationName=='EDIBusAvro')].status |
#    And user enters the search text "EDIBusAvro" and clicks on search
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusAvro%"
#    Then the following metadata values should be displayed
#      | metaDataAttribute | metaDataValue | widgetName  |
#      | Number of errors  | 0             | Description |
#    And user enters the search text "tagSC1Avro" and clicks on search
#    And user performs "facet selection" in "tagSC1Avro" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Avro" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                 |
#      | AP-DATA      | S3AVRO      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                 |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Enterprise Data/Data Files/Avro |
#      | $..selections.['type_s'][*]                   | File                                       |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                       | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=tagSC1Avro&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                  |
#      | AP-DATA      | S3AVRO      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE ) |
#    And user enters the search text "tagSC1Avro" and clicks on search
#    And user performs "facet selection" in "tagSC1Avro" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Avro" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Directory" attribute under "Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                      |
#      | AP-DATA      | S3AVRO      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_DIRECTORY) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                 |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Enterprise Data/Data Files/Avro |
#      | $..selections.['type_s'][*]                   | Directory                                  |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                       | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=tagSC1Avro&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                       |
#      | AP-DATA      | S3AVRO      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_DIRECTORY ) |
#    And user enters the search text "tagSC1Avro" and clicks on search
#    And user performs "facet selection" in "tagSC1Avro" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Avro" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Service" attribute under "Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                        |
#      | AP-DATA      | S3AVRO      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE_SYSTEM) |
#    And user enters the search text "tagSC1Avro" and clicks on search
#    And user performs "facet selection" in "tagSC1Avro" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Avro" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Field" attribute under "Metadata Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                   |
#      | AP-DATA      | S3AVRO      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FIELD ) |
#    And user connects Rochade Server and "verify itemCount notNull" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                         |
#      | AP-DATA      | S3AVRO      | 1.0                | (XNAME * *  ~/ @*Avro≫DEFAULT≫DWR_DAT_FILE≫@* ) ,AND,( TYPE = DWR_IDC )       |
#      | AP-DATA      | S3AVRO      | 1.0                | (XNAME * *  ~/ @*Avro≫DEFAULT≫DWR_DAT_DIRECTORY≫@* ),AND,( TYPE = DWR_IDC )   |
#      | AP-DATA      | S3AVRO      | 1.0                | (XNAME * *  ~/ @*Avro≫DEFAULT≫DWR_DAT_FILE_SYSTEM≫@* ),AND,( TYPE = DWR_IDC ) |
#      | AP-DATA      | S3AVRO      | 1.0                | (XNAME * *  ~/ @*Avro≫DEFAULT≫DWR_DAT_FIELD≫@* ),AND,( TYPE = DWR_IDC )       |


  ##############################################################################UI VALIDATION WHEN BUCKET SET TO INCLUDE##################################################################################


  @MLP-8708 @webtest @aws @regression @sanity @IDA-10.0 @MLPQA-12106
  Scenario: MLP-8708:SC#3 Verify S3Cataloger collects Cluster,Service,Analysis,Directory,File when S3Cataloger is run with region and Bucketname(Include) and Directory(with /)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagSC1Avro" and clicks on search
    And user performs "facet selection" in "tagSC1Avro" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Type" section in item search results page
      | File      |
      | Directory |
      | Analysis  |
      | Cluster   |
      | Service   |
      | Field     |

  @MLP-8708 @webtest @aws @regression @sanity @IDA-10.0 @MLPQA-12096
  Scenario: MLP-8708:SC#3 Verify breadcrumb hierarchy appears correctly in S3Cataloger cataloged items
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "employee.avro" and clicks on search
    And user performs "facet selection" in "tagSC1Avro" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "employee.avro" item from search results
    Then user "verify presence" of following "breadcrumb" in Item View Page
      | amazonaws.com            |
      | AmazonS3                 |
      | avroasgqatestautomation1 |
      | AutoTestData             |
      | TestAvro                 |
      | employee.avro            |


  @MLP-8708 @webtest @aws @regression @sanity @IDA-10.0 @MLPQA-12099
  Scenario: MLP-8708:SC#3 Verify File level metadata appears correctly in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "twitter.avro" and clicks on search
    And user performs "facet selection" in "tagSC1Avro" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "twitter.avro" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Modified           | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                               | widgetName  |
      | File size         | 317.00 Bytes                                                | Description |
      | Location          | avroasgqatestautomation1/AutoTestData/TestAvro/twitter.avro | Description |
#    And user copy metadata value from Item View Page and write to file using below parameters
#      | itemName       | twitter.avro                               |
#      | attributeName  | Technical Data                             |
#      | actualFilePath | ida/s3AvroPayloads/actualFileTechData.json |
#    And user remove the json attribute from file for following parameters
#      | filePath                                     | attributeName |
#      | ida/s3AvroPayloads/actualFileTechData.json   | Last-Modified |
#      | ida/s3AvroPayloads/expectedFileTechData.json | Last-Modified |
#    Then file content in "ida/s3AvroPayloads/expectedFileTechData.json" should be same as the content in "ida/s3AvroPayloads/actualFileTechData.json"


  @MLP-8708 @webtest @aws @regression @sanity @IDA-10.0 @MLPQA-12100
  Scenario: SC#3 MLP-8708: Verify Directory/sub directory level metadata appears correctly in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "TestAvro" and clicks on search
    And user performs "facet selection" in "tagSC1Avro" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "TestAvro" item from search results
#    Then user "verify metadata properties" section has following values
#      | ID |
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue                                   | widgetName  |
      | Directory size            | 4482                                            | Statistics  |
      | Number of files           | 5                                               | Statistics  |
      | Size of files             | 4482                                            | Statistics  |
      | Location                  | avroasgqatestautomation1/AutoTestData/TestAvro/ | Description |
      | Number of sub-directories | 2                                               | Statistics  |
      | Size of sub-directories   | 2805                                            | Statistics  |
    And user enters the search text "AutoTestData" and clicks on search
    And user performs "facet selection" in "tagSC1Avro" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "AutoTestData" item from search results
#    Then user "verify metadata properties" section has following values
#      | ID |
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue                          | widgetName  |
      | Directory size            | 0                                      | Statistics  |
      | Number of files           | 0                                      | Statistics  |
      | Size of files             | 0                                      | Statistics  |
      | Location                  | avroasgqatestautomation1/AutoTestData/ | Description |
      | Number of sub-directories | 1                                      | Statistics  |
      | Size of sub-directories   | 7287                                   | Statistics  |


  @MLP-8708 @webtest @aws @regression @sanity @IDA-10.0 @MLPQA-12101
  Scenario: SC#3 MLP-8708:SC1#Verify Bucket level metadata appears correctly in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "avroasgqatestautomation1" and clicks on search
    And user performs "facet selection" in "tagSC1Avro" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "avroasgqatestautomation1" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue             | widgetName  |
      | Directory size            | 0                         | Statistics  |
      | Number of files           | 0                         | Statistics  |
      | Size of files             | 0                         | Statistics  |
      | Location                  | avroasgqatestautomation1/ | Description |
      | Number of sub-directories | 1                         | Statistics  |
      | Size of sub-directories   | 0                         | Statistics  |
#      | Type                      | Directory                 |
#    And user copy metadata value from Item View Page and write to file using below parameters
#      | itemName       | avroasgqatestautomation1                   |
#      | attributeName  | Technical Data                             |
#      | actualFilePath | ida/s3AvroPayloads/actualBuckTechData.json |
#    Then file content in "ida/s3AvroPayloads/expectedBuckTechData.json" should be same as the content in "ida/s3AvroPayloads/actualBuckTechData.json"


  @sanity @positive @MLP-7660 @webtest @IDA-10.0 @MLPQA-18062 @MLPQA-18064 @MLPQA-12097
  Scenario:SC#3 MLP-8708:Verify the technology tags got assigned to all S3Avro catalogued items like Cluster,Service,Database...etc
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name      | facet         | Tag                                      | fileName      | userTag       |
      | Default     | File      | Metadata Type | tagSC1Avro,Avro,test_BA_AvroS3,Amazon S3 | employee.avro | employee.avro |
      | Default     | Field     | Metadata Type | tagSC1Avro,Avro,test_BA_AvroS3,Amazon S3 | username      | username      |
      | Default     | Directory | Metadata Type | tagSC1Avro,Avro,test_BA_AvroS3,Amazon S3 | AvroInternal  | AvroInternal  |
      | Default     | Cluster   | Metadata Type | tagSC1Avro,Avro,test_BA_AvroS3,Amazon S3 | amazonaws.com | amazonaws.com |
      | Default     | Service   | Metadata Type | tagSC1Avro,Avro,test_BA_AvroS3,Amazon S3 | AmazonS3      | AmazonS3      |
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name    | facet         | Tag        | fileName      | userTag       |
      | Default     | Cluster | Metadata Type | Data Files | amazonaws.com | amazonaws.com |
      | Default     | Service | Metadata Type | Data Files | AmazonS3      | AmazonS3      |


  @sanity @positive @MLP-7660 @webtest @IDA-10.0
  Scenario:SC#3 MLP-8708:Verify AvroS3Cataloger collects Analysis item with proper log messages
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "cataloger/AvroS3Cataloger/AvroS3Catalog" and clicks on search
    And user performs "facet selection" in "tagSC1Avro" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/AvroS3Cataloger/AvroS3Catalog%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 22            | Description |
      | Number of errors          | 6             | Description |
    And user "verifies tab section values" has the following values in "Processed Items" Tab in Item View page
      | amazonaws.com |
      | AmazonS3      |
    Then Analysis log "cataloger/AvroS3Cataloger/AvroS3Catalog/%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | logCode       | pluginName      | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | ANALYSIS-0019 |                 |                |
      | INFO | Plugin Name:AvroS3Cataloger, Plugin Type:cataloger, Plugin Version:1.0.0.SNAPSHOT, Node Name:LocalNode, Host Name:8e6973ae6007, Plugin Configuration name:AvroS3Catalog                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | ANALYSIS-0071 | AvroS3Cataloger | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin AvroS3Cataloger Configuration: ---  2021-04-05 12:34:10.294 INFO  - ANALYSIS-0073: Plugin AvroS3Cataloger Configuration: name: "AvroS3Catalog"  2021-04-05 12:34:10.294 INFO  - ANALYSIS-0073: Plugin AvroS3Cataloger Configuration: pluginVersion: "LATEST"  2021-04-05 12:34:10.294 INFO  - ANALYSIS-0073: Plugin AvroS3Cataloger Configuration: label:  2021-04-05 12:34:10.315 INFO  - ANALYSIS-0073: Plugin AvroS3Cataloger Configuration: : ""  2021-04-05 12:34:10.315 INFO  - ANALYSIS-0073: Plugin AvroS3Cataloger Configuration: auditFields:  2021-04-05 12:34:10.315 INFO  - ANALYSIS-0073: Plugin AvroS3Cataloger Configuration: createdBy: "TestSystem"  2021-04-05 12:34:10.315 INFO  - ANALYSIS-0073: Plugin AvroS3Cataloger Configuration: createdAt: "2021-04-05T12:33:54.011"  2021-04-05 12:34:10.315 INFO  - ANALYSIS-0073: Plugin AvroS3Cataloger Configuration: modifiedBy: "TestSystem"  2021-04-05 12:34:10.316 INFO  - ANALYSIS-0073: Plugin AvroS3Cataloger Configuration: modifiedAt: "2021-04-05T12:33:54.011"  2021-04-05 12:34:10.316 INFO  - ANALYSIS-0073: Plugin AvroS3Cataloger Configuration: catalogName: "Default"  2021-04-05 12:34:10.316 INFO  - ANALYSIS-0073: Plugin AvroS3Cataloger Configuration: eventClass: null  2021-04-05 12:34:10.316 INFO  - ANALYSIS-0073: Plugin AvroS3Cataloger Configuration: eventCondition: null  2021-04-05 12:34:10.316 INFO  - ANALYSIS-0073: Plugin AvroS3Cataloger Configuration: nodeCondition: null  2021-04-05 12:34:10.316 INFO  - ANALYSIS-0073: Plugin AvroS3Cataloger Configuration: maxWorkSize: 100  2021-04-05 12:34:10.316 INFO  - ANALYSIS-0073: Plugin AvroS3Cataloger Configuration: tags:  2021-04-05 12:34:10.316 INFO  - ANALYSIS-0073: Plugin AvroS3Cataloger Configuration: - "tagSC1Avro"  2021-04-05 12:34:10.316 INFO  - ANALYSIS-0073: Plugin AvroS3Cataloger Configuration: pluginType: "cataloger"  2021-04-05 12:34:10.316 INFO  - ANALYSIS-0073: Plugin AvroS3Cataloger Configuration: dataSource: "AvroS3ValidDataSource"  2021-04-05 12:34:10.316 INFO  - ANALYSIS-0073: Plugin AvroS3Cataloger Configuration: credential: "ValidAVROCredentials"  2021-04-05 12:34:10.316 INFO  - ANALYSIS-0073: Plugin AvroS3Cataloger Configuration: businessApplicationName: "test_BA_AvroS3"  2021-04-05 12:34:10.317 INFO  - ANALYSIS-0073: Plugin AvroS3Cataloger Configuration: schedule: null  2021-04-05 12:34:10.317 INFO  - ANALYSIS-0073: Plugin AvroS3Cataloger Configuration: filter: null  2021-04-05 12:34:10.317 INFO  - ANALYSIS-0073: Plugin AvroS3Cataloger Configuration: dryRun: false  2021-04-05 12:34:10.317 INFO  - ANALYSIS-0073: Plugin AvroS3Cataloger Configuration: versionMode: false  2021-04-05 12:34:10.317 INFO  - ANALYSIS-0073: Plugin AvroS3Cataloger Configuration: maxObjectsAmount: 1000  2021-04-05 12:34:10.317 INFO  - ANALYSIS-0073: Plugin AvroS3Cataloger Configuration: pluginName: "AvroS3Cataloger"  2021-04-05 12:34:10.317 INFO  - ANALYSIS-0073: Plugin AvroS3Cataloger Configuration: incremental: false  2021-04-05 12:34:10.317 INFO  - ANALYSIS-0073: Plugin AvroS3Cataloger Configuration: type: "Cataloger"  2021-04-05 12:34:10.317 INFO  - ANALYSIS-0073: Plugin AvroS3Cataloger Configuration: bucketFilter:  2021-04-05 12:34:10.317 INFO  - ANALYSIS-0073: Plugin AvroS3Cataloger Configuration: mode: "INCLUDE"  2021-04-05 12:34:10.317 INFO  - ANALYSIS-0073: Plugin AvroS3Cataloger Configuration: patterns:  2021-04-05 12:34:10.317 INFO  - ANALYSIS-0073: Plugin AvroS3Cataloger Configuration: - "avroasgqatestautomation1"  2021-04-05 12:34:10.317 INFO  - ANALYSIS-0073: Plugin AvroS3Cataloger Configuration: objectFilter:  2021-04-05 12:34:10.318 INFO  - ANALYSIS-0073: Plugin AvroS3Cataloger Configuration: dirFilter:  2021-04-05 12:34:10.318 INFO  - ANALYSIS-0073: Plugin AvroS3Cataloger Configuration: mode: "INCLUDE"  2021-04-05 12:34:10.318 INFO  - ANALYSIS-0073: Plugin AvroS3Cataloger Configuration: patterns:  2021-04-05 12:34:10.318 INFO  - ANALYSIS-0073: Plugin AvroS3Cataloger Configuration: - "*/TestAvro/*"  2021-04-05 12:34:10.318 INFO  - ANALYSIS-0073: Plugin AvroS3Cataloger Configuration: fileFilter:  2021-04-05 12:34:10.318 INFO  - ANALYSIS-0073: Plugin AvroS3Cataloger Configuration: mode: "INCLUDE"  2021-04-05 12:34:10.318 INFO  - ANALYSIS-0073: Plugin AvroS3Cataloger Configuration: patterns: []  2021-04-05 12:34:10.318 INFO  - ANALYSIS-0073: Plugin AvroS3Cataloger Configuration: dirPrefixes:  2021-04-05 12:34:10.318 INFO  - ANALYSIS-0073: Plugin AvroS3Cataloger Configuration: - "/AutoTestData" | ANALYSIS-0073 | AvroS3Cataloger |                |
      | INFO | Plugin AvroS3Cataloger Start Time:2021-04-05 12:34:10.279, End Time:2021-04-05 12:34:22.332, Errors:6, Warnings:3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | ANALYSIS-0072 | AvroS3Cataloger |                |
      | INFO | Plugin completed with errors (elapsed time in (HH:MM:SS.ms): 00:00:14.646)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | ANALYSIS-0075 |                 |                |

  @sanity @positive
  Scenario:SC#1:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                      | type      | query | param |
      | MultipleIDDelete | Default | cataloger/AvroS3Cataloger/AvroS3Catalog/% | Analysis  |       |       |
      | MultipleIDDelete | Default | avroasgqatestautomation1                  | Directory |       |       |

  ######################################################################UI VALIDATION WHEN BUCKET, FILE , DIRECTORY SET TO INCLUDE##################################################################################

  Scenario Outline:MLP-8708:SC#4 Run the Plugin configurations of AvroS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                               | body                                                                   | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Cataloger                                | ida/s3AvroPayloads/PluginConfiguration/sc2AvroS3ConfigFileInclude.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Cataloger                                |                                                                        | 200           | AvroS3Catalog    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                                        | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/*  | ida/s3AvroPayloads/PluginConfiguration/empty.json                      | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                                        | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |

  @MLP-8708 @webtest @aws @regression @sanity @IDA-10.0 @MLPQA-12093
  Scenario: MLP-8708:SC#4 Verify AvroS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when AvroS3Cataloger is run with region and Bucketname(Include)/Directory/File(include)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "facebook.avro" and clicks on search
    And user performs "facet selection" in "tagSC2Avro" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | facebook.avro |

  @sanity @positive
  Scenario:SC#4:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                      | type      | query | param |
      | MultipleIDDelete | Default | cataloger/AvroS3Cataloger/AvroS3Catalog/% | Analysis  |       |       |
      | MultipleIDDelete | Default | avroasgqatestautomation1                  | Directory |       |       |

 #########################################################################UI VALIDATION WHEN BUCKET INCLUDE AND FILES, DIRECTORY EXCLUDE##################################################################################

  Scenario Outline:MLP-8708:SC#4.1 Run the Plugin configurations of AvroS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                               | body                                                                   | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Cataloger                                | ida/s3AvroPayloads/PluginConfiguration/sc3AvroS3ConfigFileExclude.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Cataloger                                |                                                                        | 200           | AvroS3Cataloger  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                                        | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/*  | ida/s3AvroPayloads/PluginConfiguration/empty.json                      | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                                        | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |

  @MLP-8708 @webtest @aws @regression @sanity @IDA-10.0 @MLPQA-12092
  Scenario: MLP-8708:SC#4.1 Verify S3Cataloger collects Cluster,Service,Analysis,Directory,File when S3Cataloger is run with region and Bucketname(Include)/Directory/File(Exclude)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "facebook.avro" and clicks on search
    And user performs "facet selection" in "tagSC3Avro" attribute under "Tags" facets in Item Search results page
    Then user verify "non presence of facets" with following values under "Type" section in item search results page
      | File      |

  @sanity @positive
  Scenario:SC#4.1:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                      | type      | query | param |
      | MultipleIDDelete | Default | cataloger/AvroS3Cataloger/AvroS3Catalog/% | Analysis  |       |       |
      | MultipleIDDelete | Default | avroasgqatestautomation1                  | Directory |       |       |

   ####################################################################UI VALIDATION WHEN REGION AND KET IS SET##################################################################################

  Scenario Outline:MLP-8708:SC#4.2 Run the Plugin configurations of AvroS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                               | body                                                                          | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Cataloger                                | ida/s3AvroPayloads/PluginConfiguration/sc4AvroS3ConfigInCorrectAccessKey.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Cataloger                                |                                                                               | 200           | AvroS3Cataloger  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                                               | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/*  | ida/s3AvroPayloads/PluginConfiguration/empty.json                             | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                                               | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |

  @MLP-8708  @aws @regression @sanity @IDA-10.0 @MLPQA-12070
  Scenario: MLP-8708:SC#4.2 Verify AvroS3Cataloger collects Analysis item when AvroS3Cataloger is run with region, incorrect Access Key, Secret Key
    Then Analysis log "cataloger/AvroS3Cataloger/AvroS3Cataloger/%" should display below info/error/warning
      | type  | logValue                                                               | logCode     |
      | ERROR | Amazon S3 connection failed: AWS_S3-0006: Error retrieving bucket list | AWS_S3-0011 |

  @sanity @positive
  Scenario:SC#4.2:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                      | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AvroS3Cataloger/AvroS3Catalog/% | Analysis |       |       |

  #######################################################################UI VALIDATION WHEN REGION AND BUCKET  INCLUDE##################################################################################

  Scenario Outline:MLP-8708:SC#4.3 Run the Plugin configurations of AvroS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                               | body                                                                     | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Cataloger                                | ida/s3AvroPayloads/PluginConfiguration/sc5AvroS3ConfigBucketInclude.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Cataloger                                |                                                                          | 200           | AvroS3Cataloger  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                                          | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/*  | ida/s3AvroPayloads/PluginConfiguration/empty.json                        | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                                          | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |

  @MLP-8708 @webtest @aws @regression @sanity @IDA-10.0 @MLPQA-12112
  Scenario: MLP-8708:SC#4.3 Verify S3Cataloger collects Cluster,Service,Analysis,Directory,File when S3Cataloger is run with region  and Bucketname with Include
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "avroasgqatestautomation1" and clicks on search
    And user performs "facet selection" in "tagSC5Avro" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Item Value" in Item Search Results Page
#      | avroasgqatestautomation1 |
      | AutoTestData |
      | TestAvro     |
      | Incremental  |
      | version      |
      | AvroInternal |
    And user enters the search text "tagSC5Avro" and clicks on search
    And user performs "facet selection" in "tagSC5Avro" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Item Value" in Item Search Results Page
      | incremental.avro       |
      | twitter.avro           |
      | facebook.avro          |
      | employee.avro          |
      | baseversion.avro       |
      | employeetag.avro       |
      | subdirectoryfile.avro  |
      | employeeInfo.avro      |
      | subdirectoryfile2.avro |
    And user enters the search text "tagSC5Avro" and clicks on search
    And user performs "facet selection" in "tagSC5Avro" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Field" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Item Value" in Item Search Results Page
      | tweet     |
      | timestamp |
      | username  |
      | emp_name  |
      | emp_id    |
      | email     |

  @sanity @positive
  Scenario:SC#4.3:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                        | type      | query | param |
      | MultipleIDDelete | Default | cataloger/AvroS3Cataloger/AvroS3Cataloger/% | Analysis  |       |       |
      | MultipleIDDelete | Default | avroasgqatestautomation1                    | Directory |       |       |

  #############################################################################UI VALIDATION WHEN BUCKET EXCLUDE##################################################################################


  @aws
  Scenario:MLP-8708:SC#05 Delete the avroasgqatestautomation1 bucket in Amazon S3 storage
    Given user "Delete" objects in amazon directory "AutoTestData" in bucket "avroasgqatestautomation1"
    Then user "Delete" a bucket "avroasgqatestautomation1" in amazon storage service

  @aws
  Scenario: MLP-8708:SC#5 Create a bucket and folder with various file formats in S3 Amazon storage
    Given user "Create" a bucket "avroasgqatestautomation2" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName               | keyPrefix               | dirPath                                 | recursive |
      | avroasgqatestautomation2 | AutoTestData2/TestAvro2 | ida/s3AvroPayloads/TestData/Incremental | true      |

  Scenario Outline:MLP-8708:SC#5 Run the Plugin configurations of AvroS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                               | body                                                                     | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Cataloger                                | ida/s3AvroPayloads/PluginConfiguration/sc6AvroS3ConfigBucketExclude.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Cataloger                                |                                                                          | 200           | AvroS3Cataloger  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                                          | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/*  | ida/s3AvroPayloads/PluginConfiguration/empty.json                        | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                                          | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |

  @MLP-8708 @webtest @aws @regression @sanity @IDA-10.0 @MLPQA-12113
  Scenario: MLP-8708:SC#5 Verify S3Cataloger collects Cluster,Service,Analysis,Directory,File when S3Cataloger is run with region  and Bucketname with Exclude
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "avroasgqatestautomation" and clicks on search
    And user performs "facet selection" in "tagSC6Avro" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify non presence" of following "Items List" in Search Results Page
      | avroasgqatestautomation1 |
    And user enters the search text "avroasgqatestautomation" and clicks on search
    And user performs "facet selection" in "tagSC6Avro" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Item Value" in Item Search Results Page
      | avroasgqatestautomation2 |

  @aws
  Scenario: SC#5 Delete the avroasgqatestautomation2 bucket in Amazon S3 storage
    Given user "Delete" objects in amazon directory "AutoTestData2" in bucket "avroasgqatestautomation2"
    Then user "Delete" a bucket "avroasgqatestautomation2" in amazon storage service

  @sanity @positive
  Scenario:SC#5:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                        | type      | query | param |
      | MultipleIDDelete | Default | cataloger/AvroS3Cataloger/AvroS3Cataloger/% | Analysis  |       |       |
      | MultipleIDDelete | Default | avroasgqatestautomation2                    | Directory |       |       |

  ########################################################################UI VALIDATION BUCKET AND DIRECTORY INCLUDE##################################################################################

  @aws
  Scenario: MLP-8708:SC#6 Create a bucket and folder with various file formats in S3 Amazon storage
    Given user "Create" a bucket "avroasgqatestautomation1" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName               | keyPrefix    | dirPath                      | recursive |
      | avroasgqatestautomation1 | AutoTestData | ida/s3AvroPayloads/TestData/ | true      |

  Scenario Outline:MLP-8708:SC#6 Run the Plugin configurations of AvroS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                               | body                                                                     | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Cataloger                                | ida/s3AvroPayloads/PluginConfiguration/sc7AvroS3ConfigSubDirInclude.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Cataloger                                |                                                                          | 200           | AvroS3Cataloger  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                                          | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/*  | ida/s3AvroPayloads/PluginConfiguration/empty.json                        | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                                          | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |

  @MLP-8708 @webtest @aws @regression @sanity @IDA-10.0 @MLPQA-12112
  Scenario: MLP-8708:SC#6 Verify S3Cataloger collects Cluster,Service,Analysis,Directory,File when S3Cataloger is run with region  and Bucketname(Include) and Directory(Include)
    Given user gets amazon bucket "avroasgqatestautomation1" file count in "AutoTestData/TestAvro" directory and store in temp variable
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagSC7Avro" and clicks on search
    And user performs "facet selection" in "tagSC7Avro" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then results panel "file count" should be displayed as "tempStoredvalue" in Item Search results page

  @sanity @positive
  Scenario:SC#6:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                        | type      | query | param |
      | MultipleIDDelete | Default | cataloger/AvroS3Cataloger/AvroS3Cataloger/% | Analysis  |       |       |
      | MultipleIDDelete | Default | avroasgqatestautomation1                    | Directory |       |       |

  ##################################################################UI VALIDATION BUCKET AND SUB DIRECTORY INCLUDE, FILES *#################################################################################

  Scenario Outline:MLP-8708:SC#7 Run the Plugin configurations of AvroS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                               | body                                                                     | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Cataloger                                | ida/s3AvroPayloads/PluginConfiguration/sc8AvroS3ConfigSubDirInclude.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Cataloger                                |                                                                          | 200           | AvroS3Cataloger  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                                          | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/*  | ida/s3AvroPayloads/PluginConfiguration/empty.json                        | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                                          | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |

  @MLP-8708 @webtest @aws @regression @sanity @IDA-10.0 @MLPQA-12104
  Scenario: MLP-8708:SC#7 Verify S3Cataloger collects Cluster,Service,Analysis,Directory,File when S3Cataloger is run with region  and Bucketname(Include)/Directory/Sub Directory(Include)/File(*)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "subdirectoryfile" and clicks on search
    And user performs "facet selection" in "tagSC8Avro" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | subdirectoryfile.avro  |
      | subdirectoryfile2.avro |
    And user enters the search text "AvroInternal" and clicks on search
    And user performs "facet selection" in "tagSC8Avro" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | AvroInternal |

  @sanity @positive
  Scenario:SC#7:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                        | type      | query | param |
      | MultipleIDDelete | Default | cataloger/AvroS3Cataloger/AvroS3Cataloger/% | Analysis  |       |       |
      | MultipleIDDelete | Default | avroasgqatestautomation1                    | Directory |       |       |

  #######################################################################UI VALIDATION BUCKET INCLUDE SUB DIRECTORY EXCLUDE##################################################################################

  Scenario Outline:MLP-8708:SC#7.1 Run the Plugin configurations of AvroS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                               | body                                                                     | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Cataloger                                | ida/s3AvroPayloads/PluginConfiguration/sc9AvroS3ConfigSubDirExclude.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Cataloger                                |                                                                          | 200           | AvroS3Cataloger  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                                          | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/*  | ida/s3AvroPayloads/PluginConfiguration/empty.json                        | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                                          | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |

  @MLP-8708 @webtest @aws @regression @sanity @IDA-10.0 @MLPQA-12110
  Scenario: MLP-8708:SC#7.1 Verify S3Cataloger collects Cluster,Service,Analysis,Directory,File when S3Cataloger is run with region  and Bucketname(Include)/Directory/Sub Directory(Exclude)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AvroInternal" and clicks on search
    And user performs "facet selection" in "tagSC9Avro" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify non presence" of following "Items List" in Search Results Page
      | AvroInternal |
    And user enters the search text "tagSC9Avro" and clicks on search
    And user performs "facet selection" in "tagSC9Avro" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify non presence" of following "Items List" in Search Results Page
      | subdirectoryfile.avro  |
      | subdirectoryfile2.avro |

  @sanity @positive
  Scenario:SC#7.1:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                        | type      | query | param |
      | MultipleIDDelete | Default | cataloger/AvroS3Cataloger/AvroS3Cataloger/% | Analysis  |       |       |
      | MultipleIDDelete | Default | avroasgqatestautomation1                    | Directory |       |       |


  #####################################################################IO VALIDATION BUCKET SUB DIRECTORY AND FILES INCLUDE##################################################################################

  Scenario Outline:MLP-8708:SC#7.2 Run the Plugin configurations of AvroS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                               | body                                                                                | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Cataloger                                | ida/s3AvroPayloads/PluginConfiguration/s10AvroS3ConfigSubDirIncludeFileInclude.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Cataloger                                |                                                                                     | 200           | AvroS3Cataloger  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                                                     | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/*  | ida/s3AvroPayloads/PluginConfiguration/empty.json                                   | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                                                     | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |

  @MLP-8708 @webtest @aws @regression @sanity @IDA-10.0 @MLPQA-12109
  Scenario: MLP-8708:SC#7.2 Verify AvroS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when AvroS3Cataloger is run with region and Bucketname(Include)/Directory/Sub Directory(Include)/File(include)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "subdirectoryfile" and clicks on search
    And user performs "facet selection" in "tagSC10Avro" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | subdirectoryfile.avro |
    And user enters the search text "tagSC10Avro" and clicks on search
    And user performs "facet selection" in "tagSC10Avro" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | subdirectoryfile2.avro |
    And user enters the search text "AvroInternal" and clicks on search
    And user performs "facet selection" in "tagSC10Avro" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | AvroInternal |


  @sanity @positive
  Scenario:SC#7.2:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                        | type      | query | param |
      | MultipleIDDelete | Default | cataloger/AvroS3Cataloger/AvroS3Cataloger/% | Analysis  |       |       |
      | MultipleIDDelete | Default | avroasgqatestautomation1                    | Directory |       |       |


  ##############################################################UI VALIDATION BUCKET, SUB DIRECTORY INCLUDE AND FILES EXCLUDE##################################################################################

  Scenario Outline:MLP-8708:SC#7.3 Run the Plugin configurations of AvroS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                               | body                                                                                | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Cataloger                                | ida/s3AvroPayloads/PluginConfiguration/s11AvroS3ConfigSubDirIncludeFileExclude.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Cataloger                                |                                                                                     | 200           | AvroS3Cataloger  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                                                     | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/*  | ida/s3AvroPayloads/PluginConfiguration/empty.json                                   | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                                                     | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |

  @MLP-8708 @webtest @aws @regression @sanity @IDA-10.0 @MLPQA-12108
  Scenario: MLP-8708:SC#7.3 Verify AvroS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when AvroS3Cataloger is run with region and Bucketname(Include)/Directory/Sub Directory(Include)/File(exclude)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AvroInternal" and clicks on search
    And user performs "facet selection" in "tagSC11Avro" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | AvroInternal |
    And user enters the search text "subdirectoryfile" and clicks on search
    And user performs "facet selection" in "tagSC11Avro" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify non presence" of following "Items List" in Search Results Page
      | subdirectoryfile.avro |

  @sanity @positive
  Scenario:SC#7.3:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                        | type      | query | param |
      | MultipleIDDelete | Default | cataloger/AvroS3Cataloger/AvroS3Cataloger/% | Analysis  |       |       |
      | MultipleIDDelete | Default | avroasgqatestautomation1                    | Directory |       |       |

  ########################################################################UI VALIDATION WILD CARD SCENARIO################################################################################

  Scenario Outline:MLP-8708:SC#8 Run the Plugin configurations of AvroS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                               | body                                                                      | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Cataloger                                | ida/s3AvroPayloads/PluginConfiguration/s12AvroS3ConfigBucketWildCard.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Cataloger                                |                                                                           | 200           | AvroS3Cataloger  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                                           | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/*  | ida/s3AvroPayloads/PluginConfiguration/empty.json                         | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                                           | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |

  @MLP-8708 @webtest @aws @regression @sanity @IDA-10.0 @MLPQA-12107
  Scenario: MLP-8708:SC#8 Verify AvroS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when AvroS3Cataloger is run with region and Bucketname with wild card character(*)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagSC12Avro" and clicks on search
    And user performs "facet selection" in "tagSC12Avro" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Type" section in item search results page
      | File      |
      | Directory |
      | Analysis  |
      | Cluster   |
      | Service   |
      | Field     |
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Item Value" in Item Search Results Page
      | avroasgqatestautomation1 |
      | AutoTestData             |
      | TestAvro                 |
      | version                  |
      | AvroInternal             |
    And user enters the search text "tagSC12Avro" and clicks on search
    And user performs "facet selection" in "tagSC12Avro" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Item Value" in Item Search Results Page
      | twitter.avro           |
      | facebook.avro          |
      | employee.avro          |
      | baseversion.avro       |
      | employeetag.avro       |
      | subdirectoryfile.avro  |
      | employeeInfo.avro      |
      | subdirectoryfile2.avro |
    And user enters the search text "tagSC12Avro" and clicks on search
    And user performs "facet selection" in "tagSC12Avro" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Field" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Item Value" in Item Search Results Page
      | tweet     |
      | timestamp |
      | username  |
      | emp_name  |
      | emp_id    |
      | email     |

  @sanity @positive
  Scenario:SC#8:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                        | type      | query | param |
      | MultipleIDDelete | Default | cataloger/AvroS3Cataloger/AvroS3Cataloger/% | Analysis  |       |       |
      | MultipleIDDelete | Default | avroasgqatestautomation1                    | Directory |       |       |

  ########################################################################UI VALDATION REGION BUCKET INCLUDE , SUB DIRECTORY * ##################################################################################

  Scenario Outline:MLP-8708:SC#8.1 Run the Plugin configurations of AvroS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                               | body                                                                           | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Cataloger                                | ida/s3AvroPayloads/PluginConfiguration/s13AvroS3ConfigSubDirWithSlashStar.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Cataloger                                |                                                                                | 200           | AvroS3Cataloger  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                                                | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/*  | ida/s3AvroPayloads/PluginConfiguration/empty.json                              | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                                                | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |

  @MLP-8708 @webtest @aws @regression @sanity @IDA-10.0 @MLPQA-12105
  Scenario: MLP-8708:SC#8.1 Verify AvroS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when AvroS3Cataloger is run with region and Bucketname(Include)/Directory/Sub Directory(Name with / and *)
    Given user gets amazon bucket "avroasgqatestautomation1" file count in "AutoTestData/TestAvro/AvroInternal" directory and store in temp variable
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagSC13Avro" and clicks on search
    And user performs "facet selection" in "tagSC13Avro" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then results panel "file count" should be displayed as "tempStoredvalue"" in Item Search results page

  @sanity @positive
  Scenario:SC#8.1:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                        | type      | query | param |
      | MultipleIDDelete | Default | cataloger/AvroS3Cataloger/AvroS3Cataloger/% | Analysis  |       |       |
      | MultipleIDDelete | Default | avroasgqatestautomation1                    | Directory |       |       |

 ########################################################################UI VALDATION REGION BUCKETSUB DIRECTORY INCLUDE, FILES * ##################################################################################

  Scenario Outline:MLP-8708:SC#8.2 Run the Plugin configurations of AvroS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                               | body                                                                       | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Cataloger                                | ida/s3AvroPayloads/PluginConfiguration/s14AvroS3ConfigFileInludeRegex.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Cataloger                                |                                                                            | 200           | AvroS3Cataloger  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                                            | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/*  | ida/s3AvroPayloads/PluginConfiguration/empty.json                          | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                                            | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |

  @MLP-8708 @webtest @aws @regression @sanity @IDA-10.0 @MLPQA-12104
  Scenario: MLP-8708:SC#8.2 Verify AvroS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when AvroS3Cataloger is run with region and Bucketname(Include)/Directory/Sub Directory(Include)/File(*)
    Given user gets amazon bucket "avroasgqatestautomation1" file count in "AutoTestData/TestAvro/AvroInternal" directory and store in temp variable
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "subdirectoryfile" and clicks on search
    And user performs "facet selection" in "tagSC14Avro" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | subdirectoryfile.avro  |
      | subdirectoryfile2.avro |
    Then results panel "file count" should be displayed as "tempStoredvalue"" in Item Search results page

  @sanity @positive
  Scenario:SC#8.2:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                        | type      | query | param |
      | MultipleIDDelete | Default | cataloger/AvroS3Cataloger/AvroS3Cataloger/% | Analysis  |       |       |
      | MultipleIDDelete | Default | avroasgqatestautomation1                    | Directory |       |       |

 ########################################################################UI VALDATION DRY RUN SET TO TRUE ##################################################################################

  Scenario Outline:MLP-8708:SC#9 Run the Plugin configurations of AvroS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                               | body                                                                   | response code | response message | jsonPath                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Cataloger                                | ida/s3AvroPayloads/PluginConfiguration/sc25AvroS3ConfigDryRunTrue.json | 204           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Cataloger                                |                                                                        | 200           | AvroS3Catalog    |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                                        | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Catalog')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/*  | ida/s3AvroPayloads/PluginConfiguration/empty.json                      | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                                        | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Catalog')].status |

  @MLP-8708 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-8708:SC#9 Verify AvroS3Cataloger collects Analysis when AvroS3Cataloger is run with dryRun as true
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "cataloger/AvroS3Cataloger/AvroS3Catalog/" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/AvroS3Cataloger/AvroS3Catalog/%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 22             | Description |
      | Number of errors          | 6             | Description |
    Then Analysis log "cataloger/AvroS3Cataloger/AvroS3Catalog/%" should display below info/error/warning
      | type | logValue                                                                                   | logCode       | pluginName | removableText |
      | INFO | Plugin AvroS3Cataloger running on dry run mode                                             | ANALYSIS-0069 |            |               |
      | INFO | Plugin AvroS3Cataloger processed 22 items on dry run mode and not written to the repository | ANALYSIS-0070 |            |               |

  @sanity @positive
  Scenario:SC#9:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                      | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AvroS3Cataloger/AvroS3Catalog/% | Analysis |       |       |

  @aws
  Scenario:  MLP-8708:SC#9 Delete the bucket in Amazon S3 storage
    Given user "Delete" objects in amazon directory "AutoTestData" in bucket "avroasgqatestautomation1"
    Then user "Delete" a bucket "avroasgqatestautomation1" in amazon storage service

 ########################################################################UI VALDATION INCREMENTAL SCENARIO##################################################################################

  @aws
  Scenario: MLP-8708:SC#10 Create Bucket for AvroS3Cataloger
    Given user "Create" a bucket "avroasgqatestautomation1" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName               | keyPrefix             | dirPath                              | recursive |
      | avroasgqatestautomation1 | AutoTestData/TestAvro | ida/s3AvroPayloads/TestData/TestAvro | true      |

  Scenario Outline:MLP-8708:SC#10 Run the Plugin configurations of AvroS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                               | body                                                                        | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Cataloger                                | ida/s3AvroPayloads/PluginConfiguration/s16AvroS3ConfigIncrementalFalse.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Cataloger                                |                                                                             | 200           | AvroS3Cataloger  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                                             | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/*  | ida/s3AvroPayloads/PluginConfiguration/empty.json                           | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                                             | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |

  @webtest  @sanity @positive @MLP-8708 @IDA-10.0 @MLPQA-12094
  Scenario: MLP-8708:SC#10 Verify incremental scan works properly with AvroS3Cataloger
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagSC16Avro" and clicks on search
    And user performs "facet selection" in "tagSC16Avro" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "version [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user get objects list from "AutoTestData/TestAvro/version/" in bucket "avroasgqatestautomation1" with maximum count of "50"
    Then results panel "file count" should be displayed as "tempStoredvalue"" in Item Search results page
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | incremental.avro |

  @aws
  Scenario: MLP-8708:SC#10 User performs multiple upload
    Given user performs "multiple upload" in amazon storage service with below parameters
      | bucketName               | keyPrefix                | dirPath                                 | recursive |
      | avroasgqatestautomation1 | AutoTestData/Incremental | ida/s3AvroPayloads/TestData/Incremental | false     |

  Scenario Outline:MLP-8708:SC#10 Run the Plugin configurations of AvroS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                               | body                                                                       | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Cataloger                                | ida/s3AvroPayloads/PluginConfiguration/s16AvroS3ConfigIncrementalTrue.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Cataloger                                |                                                                            | 200           | AvroS3Cataloger  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                                            | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/*  | ida/s3AvroPayloads/PluginConfiguration/empty.json                          | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                                            | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |

  @webtest  @sanity @positive @MLP-8708 @IDA-10.0 @MLPQA-12103
  Scenario: MLP-8708:SC#10 Verify incremental scan works properly with AvroS3Cataloger
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagSC16Avro" and clicks on search
    And user performs "facet selection" in "tagSC16Avro" attribute under "Tags" facets in Item Search results page
    And user gets amazon bucket "avroasgqatestautomation1" file count in "AutoTestData" directory and store in temp variable
    And user performs "facet selection" in "version [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user get objects list from "AutoTestData/TestAvro/version/" in bucket "avroasgqatestautomation1" with maximum count of "50"
    Then results panel "file count" should be displayed as "tempstoredvalue" in Item Search results page
    And user performs "facet selection" in "Incremental [Directory]" attribute under "Hierarchy" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | incremental.avro |


  @sanity @positive
  Scenario:SC#10:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                        | type      | query | param |
      | MultipleIDDelete | Default | cataloger/AvroS3Cataloger/AvroS3Cataloger/% | Analysis  |       |       |
      | MultipleIDDelete | Default | avroasgqatestautomation1                    | Directory |       |       |
      | MultipleIDDelete | Default | amazonaws.com                               | Cluster   |       |       |
      | MultipleIDDelete | Default | AmazonS3                                    | Service   |       |       |

 ########################################################################UI VALDATION FILE VERSION VALIDATION##################################################################################

  @aws
  Scenario:MLP-8708:SC#10.1 Delete the bucket in Amazon S3 storage
    Given user "Delete" objects in amazon directory "AutoTestData" in bucket "avroasgqatestautomation1"
    Then user "Delete" a bucket "avroasgqatestautomation1" in amazon storage service

  @aws
  Scenario: MLP-8708:SC#10.1 Create Bucket for AvroS3Cataloger
    Given user "Create" a bucket "avroasgqatestautomation1" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName               | keyPrefix    | dirPath                      | recursive |
      | avroasgqatestautomation1 | AutoTestData | ida/s3AvroPayloads/TestData/ | true      |
    And user performs "version option enable" in amazon storage service with below parameters
      | bucketName               | status  |
      | avroasgqatestautomation1 | Enabled |
    And user performs "single upload" in amazon storage service with below parameters
      | bucketName               | keyPrefix                                      | dirPath                                                       |
      | avroasgqatestautomation1 | AutoTestData/TestAvro/version/baseversion.avro | ida/s3AvroPayloads/TestData/TestAvro/version/baseversion.avro |

  Scenario Outline:MLP-8708:SC#10.1 Run the Plugin configurations of AvroS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                               | body                                                                | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Cataloger                                | ida/s3AvroPayloads/PluginConfiguration/sc20AvroS3ConfigVersion.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Cataloger                                |                                                                     | 200           | AvroS3Cataloger  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                                     | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/*  | ida/s3AvroPayloads/PluginConfiguration/empty.json                   | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                                     | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |

  @MLP-8708 @webtest @aws @regression @sanity @IDA-10.0 @MLPQA-12102
  Scenario: MLP-8708-SC#10.1 Verify file versions are collected correctly when scan mode is set as versions in AvroS3Cataloger
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "version" and clicks on search
    And user performs "facet selection" in "tagSC20Avro" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "version [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user get objects list from "AutoTestData/TestAvro/version/" in bucket "avroasgqatestautomation1" with maximum count of "50"
    Then results panel "file count" should be displayed as "tempStoredvalue" in Item Search results page

  @sanity @positive
  Scenario:SC#10.1:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                        | type      | query | param |
      | MultipleIDDelete | Default | cataloger/AvroS3Cataloger/AvroS3Cataloger/% | Analysis  |       |       |
      | MultipleIDDelete | Default | avroasgqatestautomation1                    | Directory |       |       |

  @aws
  Scenario:SC#10.1 Delete the version bucket in Amazon S3 storage
    Given user "Delete Version" objects in amazon directory "AutoTestData" in bucket "avroasgqatestautomation1"
    Then user "Delete" a bucket "avroasgqatestautomation1" in amazon storage service

 ######################################################################UI VALDATION FILE VERSION VALIDATION WHEN INCREMENTAL ON##################################################################################

  @aws
  Scenario: MLP-8708:SC#10.2 Create Bucket for AvroS3Cataloger
    Given user "Create" a bucket "avroasgqatestautomation1" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName               | keyPrefix    | dirPath                      | recursive |
      | avroasgqatestautomation1 | AutoTestData | ida/s3AvroPayloads/TestData/ | true      |
    And user performs "version option enable" in amazon storage service with below parameters
      | bucketName               | status  |
      | avroasgqatestautomation1 | Enabled |

  Scenario Outline:MLP-8708:SC#10.2 Run the Plugin configurations of AvroS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                               | body                                                                     | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Cataloger                                | ida/s3AvroPayloads/PluginConfiguration/S22AvroS3ConfigVersionIncrOn.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Cataloger                                |                                                                          | 200           | AvroS3Cataloger  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                                          | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/*  | ida/s3AvroPayloads/PluginConfiguration/empty.json                        | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                                          | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |

  @MLP-8708 @webtest @aws @regression @sanity @IDA-10.0 @MLPQA-12091
  Scenario: MLP-8708-SC#10.2 Verify file versions are collected correctly when scan mode is set as versions in AvroS3Cataloger and Incremental collection is ON
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagSC23Avro" and clicks on search
    And user performs "facet selection" in "tagSC23Avro" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "version [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user get objects list from "AutoTestData/TestAvro/version/" in bucket "avroasgqatestautomation1" with maximum count of "50"
    Then results panel "file count" should be displayed as "tempStoredValue" in Item Search results page

  Scenario: MLP-8708-SC#10.2 user performs "single upload"
    Given user performs "single upload" in amazon storage service with below parameters
      | bucketName               | keyPrefix                                      | dirPath                                                       |
      | avroasgqatestautomation1 | AutoTestData/TestAvro/version/baseversion.avro | ida/s3AvroPayloads/TestData/TestAvro/version/baseversion.avro |

  Scenario Outline:MLP-8708:SC#10.2 Run the Plugin configurations of AvroS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                               | body                                              | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                   | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/*  | ida/s3AvroPayloads/PluginConfiguration/empty.json | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                   | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |

  @MLP-8708 @webtest @aws @regression @sanity @IDA-10.0 @MLPQA-12091
  Scenario: MLP-8708-SC#10.2 Verify file versions are collected correctly when scan mode is set as versions in AvroS3Cataloger and Incremental collection is ON
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagSC23Avro" and clicks on search
    And user performs "facet selection" in "tagSC23Avro" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "version [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user get objects list from "AutoTestData/TestAvro/version/" in bucket "avroasgqatestautomation1" with maximum count of "50"
    Then results panel "file count" should be displayed as "tempStoredValue" in Item Search results page

  @sanity @positive
  Scenario:SC#10.2:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                        | type      | query | param |
      | MultipleIDDelete | Default | cataloger/AvroS3Cataloger/AvroS3Cataloger/% | Analysis  |       |       |
      | MultipleIDDelete | Default | avroasgqatestautomation1                    | Directory |       |       |

  @aws
  Scenario:SC#10.2 Delete the version bucket in Amazon S3 storage
    Given user "Delete Version" objects in amazon directory "AutoTestData" in bucket "avroasgqatestautomation1"
    Then user "Delete" a bucket "avroasgqatestautomation1" in amazon storage service


  ########################################################################OTHER UI VALDATION SUCH AS TOOL TIP AND MESSAGES##################################################################################

  @webtest @MLP-8708 @positive @regression @pluginManager @MLPQA-12095
  Scenario: MLP-8708 SC#11 Verify proper error message is shown if mandatory fields are not filled in AvroS3Cataloger configuration page
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem            |
      | click      | Settings Icon         |
      | click      | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute       |
      | Type      | Cataloger       |
      | Plugin    | AvroS3Cataloger |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

  @MLP-14874 @webtest @positive @regression @pluginManager
  Scenario: SC#11 Verify if all the mandatory fields (Name) are throwing with proper error message if they are left blank in Avro S3 Datasource
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data Sources Page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute        |
      | Data Source Type | AvroS3DataSource |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

  @MLP-14874 @webtest
  Scenario: SC#11 Verify captions and tool tip text in AvroS3Cataloger
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem            |
      | click      | Settings Icon         |
      | click      | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute       |
      | Type      | Cataloger       |
      | Plugin    | AvroS3Cataloger |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                      |
      | Label                      |
      | Credential*                |
      | Data Source*               |
      | Bucket names               |
      | Mode                       |
      | Directory prefixes to scan |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name*             | Plugin configuration name                                                                                       |
      | Label             | Plugin configuration extended label and description                                                             |
      | Bucket names      | Add the bucket names to filter them based on the mode, Include/Exclude. All buckets are included if left empty. |
      | S3 Objects filter | Apply filters to S3 objects, such as directories, sub-directories and files.                                    |
      | Credential*       | Credential to be used                                                                                           |
      | Data Source*      | Data source connection to be used                                                                               |

  @webtest @MLP-14874
  Scenario: SC#11 Verify captions and tool tip text in AvroS3DataSource
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data Sources Page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute        |
      | Data Source Type | AvroS3DataSource |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Data Source Type* |
      | Name*             |
      | Label             |
      | Region*           |
      | Credential*       |
      | Node              |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name*       | Plugin configuration name                           |
      | Label       | Plugin configuration extended label and description |
      | Credential* | Credential to be used                               |


#  @aws
#  Scenario: MLP-14874:SC28#Create a bucket and folder with various file formats in S3 Amazon storage
#    Given user "Create" a bucket "avroasgqatestautomation1" in amazon storage service
#    And user performs "multiple upload" in amazon storage service with below parameters
#      | bucketName              | keyPrefix     | dirPath                      | recursive |
#      | avroasgqatestautomation1 | AutoTestData | ida/s3AvroPayloads/TestData/ | true      |

  ####
#  @MLP-14874 @webtest
#  Scenario: SC27#-Verify the Analysis succeeded notification displayed in IDC UI when the analysis plugin executed without any errors - Valid Avro S3 DataSource
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user clicks on notification icon
#    When user clicks on mark all read button in the notifications tab
#    Then user clicks on exit button in notifications panel
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                     | body                                                           | response code | response message | jsonPath                                                   |
#      | application/json | raw   | false | Post         | settings/catalogs                                                       | ida/s3AvroPayloads/catalogs/CreateS3CatalogSC1.json            | 204           |                  |                                                            |
#      |                  |       |       | Put          | settings/analyzers/AvroS3DataSource                                     | ida/s3AvroPayloads/DataSource/AvroS3ValidDataSourceConfig.json | 204           |                  |                                                            |
#      |                  |       |       | Get          | settings/analyzers/AvroS3DataSource                                     |                                                                | 200           |                  | AvroS3ValidDataSource                                      |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/InternalNode/datasource/AvroS3DataSource/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='AvroS3ValidDataSource')].status |
#      |                  |       |       | Post         | /extensions/analyzers/start/InternalNode/datasource/AvroS3DataSource/*  | ida/s3AvroPayloads/empty.json                                  | 200           |                  |                                                            |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/InternalNode/datasource/AvroS3DataSource/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='AvroS3ValidDataSource')].status |
#    When user clicks on notification icon
#    And "Analysis started!" notification should have content "Analysis AvroS3DataSource on InternalNode has started" in the notifications tab
#    And "Analysis succeeded!" notification should have content "Analysis AvroS3DataSource on InternalNode has succeeded" in the notifications tab
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/S3AvroATSC1"
#    Then Status code 204 must be returned
#    And user clicks on logout button
#
#
#  ####
#  @MLP-14874 @webtest
#  Scenario: SC28#-Verify the Analysis failed notification event displayed in IDC UI when user gives invalid Secret and Access Key for Avro S3 datasource plugin
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user clicks on notification icon
#    When user clicks on mark all read button in the notifications tab
#    Then user clicks on exit button in notifications panel
#    Then Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                  | body                                                             | response code | response message | jsonPath                                                     |
#      | application/json | raw   | false | Post         | settings/catalogs                                                    | ida/s3AvroPayloads/catalogs/CreateS3CatalogSC28.json             | 204           |                  |                                                              |
#      |                  |       |       | Put          | settings/analyzers/AvroS3DataSource                                  | ida/s3AvroPayloads/DataSource/AvroS3InValidDataSourceConfig.json | 204           |                  |                                                              |
#      |                  |       |       | Get          | settings/analyzers/AvroS3DataSource                                  |                                                                  | 200           |                  | AvroS3InValidDataSource                                      |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AvroS3DataSource/* |                                                                  | 200           | IDLE             | $.[?(@.configurationName=='AvroS3InValidDataSource')].status |
#      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/AvroS3DataSource/*  | ida/s3AvroPayloads/empty.json                                    | 200           |                  |                                                              |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AvroS3DataSource/* |                                                                  | 200           | IDLE             | $.[?(@.configurationName=='AvroS3InValidDataSource')].status |
#    When user clicks on notification icon
#    And "Analysis started!" notification should have content "Analysis AvroS3DataSource on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis AvroS3DataSource on LocalNode has failed:" in the notifications tab
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/S3AvroATSC28"
#    Then Status code 204 must be returned
#    And user clicks on logout button
#
#
#
#  ####
#  @MLP-14874 @webtest
#  Scenario: SC29#-Verify the Avro S3 Cataloger does not collect any items when an Invalid Datasource(with wrong Credentials) and Invalid Credentials are used in the Plugin Configuration
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user clicks on notification icon
#    When user clicks on mark all read button in the notifications tab
#    Then user clicks on exit button in notifications panel
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                  | body                                                                                           | response code | response message | jsonPath                                                                               |
#      | application/json | raw   | false | Post         | settings/catalogs                                                    | ida/s3AvroPayloads/catalogs/CreateS3CatalogSC28.json                                           | 204           |                  |                                                                                        |
#      |                  |       |       | Put          | settings/analyzers/AvroS3Cataloger                                   | ida/s3AvroPayloads/PluginConfiguration/sc28AvroS3ConfigWithInvalidDataSourceAndCredential.json | 204           |                  |                                                                                        |
#      |                  |       |       | Get          | settings/analyzers/AvroS3Cataloger                                   |                                                                                                | 200           |                  | AvroS3CatalogerWithInvalidDataSourceAndCredential                                      |
#      |                  |       |       | Put          | settings/analyzers/AvroS3DataSource                                  | ida/s3AvroPayloads/DataSource/AvroS3InValidDataSourceConfig.json                               | 204           |                  |                                                                                        |
#      |                  |       |       | Get          | settings/analyzers/AvroS3DataSource                                  |                                                                                                | 200           |                  | AvroS3InValidDataSource                                                                |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AvroS3DataSource/* |                                                                                                | 200           | IDLE             | $.[?(@.configurationName=='AvroS3InValidDataSource')].status                           |
#      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/AvroS3DataSource/*  | ida/s3AvroPayloads/empty.json                                                                  | 200           |                  |                                                                                        |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AvroS3DataSource/* |                                                                                                | 200           | IDLE             | $.[?(@.configurationName=='AvroS3InValidDataSource')].status                           |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/*    |                                                                                                | 200           | IDLE             | $.[?(@.configurationName=='AvroS3CatalogerWithInvalidDataSourceAndCredential')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/*     | ida/s3AvroPayloads/empty.json                                                                  | 200           |                  |                                                                                        |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/*    |                                                                                                | 200           | IDLE             | $.[?(@.configurationName=='AvroS3CatalogerWithInvalidDataSourceAndCredential')].status |
#    And user clicks on notification icon
#    And "Analysis started!" notification should have content "Analysis AvroS3Cataloger on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis AvroS3Cataloger on LocalNode has failed:" in the notifications tab
#    And "Analysis started!" notification should have content "Analysis AvroS3DataSource on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis AvroS3DataSource on LocalNode has failed:" in the notifications tab
#    Then user clicks on exit button in notifications panel
#    And user select "All" catalog and search "S3AvroATSC28" items at top end
#    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
#      | Analysis |
#      | Cluster  |
#      | Service  |
#    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
#    And user performs "dynamic item click" on "cataloger" item from search results
#    And user click on Analysis log link in DATA widget section
#    Then user "verify analysis log contains" presence of "The AWS Access Key Id you provided does not exist in our records." in Analysis Log of IDC UI
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/S3AvroATSC28"
#    Then Status code 204 must be returned
#    And user clicks on logout button
#
#
#
#  ####
#  @MLP-14874 @webtest
#  Scenario: SC30#-Verify the Avro S3 Cataloger collects all items when an Invalid Datasource(with wrong Credentials) and Valid Credentials are used in the Plugin Configuration
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user clicks on notification icon
#    When user clicks on mark all read button in the notifications tab
#    Then user clicks on exit button in notifications panel
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                  | body                                                                                                | response code | response message | jsonPath                                                                               |
#      | application/json | raw   | false | Post         | settings/catalogs                                                    | ida/s3AvroPayloads/catalogs/CreateS3CatalogSC28.json                                                | 204           |                  |                                                                                        |
#      |                  |       |       | Put          | settings/analyzers/AvroS3Cataloger                                   | ida/s3AvroPayloads/PluginConfiguration/sc28AvroS3ConfigWithInvalidDataSourceAndValidCredential.json | 204           |                  |                                                                                        |
#      |                  |       |       | Get          | settings/analyzers/AvroS3Cataloger                                   |                                                                                                     | 200           |                  | AvroS3CatalogerWithInvalidDataSourceAndCredential                                      |
#      |                  |       |       | Put          | settings/analyzers/AvroS3DataSource                                  | ida/s3AvroPayloads/DataSource/AvroS3InValidDataSourceConfig.json                                    | 204           |                  |                                                                                        |
#      |                  |       |       | Get          | settings/analyzers/AvroS3DataSource                                  |                                                                                                     | 200           |                  | AvroS3InValidDataSource                                                                |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AvroS3DataSource/* |                                                                                                     | 200           | IDLE             | $.[?(@.configurationName=='AvroS3InValidDataSource')].status                           |
#      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/AvroS3DataSource/*  | ida/s3AvroPayloads/empty.json                                                                       | 200           |                  |                                                                                        |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AvroS3DataSource/* |                                                                                                     | 200           | IDLE             | $.[?(@.configurationName=='AvroS3InValidDataSource')].status                           |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/*    |                                                                                                     | 200           | IDLE             | $.[?(@.configurationName=='AvroS3CatalogerWithInvalidDataSourceAndCredential')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/*     | ida/s3AvroPayloads/empty.json                                                                       | 200           |                  |                                                                                        |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/*    |                                                                                                     | 200           | IDLE             | $.[?(@.configurationName=='AvroS3CatalogerWithInvalidDataSourceAndCredential')].status |
#    And user clicks on notification icon
#    And "Analysis started!" notification should have content "Analysis AvroS3Cataloger on LocalNode has started" in the notifications tab
#    And "Analysis succeeded!" notification should have content "Analysis AvroS3Cataloger on LocalNode has succeeded" in the notifications tab
#    And "Analysis started!" notification should have content "Analysis AvroS3DataSource on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis AvroS3DataSource on LocalNode has failed:" in the notifications tab
#    Then user clicks on exit button in notifications panel
#    And user select "All" catalog and search "S3AvroATSC28" items at top end
#    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
#      | Field     |
#      | File      |
#      | Directory |
#      | Analysis  |
#      | Cluster   |
#      | Service   |
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/S3AvroATSC28"
#    Then Status code 204 must be returned
#    And user clicks on logout button
#
#
#  ####
#  @MLP-14874 @webtest
#  Scenario: SC31#-Verify the Analysis failed notification displayed in IDC UI when Datasource Plugin is Started with Empty Credentials in Datasource
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user clicks on notification icon
#    When user clicks on mark all read button in the notifications tab
#    Then user clicks on exit button in notifications panel
#    Then Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                  | body                                                           | response code | response message | jsonPath                                                   |
#      | application/json | raw   | false | Post         | settings/catalogs                                                    | ida/s3AvroPayloads/catalogs/CreateS3CatalogSC29.json           | 204           |                  |                                                            |
#      |                  |       |       | Put          | settings/analyzers/AvroS3DataSource                                  | ida/s3AvroPayloads/DataSource/AvroS3EmptyDataSourceConfig.json | 204           |                  |                                                            |
#      |                  |       |       | Get          | settings/analyzers/AvroS3DataSource                                  |                                                                | 200           |                  | AvroS3EmptyDataSource                                      |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AvroS3DataSource/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='AvroS3EmptyDataSource')].status |
#      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/AvroS3DataSource/*  | ida/s3AvroPayloads/empty.json                                  | 200           |                  |                                                            |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AvroS3DataSource/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='AvroS3EmptyDataSource')].status |
#    When user clicks on notification icon
#    And "Analysis started!" notification should have content "Analysis AvroS3DataSource on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis AvroS3DataSource on LocalNode has failed:" in the notifications tab
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/S3AvroATSC29"
#    Then Status code 204 must be returned
#    And user clicks on logout button
#
#
#  ####
#  @MLP-14874 @webtest
#  Scenario: SC32#-Verify the Avro S3 Cataloger does not collect any items when an Datasource(with Empty Credentials) and Empty Credentials are used in the Plugin Configuration
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user clicks on notification icon
#    When user clicks on mark all read button in the notifications tab
#    Then user clicks on exit button in notifications panel
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                  | body                                                                                         | response code | response message | jsonPath                                                                             |
#      | application/json | raw   | false | Post         | settings/catalogs                                                    | ida/s3AvroPayloads/catalogs/CreateS3CatalogSC29.json                                         | 204           |                  |                                                                                      |
#      |                  |       |       | Put          | settings/analyzers/AvroS3Cataloger                                   | ida/s3AvroPayloads/PluginConfiguration/sc29AvroS3ConfigWithEmptyCredentialAndDataSource.json | 204           |                  |                                                                                      |
#      |                  |       |       | Get          | settings/analyzers/AvroS3Cataloger                                   |                                                                                              | 200           |                  | AvroS3CatalogerWithEmptyCredentialAndDataSource                                      |
#      |                  |       |       | Put          | settings/analyzers/AvroS3DataSource                                  | ida/s3AvroPayloads/DataSource/AvroS3EmptyDataSourceConfig.json                               | 204           |                  |                                                                                      |
#      |                  |       |       | Get          | settings/analyzers/AvroS3DataSource                                  |                                                                                              | 200           |                  | AvroS3EmptyDataSource                                                                |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AvroS3DataSource/* |                                                                                              | 200           | IDLE             | $.[?(@.configurationName=='AvroS3EmptyDataSource')].status                           |
#      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/AvroS3DataSource/*  | ida/s3AvroPayloads/empty.json                                                                | 200           |                  |                                                                                      |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AvroS3DataSource/* |                                                                                              | 200           | IDLE             | $.[?(@.configurationName=='AvroS3EmptyDataSource')].status                           |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/*    |                                                                                              | 200           | IDLE             | $.[?(@.configurationName=='AvroS3CatalogerWithEmptyCredentialAndDataSource')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/*     | ida/s3AvroPayloads/empty.json                                                                | 200           |                  |                                                                                      |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/*    |                                                                                              | 200           | IDLE             | $.[?(@.configurationName=='AvroS3CatalogerWithEmptyCredentialAndDataSource')].status |
#    And user clicks on notification icon
#    And "Analysis started!" notification should have content "Analysis AvroS3Cataloger on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis AvroS3Cataloger on LocalNode has failed:" in the notifications tab
#    And "Analysis started!" notification should have content "Analysis AvroS3DataSource on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis AvroS3DataSource on LocalNode has failed:" in the notifications tab
#    Then user clicks on exit button in notifications panel
#    And user select "All" catalog and search "S3AvroATSC29" items at top end
#    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
#      | Analysis |
#    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
#    And user performs "dynamic item click" on "cataloger" item from search results
#    And user click on Analysis log link in DATA widget section
#    Then user "verify analysis log contains" presence of "Required attribute Access key is blank" in Analysis Log of IDC UI
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/S3AvroATSC29"
#    Then Status code 204 must be returned
#    And user clicks on logout button
#
#
#  ####
#  @MLP-14874 @webtest
#  Scenario: SC33#-Verify the Analysis failed notification displayed in IDC UI when Avro S3 Datasource Plugin is Started with No Region(Region will be null in Json)
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user clicks on notification icon
#    When user clicks on mark all read button in the notifications tab
#    Then user clicks on exit button in notifications panel
#    Then Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                  | body                                                                           | response code | response message | jsonPath                                                          |
#      | application/json | raw   | false | Post         | settings/catalogs                                                    | ida/s3AvroPayloads/catalogs/CreateS3CatalogSC30.json                           | 204           |                  |                                                                   |
#      |                  |       |       | Put          | settings/analyzers/AvroS3DataSource                                  | ida/s3AvroPayloads/DataSource/AvroS3InvalidDataSourceWithNullRegionConfig.json | 204           |                  |                                                                   |
#      |                  |       |       | Get          | settings/analyzers/AvroS3DataSource                                  |                                                                                | 200           |                  | AvroS3DataSourceWithNoRegion                                      |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AvroS3DataSource/* |                                                                                | 200           | IDLE             | $.[?(@.configurationName=='AvroS3DataSourceWithNoRegion')].status |
#      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/AvroS3DataSource/*  | ida/s3AvroPayloads/empty.json                                                  | 200           |                  |                                                                   |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AvroS3DataSource/* |                                                                                | 200           | IDLE             | $.[?(@.configurationName=='AvroS3DataSourceWithNoRegion')].status |
#    When user clicks on notification icon
#    And "Analysis started!" notification should have content "Analysis AvroS3DataSource on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis AvroS3DataSource on LocalNode has failed:" in the notifications tab
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/S3AvroATSC30"
#    Then Status code 204 must be returned
#    And user clicks on logout button
#
#
#
#  ####
#  @MLP-14874 @webtest
#  Scenario: SC34#-Verify the Avro S3 Cataloger does not collect any items when an Datasource(with No Region) and Valid Credentials are used in the Plugin Configuration
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user clicks on notification icon
#    When user clicks on mark all read button in the notifications tab
#    Then user clicks on exit button in notifications panel
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                  | body                                                                                                  | response code | response message | jsonPath                                                          |
#      | application/json | raw   | false | Post         | settings/catalogs                                                    | ida/s3AvroPayloads/catalogs/CreateS3CatalogSC30.json                                                  | 204           |                  |                                                                   |
#      |                  |       |       | Put          | settings/analyzers/AvroS3Cataloger                                   | ida/s3AvroPayloads/PluginConfiguration/sc30AvroS3ConfigWithNoRregionDataSourceAndValidCredential.json | 204           |                  |                                                                   |
#      |                  |       |       | Get          | settings/analyzers/AvroS3Cataloger                                   |                                                                                                       | 200           |                  | AvroS3CatalogerWithNoRegion                                       |
#      |                  |       |       | Put          | settings/analyzers/AvroS3DataSource                                  | ida/s3AvroPayloads/DataSource/AvroS3InvalidDataSourceWithNullRegionConfig.json                        | 204           |                  |                                                                   |
#      |                  |       |       | Get          | settings/analyzers/AvroS3DataSource                                  |                                                                                                       | 200           |                  | AvroS3DataSourceWithNoRegion                                      |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AvroS3DataSource/* |                                                                                                       | 200           | IDLE             | $.[?(@.configurationName=='AvroS3DataSourceWithNoRegion')].status |
#      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/AvroS3DataSource/*  | ida/s3AvroPayloads/empty.json                                                                         | 200           |                  |                                                                   |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AvroS3DataSource/* |                                                                                                       | 200           | IDLE             | $.[?(@.configurationName=='AvroS3DataSourceWithNoRegion')].status |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/*    |                                                                                                       | 200           | IDLE             | $.[?(@.configurationName=='AvroS3CatalogerWithNoRegion')].status  |
#      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/*     | ida/s3AvroPayloads/empty.json                                                                         | 200           |                  |                                                                   |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/*    |                                                                                                       | 200           | IDLE             | $.[?(@.configurationName=='AvroS3CatalogerWithNoRegion')].status  |
#    And user clicks on notification icon
#    And "Analysis started!" notification should have content "Analysis AvroS3Cataloger on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis AvroS3Cataloger on LocalNode has failed:" in the notifications tab
#    And "Analysis started!" notification should have content "Analysis AvroS3DataSource on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis AvroS3DataSource on LocalNode has failed:" in the notifications tab
#    Then user clicks on exit button in notifications panel
#    And user select "All" catalog and search "S3AvroATSC30" items at top end
#    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
#      | Analysis |
#    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
#    And user performs "dynamic item click" on "cataloger" item from search results
#    And user click on Analysis log link in DATA widget section
#    Then user "verify analysis log contains" presence of "Required attribute Region is blank" in Analysis Log of IDC UI
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/S3AvroATSC30"
#    Then Status code 204 must be returned
#    And user clicks on logout button
#
#
#  ####
#  @MLP-14874 @webtest
#  Scenario: SC35#-Verify the Analysis failed notification displayed in IDC UI when Datasource Plugin is Started without Credentials in Datasource (Credentials will be null in Json)
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user clicks on notification icon
#    When user clicks on mark all read button in the notifications tab
#    Then user clicks on exit button in notifications panel
#    Then Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                  | body                                                                       | response code | response message | jsonPath                                                               |
#      | application/json | raw   | false | Post         | settings/catalogs                                                    | ida/s3AvroPayloads/catalogs/CreateS3CatalogSC31.json                       | 204           |                  |                                                                        |
#      |                  |       |       | Put          | settings/analyzers/AvroS3DataSource                                  | ida/s3AvroPayloads/DataSource/AvroS3NullCredentialsInDataSourceConfig.json | 204           |                  |                                                                        |
#      |                  |       |       | Get          | settings/analyzers/AvroS3DataSource                                  |                                                                            | 200           |                  | AvroS3NullCredentialsInDataSource                                      |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AvroS3DataSource/* |                                                                            | 200           | IDLE             | $.[?(@.configurationName=='AvroS3NullCredentialsInDataSource')].status |
#      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/AvroS3DataSource/*  | ida/s3AvroPayloads/empty.json                                              | 200           |                  |                                                                        |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AvroS3DataSource/* |                                                                            | 200           | IDLE             | $.[?(@.configurationName=='AvroS3NullCredentialsInDataSource')].status |
#    When user clicks on notification icon
#    And "Analysis started!" notification should have content "Analysis AvroS3DataSource on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis AvroS3DataSource on LocalNode has failed:" in the notifications tab
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/S3AvroATSC31"
#    Then Status code 204 must be returned
#    And user clicks on logout button


 ########################################################################UI VALDATION DATASORCE AND CREDENTIAL SET TO NULL ##################################################################################

  @cr-data @sanity @positive
  Scenario Outline:MLP-8708:SC#12 Run the Plugin configurations of AvroS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                               | body                                                                                    | response code | response message                  | jsonPath                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Cataloger                                | ida/s3AvroPayloads/PluginConfiguration/sc31AvroS3CatalogerConfigWithNullCredential.json | 204           |                                   |                                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Cataloger                                |                                                                                         | 200           | AvroS3CatalogerWithNullCredential |                                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                                                         | 200           | IDLE                              | $.[?(@.configurationName=='AvroS3CatalogerWithNullCredential')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/*  | ida/s3AvroPayloads/PluginConfiguration/empty.json                                       | 200           |                                   |                                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                                                         | 200           | IDLE                              | $.[?(@.configurationName=='AvroS3CatalogerWithNullCredential')].status |

  @sanity @positive @MLP-14874 @webtest @IDA-10.3
  Scenario:SC#12 Verify the Avro S3 Cataloger does not collect any items when Datasource or Credential value is null in Avro config
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "cataloger/AvroS3Cataloger/AvroS3CatalogerWithNullCredential" and clicks on search
    And user performs "facet selection" in "tagSC31Avro" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Analysis |
    Then Analysis log "cataloger/AvroS3Cataloger/AvroS3CatalogerWithNullCredential/%" should display below info/error/warning
      | type  | logValue                                                                                                       | logCode          |
      | ERROR | An error occurred while running Amazon S3 Avro Cataloger : AWS_S3-0010: Required attribute Credential is blank | AWS_S3_AVRO-0002 |

  @sanity @positive
  Scenario:SC#12:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                          | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AvroS3Cataloger/AvroS3CatalogerWithNullCredential/% | Analysis |       |       |

  @cr-data @sanity @positive
  Scenario Outline:MLP-8708:SC#12.1 Run the Plugin configurations of AvroS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                               | body                                                                           | response code | response message                  | jsonPath                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Cataloger                                | ida/s3AvroPayloads/PluginConfiguration/sc31AvroS3ConfigWithNullDataSource.json | 204           |                                   |                                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Cataloger                                |                                                                                | 200           | AvroS3CatalogerWithNullDataSource |                                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                                                | 200           | IDLE                              | $.[?(@.configurationName=='AvroS3CatalogerWithNullDataSource')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/*  | ida/s3AvroPayloads/PluginConfiguration/empty.json                              | 200           |                                   |                                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                                                | 200           | IDLE                              | $.[?(@.configurationName=='AvroS3CatalogerWithNullDataSource')].status |

  @sanity @positive @MLP-14874 @webtest @IDA-10.3
  Scenario:SC#12.1 Verify the Avro S3 Cataloger does not collect any items when Datasource or Credential value is null in Avro config_2
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "cataloger/AvroS3Cataloger/AvroS3CatalogerWithNullDataSource" and clicks on search
    And user performs "facet selection" in "tagSC31Avro2" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Analysis |
    Then Analysis log "cataloger/AvroS3Cataloger/AvroS3CatalogerWithNullDataSource/%" should display below info/error/warning
      | type  | logValue                                                                                                        | logCode          |
      | ERROR | An error occurred while running Amazon S3 Avro Cataloger : AWS_S3-0010: Required attribute Data Source is blank | AWS_S3_AVRO-0002 |

  @sanity @positive
  Scenario:SC#12.1:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                          | type      | query | param |
      | MultipleIDDelete | Default | cataloger/AvroS3Cataloger/AvroS3CatalogerWithNullDataSource/% | Analysis  |       |       |
      | MultipleIDDelete | Default | avroasgqatestautomation1                                      | Directory |       |       |

 ##########################################################################UI VALDATION ON TECHNOLOGY TAG ##################################################################################
  @aws
  Scenario: MLP-8708:SC#13 Create a bucket and folder with various file formats in S3 Amazon storage
    Given user "Create" a bucket "avroasgqatestautomation1" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName               | keyPrefix    | dirPath                      | recursive |
      | avroasgqatestautomation1 | AutoTestData | ida/s3AvroPayloads/TestData/ | true      |

  @cr-data @sanity @positive
  Scenario Outline:MLP-8708:SC#13 Run the Plugin configurations of AmazonS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                                  | response code | response message            | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3DataSource                               | ida/s3AvroPayloads/DataSource/AmazonS3andAvroS3DataSourceConfig.json  | 204           |                             |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3DataSource                               |                                                                       | 200           | AmazonS3andAvroS3DataSource |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                | ida/s3AvroPayloads/PluginConfiguration/sc35AmazonS3_AvroS3Config.json | 204           |                             |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                |                                                                       | 200           | AmazonS3Catalog             |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                                       | 200           | IDLE                        | $.[?(@.configurationName=='AmazonS3Catalog')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*  | ida/s3AvroPayloads/PluginConfiguration/empty.json                     | 200           |                             |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                                       | 200           | IDLE                        | $.[?(@.configurationName=='AmazonS3Catalog')].status |

  @cr-data @sanity @positive
  Scenario Outline:MLP-8708:SC#13 Run the Plugin configurations of AvroS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                               | body                                                             | response code | response message      | jsonPath                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3DataSource                               | ida/s3AvroPayloads/DataSource/AvroS3ValidDataSourceConfig.json   | 204           |                       |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3DataSource                               |                                                                  | 200           | AvroS3ValidDataSource |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Cataloger                                | ida/s3AvroPayloads/PluginConfiguration/sc35OnlyAvroS3Config.json | 204           |                       |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Cataloger                                |                                                                  | 200           | AvroS3Catalog         |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                                  | 200           | IDLE                  | $.[?(@.configurationName=='AvroS3Catalog')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/*  | ida/s3AvroPayloads/PluginConfiguration/empty.json                | 200           |                       |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                                  | 200           | IDLE                  | $.[?(@.configurationName=='AvroS3Catalog')].status |

  @sanity @positive @MLP-17683 @webtest @IDA-10.3 @MLPQA-18062 @MLPQA-18064
  Scenario: SC#13 Verify the technology tags got assigned to all S3 and Avro S3 catalogued items like Cluster,Service,Database...etc
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name      | facet         | Tag                              | fileName                 | userTag                  |
      | Default     | Directory | Metadata Type | tagSC35_S3_AvroS3,Amazon S3,Avro | avroasgqatestautomation1 | avroasgqatestautomation1 |
#      | Default     | Cluster   | Type  | tagSC35_S3_AvroS3,Amazon S3,Avro | amazonaws.com            | tagSC35_S3_AvroS3 |
      | Default     | Field     | Metadata Type | tagSC35_S3_AvroS3,Avro,Amazon S3 | emp_id                   | emp_id                   |
      | Default     | File      | Metadata Type | tagSC35_S3_AvroS3,Amazon S3,Avro | twitter.avro             | twitter.avro             |
#      | Default     | Service   | Type  | tagSC35_S3_AvroS3,Amazon S3,Avro | AmazonS3                 | tagSC35_S3_AvroS3 |

  @sanity @positive
  Scenario:SC#13:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                        | type      | query | param |
      | MultipleIDDelete | Default | cataloger/AvroS3Cataloger/AvroS3Cataloger/% | Analysis  |       |       |
      | MultipleIDDelete | Default | avroasgqatestautomation1                    | Directory |       |       |

 ##########################################################################UI VALDATION INVALID CREDENTIAL##################################################################################

  @MLP-8708 @webtest
  Scenario: SC#14 Verify the Avro S3 Cataloger does not collect any items when using invalid Credential
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                               | body                                                         | response code | response message | jsonPath                                           |
      | application/json |       |       | Put          | settings/analyzers/AvroS3Cataloger                                | ida/s3AvroPayloads/PluginConfiguration/sc36AvroS3Config.json | 204           |                  |                                                    |
      |                  |       |       | Get          | settings/analyzers/AvroS3Cataloger                                |                                                              | 200           | AvroS3Catalog    |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                              | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Catalog')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/*  | ida/s3AvroPayloads/PluginConfiguration/empty.json            | 200           |                  |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                              | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Catalog')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "cataloger/AvroS3Cataloger/AvroS3Catalog" and clicks on search
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Analysis |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/AvroS3Cataloger/AvroS3Catalog%"
    And the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 4             | Description |
    And user "widget presence" on "Processed Items" in Item view page
    Then Analysis log "cataloger/AvroS3Cataloger/AvroS3Catalog/%" should display below info/error/warning
      | type  | logValue                                                     | logCode     |
      | ERROR | AWS Access Key Id you provided does not exist in our records | AWS_S3-0011 |

  @sanity @positive
  Scenario:SC#14:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                      | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AvroS3Cataloger/AvroS3Catalog/% | Analysis |       |       |

########################################################################UI VALDATION INVALID BUCKET ##################################################################################

  @MLP-8708 @webtest
  Scenario: SC#15 Verify the Avro S3 Cataloger does not collect any items when using Invalid Bucket
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                               | body                                                         | response code | response message | jsonPath                                           |
      | application/json |       |       | Put          | settings/analyzers/AvroS3Cataloger                                | ida/s3AvroPayloads/PluginConfiguration/sc37AvroS3Config.json | 204           |                  |                                                    |
      |                  |       |       | Get          | settings/analyzers/AvroS3Cataloger                                |                                                              | 200           | AvroS3Catalog    |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                              | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Catalog')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/*  | ida/s3AvroPayloads/PluginConfiguration/empty.json            | 200           |                  |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                              | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Catalog')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "cataloger/AvroS3Cataloger/AvroS3Catalog" and clicks on search
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Analysis |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/AvroS3Cataloger/AvroS3Catalog%"
    And the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 1             | Description |
    And user "widget presence" on "Processed Items" in Item view page
    Then Analysis log "cataloger/AvroS3Cataloger/AvroS3Catalog/%" should display below info/error/warning
      | type | logValue                        | logCode | pluginName | removableText |
      | INFO | No S3 data available to catalog |         |            |               |

  @sanity @positive
  Scenario:SC#15:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                      | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AvroS3Cataloger/AvroS3Catalog/% | Analysis |       |       |

  ########################################################################UI VALDATION INVALID DIRECTORY ##################################################################################

  @MLP-8708 @webtest
  Scenario: SC#16 Verify the Avro S3 Cataloger does not collect any items when using Valid Bucket and Invalid directory
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                               | body                                                         | response code | response message | jsonPath                                           |
      | application/json |       |       | Put          | settings/analyzers/AvroS3Cataloger                                | ida/s3AvroPayloads/PluginConfiguration/sc38AvroS3Config.json | 204           |                  |                                                    |
      |                  |       |       | Get          | settings/analyzers/AvroS3Cataloger                                |                                                              | 200           | AvroS3Catalog    |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                              | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Catalog')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/*  | ida/s3AvroPayloads/PluginConfiguration/empty.json            | 200           |                  |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                              | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Catalog')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "cataloger/AvroS3Cataloger/AvroS3Catalog" and clicks on search
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Analysis |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/AvroS3Cataloger/AvroS3Catalog%"
    And the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 1             | Description |
    And user "widget presence" on "Processed Items" in Item view page
    Then Analysis log "cataloger/AvroS3Cataloger/AvroS3Catalog/%" should display below info/error/warning
      | type | logValue                        | logCode | pluginName | removableText |
      | INFO | No S3 data available to catalog |         |            |               |

  @sanity @positive
  Scenario:SC#16:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                        | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AvroS3Cataloger/AvroS3Cataloger/% | Analysis |       |       |

  ########################################################################UI VALDATION INCREMENTAL - Cataloged at verification ##################################################################################

  @aws
  Scenario:SC#17 Delete the version bucket in Amazon S3 storage
    Given user "Delete Version" objects in amazon directory "AutoTestData" in bucket "avroasgqatestautomation1"
    Then user "Delete" a bucket "avroasgqatestautomation1" in amazon storage service

  @aws
  Scenario: MLP-8708:SC#17 Create Bucket for AvroS3Cataloger
    Given user "Create" a bucket "avroasgqatestautomation1" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName               | keyPrefix             | dirPath                              | recursive |
      | avroasgqatestautomation1 | AutoTestData/TestAvro | ida/s3AvroPayloads/TestData/TestAvro | true      |

  Scenario Outline:MLP-8708:SC#17 Run the Plugin configurations of AvroS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                               | body                                                                        | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Cataloger                                | ida/s3AvroPayloads/PluginConfiguration/s16AvroS3ConfigIncrementalFalse.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Cataloger                                |                                                                             | 200           | AvroS3Cataloger  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                                             | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/*  | ida/s3AvroPayloads/PluginConfiguration/empty.json                           | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                                             | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |

  @webtest  @sanity @positive @MLP-8708 @IDA-10.0 @MLPQA-12098
  Scenario: MLP-8708:SC#17 Run AvroS3 cataloger for the first time and save the last Cataloged Time
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagSC16Avro" and clicks on search
    And user performs "facet selection" in "tagSC16Avro" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | File      | 8     |
    And user performs "item click" on "employee.avro" item from search results
    And user "store" the value of item "employee.avro" of attribute "Last catalogued at" with temporary text
    And user "store as Static" the value of item "employee.avro" of attribute "Last catalogued at" with temporary text
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName               | keyPrefix                         | dirPath                                 | recursive |
      | avroasgqatestautomation1 | AutoTestData/TestAvro/Incremental | ida/s3AvroPayloads/TestData/Incremental | false     |

  Scenario Outline:MLP-8708:SC#17 Re-Run the Plugin configurations of AvroS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                               | body                                              | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                   | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/*  | ida/s3AvroPayloads/PluginConfiguration/empty.json | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/* |                                                   | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |

  @webtest  @sanity @positive @MLP-8708 @IDA-10.0 @MLPQA-11384
  Scenario: MLP-8708:SC#17 Verify incremental scan works properly with AvroS3Cataloger for newly added file
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagSC16Avro" and clicks on search
    And user performs "facet selection" in "tagSC16Avro" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | File      | 9     |
    And user performs "item click" on "incremental.avro" item from search results
    Then user "verify not equals" the value of item "incremental.avro" of attribute "Last catalogued at" with temporary text

  @sanity @positive
  Scenario:SC#17:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                        | type                | query | param |
      | MultipleIDDelete | Default | cataloger/AvroS3Cataloger/% | Analysis            |       |       |
      | MultipleIDDelete | Default | avroasgqatestautomation1    | Directory           |       |       |
      | MultipleIDDelete | Default | amazonaws.com               | Cluster             |       |       |
      | MultipleIDDelete | Default | AmazonS3                    | Service             |       |       |
      | SingleItemDelete | Default | test_BA_AvroS3              | BusinessApplication |       |       |

  @MLP-14874 @webtest
  Scenario: SC#18 Verify whether the background of the panel is displayed in red when test connection is not successful for AvroS3DataSource in LocalNode for disabled/unsupported region
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user performs following actions in the sidebar
      | actionType | actionItem                                         |
      | click      | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute        |
      | Data Source Type | AvroS3DataSource |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute             |
      | Name*     | AvroS3DataSourceTest3 |
      | Label     | AvroS3DataSourceTest3 |
    And user "select dropdown" in Add Data Source Page
      | fieldName   | attribute                        |
      | Region*     | China (Ningxia) [cn-northwest-1] |
      | Credential* | ValidAVROCredentials             |
      | Node        | LocalNode                        |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "No connection with data source - Error retrieving bucket list" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"
    And user "select dropdown" in Add Data Source Page
      | fieldName | attribute                       |
      | Region*   | Africa (Cape Town) [af-south-1] |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "No connection with data source - Error retrieving bucket list" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"
    And user "select dropdown" in Add Data Source Page
      | fieldName | attribute                                   |
      | Region*   | Asia Pacific (Osaka-Local) [ap-northeast-3] |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "No connection with data source - Cannot create enum from ap-northeast-3 value!" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"


########################################################################DELETING CONFIGURATION##################################################################################
  @aws
  Scenario:MLP-8708:SC#19 Delete the avroasgqatestautomation1 bucket in Amazon S3 storage
    Given user "Delete" objects in amazon directory "AutoTestData" in bucket "avroasgqatestautomation1"
    Then user "Delete" a bucket "avroasgqatestautomation1" in amazon storage service


  @cr-data @sanity @positive
  Scenario Outline:SC#19 Delete Configurations
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                               | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AvroS3Cataloger                |      | 204           |                  |          |
#      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AmazonS3Cataloger/AmazonS3Catalog              |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AvroS3DataSource         |      | 204           |                  |          |
#      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AmazonS3DataSource/AmazonS3andAvroS3DataSource |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ValidAVROCredentials                         |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/IncorrectAVROCredentials                     |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/EmptyAVROCredentials                         |      | 200           |                  |          |
