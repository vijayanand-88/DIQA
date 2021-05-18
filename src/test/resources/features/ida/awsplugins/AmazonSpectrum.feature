@amazonSpectrum
Feature:AmazonSpectrum: verification of AmazonSpectrum IDA Plugin

  #AmazonSpectrum
  #Testid - 6822687 - Verify the Analysis succeeded notification displayed in IDC UI when the analysis plugin executed without any errors - Valid Amazon Redshift spectrum DataSource connectivity details
  #Testid - 6822683 - Verify if the user is able to set the credentials using the API Call "settings/credentials/'credentialsName'" for Amazon Spectrum Datasource
#
  @precondition
  Scenario: MLP-1960:SC1#Update credential payload json for Amazon Redshift
    Given User update the below "redshift credentials" in following files using json path
      | filePath                                           | username    | password    |
      | ida/AmazonSpectrumPayloads/CredentialsSuccess.json | $..userName | $..password |

  Scenario Outline:SC# Configure credentials for Amazon Spectrum
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                             | body                                                   | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/Spectrum_Credentials       | ida/AmazonSpectrumPayloads/CredentialsSuccess.json     | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/Spectrum_Credentials       |                                                        | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/SpectrumInvalidCredentials | ida/AmazonSpectrumPayloads/InvalidCredentials.json     | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/SpectrumEDIBusCredential   | ida/AmazonSpectrumPayloads/EDIBusValidCredentials.json | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/SpectrumEDIBusCredential   |                                                        | 200           |                  |          |

  Scenario Outline:SC#Configure Data source for Amazon Spectrum
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                         | body                                                            | response code | response message   | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/AmazonSpectrumDataSource | ida/AmazonSpectrumPayloads/AmazonSpectromDatasource_Config.json | 204           |                    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/AmazonSpectrumDataSource |                                                                 | 200           | SpectrumDS         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/AWS_Amazon_Credentials | ida/AmazonSpectrumPayloads/Amzons3Credentials.json              | 200           |                    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/AWS_Amazon_Credentials |                                                                 | 200           |                    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/AmazonS3DataSource       | ida/AmazonSpectrumPayloads/AmazonS3DataSourceConfig.json        | 204           |                    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/AmazonS3DataSource       |                                                                 | 200           | AmazonS3DataSource |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/Redshift_Credentials   | ida/AmazonSpectrumPayloads/AmazonRedshiftCredentials.json       | 200           |                    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/Redshift_Credentials   |                                                                 | 200           |                    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Post | items/Default/root                          | ida/AmazonSpectrumPayloads/businessApplication.json             | 200           |                    |          |

#
#    #######################################UIField Validations###########################################
  @redshift @webtest @negative
  Scenario:SC1#Verify whether the background of the panel is displayed in red when connection is unsuccessful due to invalid / Empty credentials in Local Node
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Data Sources" in "Add Data source Configuration"
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data source Configuration"
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute                |
      | Data Source Type | AmazonSpectrumDataSource |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute                                                                                      |
      | Name      | SpectrumDS_Test                                                                                |
      | Label     | SpectrumDS_Test                                                                                |
      | URL       | jdbc:redshift://redshift-cluster-1.csvp5wcqqxvw.us-edieast-1.redshift.amazonaws.com:5439/world |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute                  |
      | Credential | SpectrumInvalidCredentials |
      | Node       | LocalNode                  |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Failed datasource connection" is "displayed" in "Add Data Sources Page"


  @positve @regression @sanity @webtest
  Scenario:SC2#Verify whether the background of the panel is displayed in green when connection is successful in Step1 pop up when user logs in for the first time in Local Node
               Verify captions  text in SpectrumDataSource

    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Data Sources" in "Add Data source Configuration"
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data Sources Page"
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute                |
      | Data Source Type | AmazonSpectrumDataSource |
    And user should scroll to the left of the screen
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Data Source Type*     |
      | Name*                 |
      | Label                 |
      | URL*                  |
      | Driver Bundle Name*   |
      | Driver Bundle Version |
      | Driver Name           |
      | Credential*           |
      | Node                  |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute                                                                                   |
      | Name      | SpectrumDS_Test                                                                             |
      | Label     | SpectrumDS_Test                                                                             |
      | URL       | jdbc:redshift://redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com:5439/world |
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute            |
      | Credential | Spectrum_Credentials |
      | Node       | LocalNode            |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Successful datasource connection" is "displayed" in "Add Data Sources Page"
    And user "click" on "Save" button in "Add Data Sources Page"


  @webtest
  Scenario:SC3# Verify captions text in SpectrumCataloger
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Add Data source Configuration"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute               |
      | Type      | Cataloger               |
      | Plugin    | AmazonSpectrumCataloger |
    And user should scroll to the left of the screen
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Type*                |
      | Plugin*              |
      | Name*                |
      | Business Application |
      | Data Source*         |
      | Credential*          |


  @webtest
  Scenario:SC4# Verify captions text in SpectrumAnalyzer
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Add Data source Configuration"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute              |
      | Type      | Dataanalyzer           |
      | Plugin    | AmazonSpectrumAnalyzer |
    And user should scroll to the left of the screen
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Type*                |
      | Plugin*              |
      | Name*                |
      | Business Application |
      | Host name*           |
      | Database Name*       |


  @webtest
  Scenario:SC5#Verify captions text in SpectrumLinker
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Add Data source Configuration"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute            |
      | Type      | Linker               |
      | Plugin    | AmazonSpectrumLinker |
    And user should scroll to the left of the screen
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Type*                |
      | Plugin*              |
      | Name*                |
      | Business Application |
      | Host name*           |
      | Database Name*       |
      | AWS Region*          |

    ###########################################EDIBus##########################################################
  Scenario Outline:SC#6_Run the Plugin configurations for Amazon Spectrum Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                       | body                                                        | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumCataloger                                | ida/AmazonSpectrumPayloads/SpectrumCataloger_no_filter.json | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumCataloger                                |                                                             | 200           | AmazonSpectrumCataloger |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/* |                                                             | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonSpectrumCataloger/*  | ida/AmazonSpectrumPayloads/empty.json                       | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/* |                                                             | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |

#        #6549303
#  @sanity @positive @webtest @edibus
#  Scenario:SC#2_MLP-9043_Verify the Amazon Redshift Spectrum items are replicated to EDI
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "SpecCataloger" and clicks on search
#    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Redshift Spectrum" attribute under "Tags" facets in Item Search results page
#    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
#      | Column   |
#      | Table    |
#      | Schema   |
#      | Analysis |
#      | Cluster  |
#      | Database |
#      | Host     |
#      | Service  |
#    And user connects Rochade Server and "clears" the items in EDI subject area
#      | databaseName | subjectArea  | subjectAreaVersion | query                                      |
#      | AP-DATA      | REDSHIFTSPEC | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
#    And user update json file "idc/EdiBusPayloads/AmazonSpectrumConfig.json" file for following values using property loader
#      | jsonPath                                           | jsonValues    |
#      | $..configurations[-1:].['EDI access'].['EDI host'] | EDIHostName   |
#      | $..configurations[-1:].['EDI access'].['EDI port'] | EDIPortNumber |
#    And configure a new REST API for the service "IDC"
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                       | body                                                  | response code | response message | jsonPath                                                  |
#      | application/json |       |       | Put          | settings/analyzers/EDIBusDataSource                                       | ida/AmazonSpectrumPayloads/spectrumedidatasource.json | 204           |                  |                                                           |
#      |                  |       |       | Put          | settings/analyzers/EDIBus                                                 | idc/EdiBusPayloads/AmazonSpectrumConfig.json          | 204           |                  |                                                           |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusAmazonSpectrum |                                                       | 200           | IDLE             | $.[?(@.configurationName=='EDIBusAmazonSpectrum')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusAmazonSpectrum  |                                                       | 200           |                  |                                                           |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusAmazonSpectrum |                                                       | 200           | IDLE             | $.[?(@.configurationName=='EDIBusAmazonSpectrum')].status |
#    And user enters the search text "EDIBusAmazonSpectrum" and clicks on search
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusAmazonSpectrum%"
#    And METADATA widget should have following item values
#      | metaDataItem     | metaDataItemValue |
#      | Number of errors | 0                 |
#    And user enters the search text "SpecCataloger" and clicks on search
#    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Redshift Spectrum" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea  | subjectAreaVersion | query                                                                     |
#      | AP-DATA      | REDSHIFTSPEC | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DATABASE) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                                    |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Cloud Data/Cloud Data Warehouses/Redshift Spectrum |
#      | $..selections.['type_s'][*]                   | Database                                                      |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                          | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=SpecCataloger&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea  | subjectAreaVersion | query                                                                      |
#      | AP-DATA      | REDSHIFTSPEC | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DATABASE ) |
#    And user enters the search text "SpecCataloger" and clicks on search
#    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Redshift Spectrum" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Schema" attribute under "Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea  | subjectAreaVersion | query                                                                   |
#      | AP-DATA      | REDSHIFTSPEC | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_SCHEMA) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                                    |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Cloud Data/Cloud Data Warehouses/Redshift Spectrum |
#      | $..selections.['type_s'][*]                   | Schema                                                        |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                          | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=SpecCataloger&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea  | subjectAreaVersion | query                                                                    |
#      | AP-DATA      | REDSHIFTSPEC | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_SCHEMA ) |
#    And user enters the search text "SpecCataloger" and clicks on search
#    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Redshift Spectrum" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea  | subjectAreaVersion | query                                                                          |
#      | AP-DATA      | REDSHIFTSPEC | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_TABLE_OR_VIEW) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                                    |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Cloud Data/Cloud Data Warehouses/Redshift Spectrum |
#      | $..selections.['type_s'][*]                   | Table                                                         |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                          | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=SpecCataloger&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea  | subjectAreaVersion | query                                                                           |
#      | AP-DATA      | REDSHIFTSPEC | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_TABLE_OR_VIEW ) |
#    And user enters the search text "SpecCataloger" and clicks on search
#    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Redshift Spectrum" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Column" attribute under "Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea  | subjectAreaVersion | query                                                                   |
#      | AP-DATA      | REDSHIFTSPEC | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_COLUMN) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                                    |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Cloud Data/Cloud Data Warehouses/Redshift Spectrum |
#      | $..selections.['type_s'][*]                   | Column                                                        |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                          | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=SpecCataloger&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea  | subjectAreaVersion | query                                                                    |
#      | AP-DATA      | REDSHIFTSPEC | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_COLUMN ) |
#    And user enters the search text "SpecCataloger" and clicks on search
#    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Redshift Spectrum" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Service" attribute under "Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea  | subjectAreaVersion | query                                                                      |
#      | AP-DATA      | REDSHIFTSPEC | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DB_SYSTEM) |
#    And user connects Rochade Server and "verify itemCount notNull" the items in EDI subject area
#      | databaseName | subjectArea  | subjectAreaVersion | query                                                                                         |
#      | AP-DATA      | REDSHIFTSPEC | 1.0                | (XNAME * *  ~/ @*Redshift@ Spectrum≫DEFAULT≫DWR_RDB_COLUMN≫@* ) ,AND,( TYPE = DWR_IDC )       |
#      | AP-DATA      | REDSHIFTSPEC | 1.0                | (XNAME * *  ~/ @*Redshift@ Spectrum≫DEFAULT≫DWR_RDB_TABLE_OR_VIEW≫@* ),AND,( TYPE = DWR_IDC ) |
#      | AP-DATA      | REDSHIFTSPEC | 1.0                | (XNAME * *  ~/ @*Redshift@ Spectrum≫DEFAULT≫DWR_RDB_DATABASE≫@* ),AND,( TYPE = DWR_IDC )      |
#      | AP-DATA      | REDSHIFTSPEC | 1.0                | (XNAME * *  ~/ @*Redshift@ Spectrum≫DEFAULT≫DWR_RDB_DB_SYSTEM≫@* ),AND,( TYPE = DWR_IDC )     |


  #6528369#
  @amazonSpectrum @positve @regression @sanity @webtest
  Scenario:SC#6_Verify Spectrum cataloger scans and collects data if schema name and table names are not provided in filters and Log enhancement and the Processed Items are Verified
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName | dataBaseType | queryPath     | queryPage                      | queryField          | columnName        | queryOperation | facet         | facetValue | count      |
      | REDSHIFT     | STRUCTURED   | json/IDA.json | AmazonSpectrumCatalogerQueries | getSchemaTableCount | count(schemaname) | returnValue    | Metadata Type | Table      | fromSource |
      | REDSHIFT     | STRUCTURED   | json/IDA.json | AmazonSpectrumCatalogerQueries | getSchemaCount      | count(schemaname) | returnValue    | Metadata Type | Schema     | fromSource |
      |              |              |               |                                |                     |                   |                | Metadata Type | Cluster    | 1          |
      |              |              |               |                                |                     |                   |                | Metadata Type | Host       | 1          |
      |              |              |               |                                |                     |                   |                | Metadata Type | Service    | 1          |
      |              |              |               |                                |                     |                   |                | Metadata Type | Database   | 1          |
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | spectrum      |
      | spectrumtest  |
      | spectrum_demo |
    And user performs "item click" on "spectrum" item from search results
    Then user performs click and verify in new window
      | Table  | value | Action                 | RetainPrevwindow | indexSwitch |
      | Tables | city  | verify widget contains | No               |             |
      | Tables | city  | click and switch tab   | No               |             |
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/AmazonSpectrumCataloger/AmazonSpectrumCataloger%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 2             | Description |
      | Number of errors          | 0             | Description |
    And user "verifies tab section values" has the following values in "Processed Items" Tab in Item View page
      | AmazonRedshiftSpectrum                                           |
      | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com |


    #6528496# #6528499# #6528497# #6528498# #6528500#
  @amazonSpectrum @positve @regression @sanity @webtest
  Scenario:SC#7_Verify the Table Name should have the appropriate metadata information in IDC UI and Database
  Verify the Database Name should have the appropriate metadata information in IDC UI and Database
  Verify the Service should have the appropriate metadata information in IDC UI and Database
  Verify the Host should have the appropriate metadata information in IDC UI and Database
  Verify the column Name should have the appropriate metadata information in IDC UI and Database

    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "city3" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "city3" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | EXTERNAL      | Description |
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "world" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue        | widgetName  |
      | Storage type      | PostgreSQL08.00.0002 | Description |
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Service" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "AmazonRedshiftSpectrum" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute   | metaDataValue        | widgetName  |
      | Application Version | PostgreSQL08.00.0002 | Description |
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Host" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                                    | widgetName  |
      | Number of cores   | 0                                                                | Statistics  |
      | Host name         | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Description |
    And user enters the search text "city3" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "id" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | INTEGER       | Description |



    ##6528657##
  @amazonSpectrum @positve @regression @sanity @webtest
  Scenario:SC#9_Verify the Technology tag  and Business Application tag appears properly for items collected by SpectrumCataloger
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Cluster" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "SpecCataloger,Redshift Spectrum,Spectrum_BA" should get displayed for the column "redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com"
    And user performs "facet selection" in "Cluster" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "Host" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "SpecCataloger,Redshift Spectrum,Spectrum_BA" should get displayed for the column "redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com"
    And user performs "facet selection" in "Host" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "SpecCataloger,Redshift Spectrum,Spectrum_BA" should get displayed for the column "cataloger/AmazonSpectrumCataloger"
    And user enters the search text "city4" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "SpecCataloger,Redshift Spectrum,Spectrum_BA" should get displayed for the column "name"
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "SpecCataloger,Redshift Spectrum,Spectrum_BA" should get displayed for the column "city4"
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name     | facet         | Tag                                         | fileName               | userTag       |
      | Default     | Schema   | Metadata Type | SpecCataloger,Redshift Spectrum,Spectrum_BA | spectrumtest           | SpecCataloger |
      | Default     | Service  | Metadata Type | SpecCataloger,Redshift Spectrum,Spectrum_BA | AmazonRedshiftSpectrum | SpecCataloger |
      | Default     | Database | Metadata Type | SpecCataloger,Redshift Spectrum,Spectrum_BA | world                  | SpecCataloger |
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name    | facet         | Tag                              | fileName                                                         | userTag       |
      | Default     | Cluster | Metadata Type | Cloud Data,Cloud Data Warehouses | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | SpecCataloger |
      | Default     | Service | Metadata Type | Cloud Data,Cloud Data Warehouses | AmazonRedshiftSpectrum                                           | SpecCataloger |
      | Default     | Host    | Metadata Type | Cloud Data,Cloud Data Warehouses | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | SpecCataloger |


  @sanity @positive
  Scenario:SC09#user retrieves the total items for a catalog and copy to a json file
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonSpectrumCataloger/%                              | Analysis |       |       |
#      | MultipleIDDelete | Default | bulk/EDIBus/%                                                    | Analysis |       |       |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |


      ###############################6528906_SingleSchema_MultipleTables########################################3##
  Scenario Outline:SC#10_Run the Plugin configurations for Amazon Spectrum Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                       | body                                                                                          | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumCataloger                                | ida/AmazonSpectrumPayloads/AmazonSpectrumCataloger_with_single_schema_and_multiple_table.json | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumCataloger                                |                                                                                               | 200           | AmazonSpectrumCataloger |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/* |                                                                                               | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonSpectrumCataloger/*  | ida/AmazonSpectrumPayloads/empty.json                                                         | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/* |                                                                                               | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |

    ##6528906##
  @amazonSpectrum @positve @regression @sanity @webtest
  Scenario:SC#10_Verify Spectrum Cataloger collects data if single schema name with multiple table names are provided as filter in Spectrum Cataloger
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Schema    | 1     |
      | Table     | 2     |
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | city  |
      | city2 |
    Then user performs "item click" on "city2" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | EXTERNAL      | Description |


  @sanity @positive
  Scenario:SC10#user retrieves the total items for a catalog and copy to a json file
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonSpectrumCataloger/%                              | Analysis |       |       |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |

    #####################################6528908_Schema_nameandtable_name_in_filter##############################################

  Scenario Outline:SC#11_Run the Plugin configurations for Amazon Spectrum Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                       | body                                                                                        | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumCataloger                                | ida/AmazonSpectrumPayloads/AmazonSpectrumCataloger_with_single_schema_and_single_table.json | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumCataloger                                |                                                                                             | 200           | AmazonSpectrumCataloger |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/* |                                                                                             | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonSpectrumCataloger/*  | ida/AmazonSpectrumPayloads/empty.json                                                       | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/* |                                                                                             | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |

  @amazonSpectrum @positve @regression @sanity @webtest
  Scenario:SC#11_Verify Spectrum Cataloger collects data if schema name and table name are provided in Spectrum cataloger filters
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Schema    | 1     |
      | Table     | 1     |
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | city |
    Then user performs "item click" on "city" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | EXTERNAL      | Description |

  @sanity @positive
  Scenario:SC11#user retrieves the total items for a catalog and copy to a json file
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonSpectrumCataloger/%                              | Analysis |       |       |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |

    ###################################6528909_Schema_name_alone################################
  Scenario Outline:SC#12_Run the Plugin configurations for Amazon Spectrum Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                       | body                                                                       | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumCataloger                                | ida/AmazonSpectrumPayloads/AmazonSpectrumCataloger_with_single_schema.json | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumCataloger                                |                                                                            | 200           | AmazonSpectrumCataloger |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/* |                                                                            | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonSpectrumCataloger/*  | ida/AmazonSpectrumPayloads/empty.json                                      | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/* |                                                                            | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |

  @amazonSpectrum @positve @regression @sanity @webtest
  Scenario:SC#12_Verify Spectrum cataloger collects data if schema name alone is provided in Spectrum cataloger filters
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Schema    | 1     |
      | Table     | 41    |
    And user performs "facet selection" in "Schema" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "spectrum" item from search results
    Then user performs click and verify in new window
      | Table  | value | Action                 | RetainPrevwindow | indexSwitch |
      | Tables | city  | verify widget contains | No               |             |
      | Tables | city  | click and switch tab   | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | EXTERNAL      | Description |
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "city1" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | EXTERNAL      | Description |
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "city2" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | EXTERNAL      | Description |

  @sanity @positive
  Scenario:SC12#user retrieves the total items for a catalog and copy to a json file
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonSpectrumCataloger/%                              | Analysis |       |       |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |

    ########################################dry_run####################################################
  @webtest
  Scenario:SC#13Verify the Dry run feature for the Spectrum Cataloger
    Given user "update" the json file "ida/AmazonSpectrumPayloads/SpectrumCataloger_dryrun.json" file for following values
      | jsonPath  | jsonValues | type    |
      | $..dryRun | true       | boolean |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                       | body                                                     | response code | response message | jsonPath                                                           |
      | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumCataloger                                | ida/AmazonSpectrumPayloads/SpectrumCataloger_dryrun.json | 204           |                  |                                                                    |
      |                  |       |       | Get          | settings/analyzers/AmazonSpectrumCataloger                                |                                                          | 200           |                  | AmazonSpectrumCatalogerDryRun                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/* |                                                          | 200           | IDLE             | $.[?(@.configurationName=='AmazonSpectrumCatalogerDryRun')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonSpectrumCataloger/*  | ida/AmazonSpectrumPayloads/empty.json                    | 200           |                  |                                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/* |                                                          | 200           | IDLE             | $.[?(@.configurationName=='AmazonSpectrumCatalogerDryRun')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/AmazonSpectrumCataloger/AmazonSpectrumCatalogerDryRun%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 0             | Description |
    And user "widget not present" on "Processed Items" in Item view page
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "cataloger/AmazonSpectrumCataloger/AmazonSpectrumCatalogerDryRun%" should display below info/error/warning
      | type | logValue                                                                                           | logCode       | pluginName              | removableText |
      | INFO | Plugin AmazonSpectrumCataloger running on dry run mode                                             | ANALYSIS-0069 | AmazonSpectrumCataloger |               |
      | INFO | Plugin AmazonSpectrumCataloger processed 2 items on dry run mode and not written to the repository | ANALYSIS-0070 | AmazonSpectrumCataloger |               |
      | INFO | Plugin completed                                                                                   | ANALYSIS-0020 |                         |               |


  @sanity @positive
  Scenario:SC13#user retrieves the total items for a catalog and copy to a json file
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonSpectrumCataloger/%                              | Analysis |       |       |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |

    ##########################################################################################
  @webtest
  Scenario:SC#14 Verify the Dry run feature for the Spectrum linker
    And user "update" the json file "ida/AmazonSpectrumPayloads/SpectrumCataloger_dryrun.json" file for following values
      | jsonPath  | jsonValues | type    |
      | $..dryRun | false      | boolean |
    And user "update" the json file "ida/AmazonSpectrumPayloads/AmazonSpectrumLinker_dryrun.json" file for following values
      | jsonPath  | jsonValues | type    |
      | $..dryRun | true       | boolean |
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                       | body                                                            | response code | response message | jsonPath                                                           |
      | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumCataloger                                | ida/AmazonSpectrumPayloads/SpectrumCataloger_dryrun.json        | 204           |                  |                                                                    |
      |                  |       |       | Get          | settings/analyzers/AmazonSpectrumCataloger                                |                                                                 | 200           |                  | AmazonSpectrumCatalogerDryRun                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/* |                                                                 | 200           | IDLE             | $.[?(@.configurationName=='AmazonSpectrumCatalogerDryRun')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonSpectrumCataloger/*  | ida/AmazonSpectrumPayloads/empty.json                           | 200           |                  |                                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/* |                                                                 | 200           | IDLE             | $.[?(@.configurationName=='AmazonSpectrumCatalogerDryRun')].status |
      |                  |       |       | Put          | settings/analyzers/AmazonS3Cataloger                                      | ida/AmazonSpectrumPayloads/AmazonS3Cataloger_Configuration.json | 204           |                  |                                                                    |
      |                  |       |       | Get          | settings/analyzers/AmazonS3Cataloger                                      |                                                                 | 200           |                  | AmazonS3Cataloger                                                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/*       |                                                                 | 200           | IDLE             | $.[?(@.configurationName=='AmazonS3Cataloger')].status             |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*        | ida/AmazonSpectrumPayloads/empty.json                           | 200           |                  |                                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/*       |                                                                 | 200           | IDLE             | $.[?(@.configurationName=='AmazonS3Cataloger')].status             |
      |                  |       |       | Put          | settings/analyzers/AmazonSpectrumLinker                                   | ida/AmazonSpectrumPayloads/AmazonSpectrumLinker_dryrun.json     | 204           |                  |                                                                    |
      |                  |       |       | Get          | settings/analyzers/AmazonSpectrumLinker                                   |                                                                 | 200           |                  | AmazonSpectrumLinkerDryRun                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AmazonSpectrumLinker/*       |                                                                 | 200           | IDLE             | $.[?(@.configurationName=='AmazonSpectrumLinkerDryRun')].status    |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/linker/AmazonSpectrumLinker/*        | ida/AmazonSpectrumPayloads/empty.json                           | 200           |                  |                                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AmazonSpectrumLinker/*       |                                                                 | 200           | IDLE             | $.[?(@.configurationName=='AmazonSpectrumLinkerDryRun')].status    |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SpecLinker" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "linker/AmazonSpectrumLinker/AmazonSpectrumLinkerDryRun%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 0             | Description |
    And user "widget not present" on "Processed Items" in Item view page
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "linker/AmazonSpectrumLinker/AmazonSpectrumLinkerDryRun%" should display below info/error/warning
      | type | logValue                                                                                        | logCode       | pluginName           | removableText |
      | INFO | Plugin AmazonSpectrumLinker running on dry run mode                                             | ANALYSIS-0069 | AmazonSpectrumLinker |               |
      | INFO | Plugin AmazonSpectrumLinker processed 2 items on dry run mode and not written to the repository | ANALYSIS-0070 | AmazonSpectrumLinker |               |
      | INFO | Plugin completed                                                                                | ANALYSIS-0020 |                      |               |


  Scenario Outline:SC#14 user retrieves the total items for a catalog and copy to a json file for SpectrumLinker dry run
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                             | type      | targetFile                                    | jsonpath                    |
      | APPDBPOSTGRES | Default | cataloger/AmazonSpectrumCataloger/%DYN                           |           | response/amazonSpectrum/actual/itemIds.json   | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | linker/AmazonSpectrumLinker/AmazonSpectrumLinkerDryRun/%DYN      |           | response/amazonSpectrum/actual/itemIds.json   | $..has_LinkerAnalysis.id    |
      | APPDBPOSTGRES | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com |           | response/amazonSpectrum/actual/itemIds.json   | $..Cluster.id               |
      | APPDBPOSTGRES | Default | asgredshiftworlddata                                             | Directory | response/amazonSpectrum/actual/s3itemIds.json | $..has_Directory.id         |

  Scenario Outline:SC#14 user deletes the item from database using dynamic id stored in json for SpectrumLinker dry run
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson                   | inputFile                                     |
      | items/Default/Default.Cluster:::dynamic   | 204          | $..Cluster.id               | response/amazonSpectrum/actual/itemIds.json   |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_CatalogerAnalysis.id | response/amazonSpectrum/actual/itemIds.json   |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_LinkerAnalysis.id    | response/amazonSpectrum/actual/itemIds.json   |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id         | response/amazonSpectrum/actual/s3itemIds.json |

    #########################################################################################################################################3

  @webtest
  Scenario:SC#15Verify the Dry run feature for the Spectrum Analyzer
    And user "update" the json file "ida/AmazonSpectrumPayloads/SpectrumCataloger_dryrun.json" file for following values
      | jsonPath  | jsonValues | type    |
      | $..dryRun | false      | boolean |
    And user "update" the json file "ida/AmazonSpectrumPayloads/AmazonSpectrumAnalyzer_dryrun.json" file for following values
      | jsonPath  | jsonValues | type    |
      | $..dryRun | true       | boolean |
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                         | body                                                          | response code | response message | jsonPath                                                           |
      | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumCataloger                                  | ida/AmazonSpectrumPayloads/SpectrumCataloger_dryrun.json      | 204           |                  |                                                                    |
      |                  |       |       | Get          | settings/analyzers/AmazonSpectrumCataloger                                  |                                                               | 200           |                  | AmazonSpectrumCatalogerDryRun                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/*   |                                                               | 200           | IDLE             | $.[?(@.configurationName=='AmazonSpectrumCatalogerDryRun')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonSpectrumCataloger/*    | ida/AmazonSpectrumPayloads/empty.json                         | 200           |                  |                                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/*   |                                                               | 200           | IDLE             | $.[?(@.configurationName=='AmazonSpectrumCatalogerDryRun')].status |
      |                  |       |       | Put          | settings/analyzers/AmazonSpectrumAnalyzer                                   | ida/AmazonSpectrumPayloads/AmazonSpectrumAnalyzer_dryrun.json | 204           |                  |                                                                    |
      |                  |       |       | Get          | settings/analyzers/AmazonSpectrumAnalyzer                                   |                                                               | 200           |                  | AmazonSpectrumAnalyzerDryRun                                       |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/* |                                                               | 200           | IDLE             | $.[?(@.configurationName=='AmazonSpectrumAnalyzerDryRun')].status  |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/*  | ida/AmazonSpectrumPayloads/empty.json                         | 200           |                  |                                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/* |                                                               | 200           | IDLE             | $.[?(@.configurationName=='AmazonSpectrumAnalyzerDryRun')].status  |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SpecAnalyzer" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzerDryRun%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 0             | Description |
    And user "widget not present" on "Processed Items" in Item view page
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzerDryRun%" should display below info/error/warning
      | type | logValue                                                                                          | logCode       | pluginName             | removableText |
      | INFO | Plugin AmazonSpectrumAnalyzer running on dry run mode                                             | ANALYSIS-0069 | AmazonSpectrumAnalyzer |               |
      | INFO | Plugin AmazonSpectrumAnalyzer processed 2 items on dry run mode and not written to the repository | ANALYSIS-0070 | AmazonSpectrumAnalyzer |               |
      | INFO | Plugin completed                                                                                  | ANALYSIS-0020 |                        |               |


  @sanity @positive
  Scenario:SC#15:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonSpectrumCataloger/%                              | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/AmazonSpectrumAnalyzer/%                            | Analysis |       |       |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |

  ######################################External_Schema_Table_In_Filter###############################################
  Scenario Outline:SC#16_Run the Plugin configurations of Amazon Spectrum Cataloger,AmazonS3Cataloger and AmazonSpectrum Linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                       | body                                                                            | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumCataloger                                | ida/AmazonSpectrumPayloads/AmazonSpectrumCataloger_with_single_schema.json      | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumCataloger                                |                                                                                 | 200           | AmazonSpectrumCataloger |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                      | ida/AmazonSpectrumPayloads/AmazonS3Cataloger_Configuration.json                 | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                      |                                                                                 | 200           | AmazonS3Cataloger       |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumLinker                                   | ida/AmazonSpectrumPayloads/AmazonSpectrumLinker_with_schema_and_table_name.json | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumLinker                                   |                                                                                 | 200           | AmazonSpectrumLinker    |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/* |                                                                                 | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonSpectrumCataloger/*  | ida/AmazonSpectrumPayloads/empty.json                                           | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/* |                                                                                 | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/*       |                                                                                 | 200           | IDLE                    | $.[?(@.configurationName=='AmazonS3Cataloger')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*        | ida/AmazonSpectrumPayloads/empty.json                                           | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/*       |                                                                                 | 200           | IDLE                    | $.[?(@.configurationName=='AmazonS3Cataloger')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AmazonSpectrumLinker/*       |                                                                                 | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumLinker')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/AmazonSpectrumLinker/*        | ida/AmazonSpectrumPayloads/empty.json                                           | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AmazonSpectrumLinker/*       |                                                                                 | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumLinker')].status    |

    ##6529267##
  @amazonSpectrum @positve @regression @sanity @webtest
  Scenario:SC#16_Verify the Linker assign external location if schema name and table name is mentioned with filter mode as Include
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "city [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "city" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                  | widgetName  |
      | Table Type        | EXTERNAL                                       | Description |
      | Location          | s3://asgredshiftworlddata/Redshift-Data/city1/ | Description |
    And user "widget presence" on "Lineage Hops" in Item view page
    And user "widget presence" on "externalLocation" in Item view page
    And user "verifies tab section values" has the following values in "externalLocation" Tab in Item View page
      | city1 |
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "city1 [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "city1" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | EXTERNAL      | Description |
    And user "widget not present" on "Lineage Hops" in Item view page
    And user "widget not present" on "externalLocation" in Item view page
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "city2 [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "city2" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | EXTERNAL      | Description |
    And user "widget not present" on "Lineage Hops" in Item view page
    And user "widget not present" on "externalLocation" in Item view page

  Scenario:SC#17 user get all lineage hops id,s and get the source target value from database
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name | asg_scopeid | targetFile                                         | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | city |             | response/amazonSpectrum/lineage/actual/hopsID.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                                           | path                   | response code | response message | jsonPath | targetFile                                       |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response/amazonSpectrum/lineage/actual/hopsID.json | $.lineagePayLoads.city | 200           |                  | edges    | response/amazonSpectrum/lineage/actual/sc17.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                           | JsonPath |
      | Constant.REST_DIR/response/amazonSpectrum/lineage/actual/sc17.json | city     |

  Scenario Outline:SC#17 user compares the expected lineage data and actual lineage data
    Given user json assert between "<expectedJson>" data and "<actualJson>" data
    Examples:
      | expectedJson                                                       | actualJson                                                           |
      | Constant.REST_DIR/response/amazonSpectrum/lineage/actual/sc17.json | Constant.REST_DIR/response/amazonSpectrum/lineage/expected/sc17.json |


  @sanity @positive
  Scenario:SC17:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonSpectrumCataloger/%                              | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/AmazonS3Cataloger/%                                    | Analysis |       |       |
      | MultipleIDDelete | Default | linker/AmazonSpectrumLinker/%                                    | Analysis |       |       |
      | MultipleIDDelete | Default | amazonaws.com                                                    | Cluster  |       |       |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |


  ###################################Table_Name_Include_Scenario#################################################3
  Scenario Outline:SC#18_Run the Plugin configurations of Amazon Spectrum Cataloger,AmazonS3Cataloger and AmazonSpectrum Linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                       | body                                                                              | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumCataloger                                | ida/AmazonSpectrumPayloads/temp/SpectrumCataloger_without_filter.json             | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumCataloger                                |                                                                                   | 200           | AmazonSpectrumCataloger |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                      | ida/AmazonSpectrumPayloads/AmazonS3Cataloger_Configuration.json                   | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                      |                                                                                   | 200           | AmazonS3Cataloger       |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumLinker                                   | ida/AmazonSpectrumPayloads/temp/AmazonSpectrumLinker_with_table_name_include.json | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumLinker                                   |                                                                                   | 200           | AmazonSpectrumLinker    |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/* |                                                                                   | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonSpectrumCataloger/*  | ida/AmazonSpectrumPayloads/empty.json                                             | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/* |                                                                                   | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/*       |                                                                                   | 200           | IDLE                    | $.[?(@.configurationName=='AmazonS3Cataloger')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*        | ida/AmazonSpectrumPayloads/empty.json                                             | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/*       |                                                                                   | 200           | IDLE                    | $.[?(@.configurationName=='AmazonS3Cataloger')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AmazonSpectrumLinker/*       |                                                                                   | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumLinker')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/AmazonSpectrumLinker/*        | ida/AmazonSpectrumPayloads/empty.json                                             | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AmazonSpectrumLinker/*       |                                                                                   | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumLinker')].status    |

    ##6528907##
  @amazonSpectrum @positve @regression @sanity @webtest
  Scenario:SC#18_Verify the Linker assign external location if table name is mentioned with filter mode as Include
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "city" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                  | widgetName  |
      | Table Type        | EXTERNAL                                       | Description |
      | Location          | s3://asgredshiftworlddata/Redshift-Data/city1/ | Description |
    And user "widget presence" on "Lineage Hops" in Item view page
    And user "widget presence" on "externalLocation" in Item view page

  Scenario:SC#18 user get all lineage hops id,s and get the source target value from database
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name | asg_scopeid | targetFile                                         | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | city |             | response/amazonSpectrum/lineage/actual/hopsID.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                                           | path                   | response code | response message | jsonPath | targetFile                                       |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response/amazonSpectrum/lineage/actual/hopsID.json | $.lineagePayLoads.city | 200           |                  | edges    | response/amazonSpectrum/lineage/actual/sc18.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                           | JsonPath |
      | Constant.REST_DIR/response/amazonSpectrum/lineage/actual/sc18.json | city     |

  Scenario Outline:SC#18 user compares the expected lineage data and actual lineage data
    Given user json assert between "<expectedJson>" data and "<actualJson>" data
    Examples:
      | expectedJson                                                         | actualJson                                                         |
      | Constant.REST_DIR/response/amazonSpectrum/lineage/expected/sc18.json | Constant.REST_DIR/response/amazonSpectrum/lineage/actual/sc18.json |


  @sanity @positive
  Scenario:SC18:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonSpectrumCataloger/%                              | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/AmazonS3Cataloger/%                                    | Analysis |       |       |
      | MultipleIDDelete | Default | linker/AmazonSpectrumLinker/%                                    | Analysis |       |       |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |

  ############################Table_Name_Exclude_Scenario######################################
  Scenario Outline:SC#19_Run the Plugin configurations of Amazon Spectrum Cataloger,AmazonS3Cataloger and AmazonSpectrum Linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                       | body                                                                         | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumCataloger                                | ida/AmazonSpectrumPayloads/temp/SpectrumCataloger_without_filter.json        | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumCataloger                                |                                                                              | 200           | AmazonSpectrumCataloger |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                      | ida/AmazonSpectrumPayloads/AmazonS3Cataloger_Configuration.json              | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                      |                                                                              | 200           | AmazonS3Cataloger       |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumLinker                                   | ida/AmazonSpectrumPayloads/AmazonSpectrumLinker_with_table_name_exclude.json | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumLinker                                   |                                                                              | 200           | AmazonSpectrumLinker    |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/* |                                                                              | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonSpectrumCataloger/*  | ida/AmazonSpectrumPayloads/empty.json                                        | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/* |                                                                              | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/*       |                                                                              | 200           | IDLE                    | $.[?(@.configurationName=='AmazonS3Cataloger')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*        | ida/AmazonSpectrumPayloads/empty.json                                        | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/*       |                                                                              | 200           | IDLE                    | $.[?(@.configurationName=='AmazonS3Cataloger')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AmazonSpectrumLinker/*       |                                                                              | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumLinker')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/AmazonSpectrumLinker/*        | ida/AmazonSpectrumPayloads/empty.json                                        | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AmazonSpectrumLinker/*       |                                                                              | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumLinker')].status    |

    ##6529276##
  @amazonSpectrum @positve @regression @sanity @webtest
  Scenario:SC#19 the Linker assign external location if schema name and table name is mentioned with filter mode as Exclude
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "city" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | EXTERNAL      | Description |
    And user "widget not present" on "Lineage Hops" in Item view page
    And user "widget not presence" on "externalLocation" in Item view page
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "city1" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | EXTERNAL      | Description |
    And user "widget presence" on "Lineage Hops" in Item view page
    And user "widget presence" on "externalLocation" in Item view page
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "city2" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | EXTERNAL      | Description |
    And user "widget presence" on "Lineage Hops" in Item view page
    And user "widget presence" on "externalLocation" in Item view page

  Scenario:SC#19 user get all lineage hops id,s and get the source target value from database
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name  | asg_scopeid | targetFile                                         | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | city1 |             | response/amazonSpectrum/lineage/actual/hopsID.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | city2 |             | response/amazonSpectrum/lineage/actual/hopsID.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                                           | path                    | response code | response message | jsonPath | targetFile                                       |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response/amazonSpectrum/lineage/actual/hopsID.json | $.lineagePayLoads.city1 | 200           |                  | edges    | response/amazonSpectrum/lineage/actual/sc19.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response/amazonSpectrum/lineage/actual/hopsID.json | $.lineagePayLoads.city2 | 200           |                  | edges    | response/amazonSpectrum/lineage/actual/sc19.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                           | JsonPath |
      | Constant.REST_DIR/response/amazonSpectrum/lineage/actual/sc19.json | city1    |
      | Constant.REST_DIR/response/amazonSpectrum/lineage/actual/sc19.json | city2    |

  Scenario Outline:SC#19 user compares the expected lineage data and actual lineage data
    Given user json assert between "<expectedJson>" data and "<actualJson>" data
    Examples:
      | expectedJson                                                       | actualJson                                                           |
      | Constant.REST_DIR/response/amazonSpectrum/lineage/actual/sc19.json | Constant.REST_DIR/response/amazonSpectrum/lineage/expected/sc19.json |


  @sanity @positive
  Scenario:SC19:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonSpectrumCataloger/%                              | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/AmazonS3Cataloger/%                                    | Analysis |       |       |
      | MultipleIDDelete | Default | linker/AmazonSpectrumLinker/%                                    | Analysis |       |       |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |

  #############################External_linkerscenario_only_schema_in_filter#########################################3
  Scenario Outline:SC#20 Run the Plugin configurations of Amazon Spectrum Cataloger,AmazonS3Cataloger and AmazonSpectrum Linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                       | body                                                                          | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumCataloger                                | ida/AmazonSpectrumPayloads/temp/SpectrumCataloger_without_filter.json         | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumCataloger                                |                                                                               | 200           | AmazonSpectrumCataloger |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                      | ida/AmazonSpectrumPayloads/AmazonS3Cataloger_Configuration.json               | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                      |                                                                               | 200           | AmazonS3Cataloger       |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumLinker                                   | ida/AmazonSpectrumPayloads/AmazonSpectrumLinker_with_schema_name_include.json | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumLinker                                   |                                                                               | 200           | AmazonSpectrumLinker    |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/* |                                                                               | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonSpectrumCataloger/*  | ida/AmazonSpectrumPayloads/empty.json                                         | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/* |                                                                               | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/*       |                                                                               | 200           | IDLE                    | $.[?(@.configurationName=='AmazonS3Cataloger')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*        | ida/AmazonSpectrumPayloads/empty.json                                         | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/*       |                                                                               | 200           | IDLE                    | $.[?(@.configurationName=='AmazonS3Cataloger')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AmazonSpectrumLinker/*       |                                                                               | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumLinker')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/AmazonSpectrumLinker/*        | ida/AmazonSpectrumPayloads/empty.json                                         | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AmazonSpectrumLinker/*       |                                                                               | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumLinker')].status    |

    ##6529355##
  @amazonSpectrum @positve @regression @sanity @webtest
  Scenario:SC#20_Verify the Linker assigns external location if schema name alone is mentioned with filter mode as Include
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "city" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | EXTERNAL      | Description |
    And user "widget presence" on "Lineage Hops" in Item view page
    And user "widget presence" on "externalLocation" in Item view page
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "city1" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | EXTERNAL      | Description |
    And user "widget presence" on "Lineage Hops" in Item view page
    And user "widget presence" on "externalLocation" in Item view page
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "city2" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | EXTERNAL      | Description |
    And user "widget presence" on "Lineage Hops" in Item view page
    And user "widget presence" on "externalLocation" in Item view page

  Scenario:SC#10 user get all lineage hops id,s and get the source target value from database
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name  | asg_scopeid | targetFile                                         | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | city  |             | response/amazonSpectrum/lineage/actual/hopsID.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | city1 |             | response/amazonSpectrum/lineage/actual/hopsID.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | city2 |             | response/amazonSpectrum/lineage/actual/hopsID.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                                           | path                    | response code | response message | jsonPath | targetFile                                       |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response/amazonSpectrum/lineage/actual/hopsID.json | $.lineagePayLoads.city  | 200           |                  | edges    | response/amazonSpectrum/lineage/actual/sc20.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response/amazonSpectrum/lineage/actual/hopsID.json | $.lineagePayLoads.city1 | 200           |                  | edges    | response/amazonSpectrum/lineage/actual/sc20.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response/amazonSpectrum/lineage/actual/hopsID.json | $.lineagePayLoads.city2 | 200           |                  | edges    | response/amazonSpectrum/lineage/actual/sc20.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                           | JsonPath |
      | Constant.REST_DIR/response/amazonSpectrum/lineage/actual/sc20.json | city     |
      | Constant.REST_DIR/response/amazonSpectrum/lineage/actual/sc20.json | city1    |
      | Constant.REST_DIR/response/amazonSpectrum/lineage/actual/sc20.json | city2    |


  Scenario Outline:SC#20 user compares the expected lineage data and actual lineage data
    Given user json assert between "<expectedJson>" data and "<actualJson>" data
    Examples:
      | expectedJson                                                       | actualJson                                                           |
      | Constant.REST_DIR/response/amazonSpectrum/lineage/actual/sc20.json | Constant.REST_DIR/response/amazonSpectrum/lineage/expected/sc20.json |


  @sanity @positive
  Scenario:SC20:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonSpectrumCataloger/%                              | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/AmazonS3Cataloger/%                                    | Analysis |       |       |
      | MultipleIDDelete | Default | linker/AmazonSpectrumLinker/%                                    | Analysis |       |       |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |

   #####################Schema_Name_exclude_in_filter###########################################
  Scenario Outline:SC#21 Run the Plugin configurations of Amazon Spectrum Cataloger,AmazonS3Cataloger and AmazonSpectrum Linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                       | body                                                                          | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumCataloger                                | ida/AmazonSpectrumPayloads/temp/SpectrumCataloger_without_filter.json         | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumCataloger                                |                                                                               | 200           | AmazonSpectrumCataloger |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                      | ida/AmazonSpectrumPayloads/AmazonS3Cataloger_Configuration.json               | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                      |                                                                               | 200           | AmazonS3Cataloger       |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumLinker                                   | ida/AmazonSpectrumPayloads/AmazonSpectrumLinker_with_schema_name_exclude.json | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumLinker                                   |                                                                               | 200           | AmazonSpectrumLinker    |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/* |                                                                               | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonSpectrumCataloger/*  | ida/AmazonSpectrumPayloads/empty.json                                         | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/* |                                                                               | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/*       |                                                                               | 200           | IDLE                    | $.[?(@.configurationName=='AmazonS3Cataloger')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*        | ida/AmazonSpectrumPayloads/empty.json                                         | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/*       |                                                                               | 200           | IDLE                    | $.[?(@.configurationName=='AmazonS3Cataloger')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AmazonSpectrumLinker/*       |                                                                               | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumLinker')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/AmazonSpectrumLinker/*        | ida/AmazonSpectrumPayloads/empty.json                                         | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AmazonSpectrumLinker/*       |                                                                               | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumLinker')].status    |

    ##6529356##
  @amazonSpectrum @positve @regression @sanity @webtest
  Scenario:SC#21_Verify the Linker assigns external location if schema name alone is mentioned with filter mode as Exclude
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "city" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | EXTERNAL      | Description |
    And user "widget not present" on "externalLocation" in Item view page
    And user "widget not present" on "Lineage Hops" in Item view page
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "city1" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | EXTERNAL      | Description |
    And user "widget not present" on "externalLocation" in Item view page
    And user "widget not present" on "Lineage Hops" in Item view page
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "city2" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | EXTERNAL      | Description |
    And user "widget not present" on "externalLocation" in Item view page
    And user "widget not present" on "lineage Hops" in Item view page


  @sanity @positive
  Scenario:SC21:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonSpectrumCataloger/%                              | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/AmazonS3Cataloger/%                                    | Analysis |       |       |
      | MultipleIDDelete | Default | linker/AmazonSpectrumLinker/%                                    | Analysis |       |       |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |

   ###########################Linker_Scenario_Schema_With_Multiple_Filter##############################
  Scenario Outline:SC#22 Run the Plugin configurations of Amazon Spectrum Cataloger,AmazonS3Cataloger and AmazonSpectrum Linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                       | body                                                                                  | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumCataloger                                | ida/AmazonSpectrumPayloads/temp/SpectrumCataloger_without_filter.json                 | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumCataloger                                |                                                                                       | 200           | AmazonSpectrumCataloger |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                      | ida/AmazonSpectrumPayloads/AmazonS3Cataloger_Configuration.json                       | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                      |                                                                                       | 200           | AmazonS3Cataloger       |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumLinker                                   | ida/AmazonSpectrumPayloads/AmazonSpectrumLinker_with_multiple_table_name_include.json | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumLinker                                   |                                                                                       | 200           | AmazonSpectrumLinker    |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/* |                                                                                       | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonSpectrumCataloger/*  | ida/AmazonSpectrumPayloads/empty.json                                                 | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/* |                                                                                       | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/*       |                                                                                       | 200           | IDLE                    | $.[?(@.configurationName=='AmazonS3Cataloger')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*        | ida/AmazonSpectrumPayloads/empty.json                                                 | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/*       |                                                                                       | 200           | IDLE                    | $.[?(@.configurationName=='AmazonS3Cataloger')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AmazonSpectrumLinker/*       |                                                                                       | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumLinker')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/AmazonSpectrumLinker/*        | ida/AmazonSpectrumPayloads/empty.json                                                 | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AmazonSpectrumLinker/*       |                                                                                       | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumLinker')].status    |

    ##6529360##
  @amazonSpectrum @positve @regression @sanity @webtest
  Scenario:SC#22 Verify the Linker assigns external location if schema name with Multiple Table is mentioned with filter mode as Include
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "city" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | EXTERNAL      | Description |
    And user "widget presence" on "Lineage Hops" in Item view page
    And user "widget presence" on "externalLocation" in Item view page
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "city2" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | EXTERNAL      | Description |
    And user "widget not present" on "externalLocation" in Item view page
    And user "widget not present" on "lineage Hops" in Item view page

  Scenario:SC#22 user get all lineage hops id,s and get the source target value from database
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name  | asg_scopeid | targetFile                                         | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | city  |             | response/amazonSpectrum/lineage/actual/hopsID.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | city1 |             | response/amazonSpectrum/lineage/actual/hopsID.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                      | bodyFile                                           | path                    | response code | response message | jsonPath | targetFile                                       |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response/amazonSpectrum/lineage/actual/hopsID.json | $.lineagePayLoads.city  | 200           |                  | edges    | response/amazonSpectrum/lineage/actual/sc22.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response/amazonSpectrum/lineage/actual/hopsID.json | $.lineagePayLoads.city1 | 200           |                  | edges    | response/amazonSpectrum/lineage/actual/sc22.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                           | JsonPath |
      | Constant.REST_DIR/response/amazonSpectrum/lineage/actual/sc22.json | city     |
      | Constant.REST_DIR/response/amazonSpectrum/lineage/actual/sc22.json | city1    |


  Scenario Outline:SC#22 user compares the expected lineage data and actual lineage data
    Given user json assert between "<expectedJson>" data and "<actualJson>" data
    Examples:
      | expectedJson                                                       | actualJson                                                           |
      | Constant.REST_DIR/response/amazonSpectrum/lineage/actual/sc22.json | Constant.REST_DIR/response/amazonSpectrum/lineage/expected/sc22.json |


  @sanity @positive
  Scenario:SC22:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonSpectrumCataloger/%                              | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/AmazonS3Cataloger/%                                    | Analysis |       |       |
      | MultipleIDDelete | Default | linker/AmazonSpectrumLinker/%                                    | Analysis |       |       |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |

   ##################################Linker_Scenario_Multiple_Table_Exclude##################################
  Scenario Outline:SC#23 Run the Plugin configurations of Amazon Spectrum Cataloger,AmazonS3Cataloger and AmazonSpectrum Linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                       | body                                                                                  | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumCataloger                                | ida/AmazonSpectrumPayloads/temp/SpectrumCataloger_without_filter.json                 | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumCataloger                                |                                                                                       | 200           | AmazonSpectrumCataloger |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                      | ida/AmazonSpectrumPayloads/AmazonS3Cataloger_Configuration.json                       | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                      |                                                                                       | 200           | AmazonS3Cataloger       |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumLinker                                   | ida/AmazonSpectrumPayloads/AmazonSpectrumLinker_with_multiple_table_name_exclude.json | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumLinker                                   |                                                                                       | 200           | AmazonSpectrumLinker    |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/* |                                                                                       | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonSpectrumCataloger/*  | ida/AmazonSpectrumPayloads/empty.json                                                 | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/* |                                                                                       | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/*       |                                                                                       | 200           | IDLE                    | $.[?(@.configurationName=='AmazonS3Cataloger')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*        | ida/AmazonSpectrumPayloads/empty.json                                                 | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/*       |                                                                                       | 200           | IDLE                    | $.[?(@.configurationName=='AmazonS3Cataloger')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AmazonSpectrumLinker/*       |                                                                                       | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumLinker')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/AmazonSpectrumLinker/*        | ida/AmazonSpectrumPayloads/empty.json                                                 | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AmazonSpectrumLinker/*       |                                                                                       | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumLinker')].status    |

     ##6529361##
  @amazonSpectrum @positve @regression @sanity @webtest
  Scenario:SC#23 Verify the Linker assigns external location if schema name with Multiple Table is mentioned with filter mode as Exclude
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "city" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | EXTERNAL      | Description |
    And user "widget not present" on "externalLocation" in Item view page
    And user "widget not present" on "Lineage Hops" in Item view page
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "city1" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | EXTERNAL      | Description |
    And user "widget not present" on "externalLocation" in Item view page
    And user "widget not present" on "Lineage Hops" in Item view page
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "city2" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | EXTERNAL      | Description |
    And user "widget presence" on "Lineage Hops" in Item view page
    And user "widget presence" on "externalLocation" in Item view page

  Scenario:SC#23 user get all lineage hops id,s and get the source target value from database
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name  | asg_scopeid | targetFile                                         | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | city2 |             | response/amazonSpectrum/lineage/actual/hopsID.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                      | bodyFile                                           | path                    | response code | response message | jsonPath | targetFile                                       |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response/amazonSpectrum/lineage/actual/hopsID.json | $.lineagePayLoads.city2 | 200           |                  | edges    | response/amazonSpectrum/lineage/actual/sc23.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                           | JsonPath |
      | Constant.REST_DIR/response/amazonSpectrum/lineage/actual/sc23.json | city2    |


  Scenario Outline:SC#23 user compares the expected lineage data and actual lineage data
    Given user json assert between "<expectedJson>" data and "<actualJson>" data
    Examples:
      | expectedJson                                                       | actualJson                                                           |
      | Constant.REST_DIR/response/amazonSpectrum/lineage/actual/sc23.json | Constant.REST_DIR/response/amazonSpectrum/lineage/expected/sc23.json |

  @sanity @positive
  Scenario:SC23:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonSpectrumCataloger/%                              | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/AmazonS3Cataloger/%                                    | Analysis |       |       |
      | MultipleIDDelete | Default | linker/AmazonSpectrumLinker/%                                    | Analysis |       |       |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |

    ##############################BA_Numeric_Metadata_information#####################################

  Scenario Outline:SC#24_Run the Plugin configurations of Amazon Spectrum Cataloger,Amazon Spectrum Analyzer,AmazonS3Cataloger and AmazonSpectrum Linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                              | body                                                                                          | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumCataloger                                                       | ida/AmazonSpectrumPayloads/AmazonSpectrumCataloger_with_single_schema_and_multiple_table.json | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumCataloger                                                       |                                                                                               | 200           | AmazonSpectrumCataloger |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumAnalyzer                                                        | ida/AmazonSpectrumPayloads/AmazonSpectrumAnalyzer_Configuration.json                          | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumAnalyzer                                                        |                                                                                               | 200           | AmazonSpectrumAnalyzer  |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                                             | ida/AmazonSpectrumPayloads/AmazonS3Cataloger_Configuration.json                               | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                                             |                                                                                               | 200           | AmazonS3Cataloger       |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumLinker                                                          | ida/AmazonSpectrumPayloads/AmazonSpectrumLinker_Configuration.json                            | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumLinker                                                          |                                                                                               | 200           | AmazonSpectrumLinker    |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/*                        |                                                                                               | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonSpectrumCataloger/*                         | ida/AmazonSpectrumPayloads/empty.json                                                         | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/*                        |                                                                                               | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer |                                                                                               | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer  | ida/AmazonSpectrumPayloads/empty.json                                                         | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer |                                                                                               | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/*                              |                                                                                               | 200           | IDLE                    | $.[?(@.configurationName=='AmazonS3Cataloger')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*                               | ida/AmazonSpectrumPayloads/empty.json                                                         | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/*                              |                                                                                               | 200           | IDLE                    | $.[?(@.configurationName=='AmazonS3Cataloger')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AmazonSpectrumLinker/*                              |                                                                                               | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumLinker')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/AmazonSpectrumLinker/*                               | ida/AmazonSpectrumPayloads/empty.json                                                         | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AmazonSpectrumLinker/*                              |                                                                                               | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumLinker')].status    |

    ##6532846##
  @amazonSpectrum @positve @regression @sanity @webtest
  Scenario:SC#24 Verify the data profiling metadata information for numeric datatype in redshift Spectrum along with histogram
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "city [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "id" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Average                       | 5004          | Statistics  |
      | Data type                     | INTEGER       | Description |
      | Maximum value                 | 5009          | Statistics  |
      | Median                        | 5004          | Statistics  |
      | Minimum value                 | 5000          | Statistics  |
      | Number of non null values     | 10            | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Standard deviation            | 3.03          | Statistics  |
      | Number of unique values       | 10            | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 9.17          | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page


  @webtest
  Scenario:SC#24 Verify the Business Application tag is displayed after the run of Spectrum Analyzer and Linker
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "definite facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "SpecCataloger,Redshift Spectrum,Spectrum_BA" should get displayed for the column "cataloger/AmazonSpectrumCataloger"
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "Cluster" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "SpecCataloger,Redshift Spectrum,Spectrum_BA,SpecAnalyzer" should get displayed for the column "redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com"
    And user performs "facet selection" in "Cluster" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "Host" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "SpecCataloger,Redshift Spectrum,Spectrum_BA,SpecAnalyzer" should get displayed for the column "redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com"
    And user performs "facet selection" in "Host" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "SpecCataloger,Redshift Spectrum,Spectrum_BA,SpecAnalyzer,SpecLinker" should get displayed for the column "city2"
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "SpecCataloger,Redshift Spectrum,Spectrum_BA,SpecAnalyzer,SpecLinker" should get displayed for the column "id"
    And user enters the search text "SpecAnalyzer" and clicks on search
    And user performs "facet selection" in "SpecAnalyzer" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "SpecAnalyzer,Redshift Spectrum,Spectrum_BA" should get displayed for the column "dataanalyzer/AmazonSpectrumAnalyzer"
    And user enters the search text "SpecLinker" and clicks on search
    And user performs "facet selection" in "SpecLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "SpecLinker,Redshift Spectrum,Spectrum_BA" should get displayed for the column "linker/AmazonSpectrumLinker"
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name     | facet         | Tag                                                      | fileName               | userTag       |
      | Default     | Schema   | Metadata Type | SpecCataloger,Redshift Spectrum,Spectrum_BA              | spectrum               | SpecCataloger |
      | Default     | Service  | Metadata Type | SpecCataloger,Redshift Spectrum,Spectrum_BA              | AmazonRedshiftSpectrum | SpecCataloger |
      | Default     | Database | Metadata Type | SpecCataloger,Redshift Spectrum,Spectrum_BA,SpecAnalyzer | world                  | SpecCataloger |


  @webtest @positive
  Scenario:SC#24 Verify the Logging enhancement in Spectrum Cataloger, Linker and Analyzer
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/AmazonSpectrumCataloger/AmazonSpectrumCataloger%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 2             |
      | Number of errors          | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "cataloger/AmazonSpectrumCataloger/AmazonSpectrumCataloger%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | logCode       | pluginName              | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | ANALYSIS-0019 |                         |                |
      | INFO | Plugin Name:AmazonSpectrumCataloger, Plugin Type:cataloger, Plugin Version:1.0.0.SNAPSHOT, Node Name:LocalNode, Host Name:752e42d5c6c5, Plugin Configuration name:AmazonSpectrumCataloger                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | ANALYSIS-0071 | AmazonSpectrumCataloger | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin AmazonSpectrumCataloger Configuration: --- 2020-03-19 12:27:10.087 INFO - ANALYSIS-0073: Plugin AmazonSpectrumCataloger Configuration: name: "AmazonSpectrumCataloger" 2020-03-19 12:27:10.087 INFO - ANALYSIS-0073: Plugin AmazonSpectrumCataloger Configuration: pluginVersion: "LATEST" 2020-03-19 12:27:10.087 INFO - ANALYSIS-0073: Plugin AmazonSpectrumCataloger Configuration: label: null 2020-03-19 12:27:10.087 INFO - ANALYSIS-0073: Plugin AmazonSpectrumCataloger Configuration: catalogName: "Default" 2020-03-19 12:27:10.087 INFO - ANALYSIS-0073: Plugin AmazonSpectrumCataloger Configuration: eventClass: null 2020-03-19 12:27:10.087 INFO - ANALYSIS-0073: Plugin AmazonSpectrumCataloger Configuration: eventCondition: null 2020-03-19 12:27:10.087 INFO - ANALYSIS-0073: Plugin AmazonSpectrumCataloger Configuration: nodeCondition: "name==\"LocalNode\"" 2020-03-19 12:27:10.087 INFO - ANALYSIS-0073: Plugin AmazonSpectrumCataloger Configuration: maxWorkSize: 100 2020-03-19 12:27:10.087 INFO - ANALYSIS-0073: Plugin AmazonSpectrumCataloger Configuration: tags: 2020-03-19 12:27:10.087 INFO - ANALYSIS-0073: Plugin AmazonSpectrumCataloger Configuration: - "SpecCataloger" 2020-03-19 12:27:10.087 INFO - ANALYSIS-0073: Plugin AmazonSpectrumCataloger Configuration: pluginType: "cataloger" 2020-03-19 12:27:10.087 INFO - ANALYSIS-0073: Plugin AmazonSpectrumCataloger Configuration: dataSource: "SpectrumDS" 2020-03-19 12:27:10.087 INFO - ANALYSIS-0073: Plugin AmazonSpectrumCataloger Configuration: credential: "Spectrum_Credentials" 2020-03-19 12:27:10.087 INFO - ANALYSIS-0073: Plugin AmazonSpectrumCataloger Configuration: businessApplicationName: "Spectrum_BA" 2020-03-19 12:27:10.087 INFO - ANALYSIS-0073: Plugin AmazonSpectrumCataloger Configuration: dryRun: false 2020-08-27 11:29:09.852 INFO  - ANALYSIS-0073: Plugin AmazonSpectrumCataloger Configuration: schedule: null   2020-03-19 12:27:10.087 INFO - ANALYSIS-0073: Plugin AmazonSpectrumCataloger Configuration: filter: null 2020-03-19 12:27:10.088 INFO - ANALYSIS-0073: Plugin AmazonSpectrumCataloger Configuration: pluginName: "AmazonSpectrumCataloger" 2020-03-19 12:27:10.088 INFO - ANALYSIS-0073: Plugin AmazonSpectrumCataloger Configuration: schemas: 2020-03-19 12:27:10.088 INFO - ANALYSIS-0073: Plugin AmazonSpectrumCataloger Configuration: - schema: "spectrum" 2020-03-19 12:27:10.088 INFO - ANALYSIS-0073: Plugin AmazonSpectrumCataloger Configuration: tables: 2020-03-19 12:27:10.088 INFO - ANALYSIS-0073: Plugin AmazonSpectrumCataloger Configuration: - table: "city" 2020-03-19 12:27:10.088 INFO - ANALYSIS-0073: Plugin AmazonSpectrumCataloger Configuration: - table: "city2" 2020-03-19 12:27:10.088 INFO - ANALYSIS-0073: Plugin AmazonSpectrumCataloger Configuration: incremental: false 2020-03-19 12:27:10.088 INFO - ANALYSIS-0073: Plugin AmazonSpectrumCataloger Configuration: type: "Cataloger" 2020-03-19 12:27:10.088 INFO - ANALYSIS-0073: Plugin AmazonSpectrumCataloger Configuration: properties: [] | ANALYSIS-0073 | AmazonSpectrumCataloger |                |
      | INFO | Plugin AmazonSpectrumCataloger Start Time:2020-03-08 14:54:30.542, End Time:2020-03-08 14:54:53.488, Processed Count:2, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | ANALYSIS-0072 | AmazonSpectrumCataloger |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:22.946)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | ANALYSIS-0020 |                         |                |
    And user enters the search text "SpecAnalyzer" and clicks on search
    And user performs "facet selection" in "SpecAnalyzer" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 2             |
      | Number of errors          | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | logCode       | pluginName             | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | ANALYSIS-0019 |                        |                |
      | INFO | Plugin Name:AmazonSpectrumAnalyzer, Plugin Type:dataanalyzer, Plugin Version:1.0.0.SNAPSHOT, Node Name:LocalNode, Host Name:99fc7b5fffee, Plugin Configuration name:AmazonSpectrumAnalyzer                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | ANALYSIS-0071 | AmazonSpectrumAnalyzer | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin AmazonSpectrumAnalyzer Configuration: --- 2020-03-08 14:55:17.749 INFO - ANALYSIS-0073: Plugin AmazonSpectrumAnalyzer Configuration: name: "AmazonSpectrumAnalyzer" 2020-03-08 14:55:17.749 INFO - ANALYSIS-0073: Plugin AmazonSpectrumAnalyzer Configuration: pluginVersion: "LATEST" 2020-03-08 14:55:17.749 INFO - ANALYSIS-0073: Plugin AmazonSpectrumAnalyzer Configuration: label: null 2020-03-08 14:55:17.749 INFO - ANALYSIS-0073: Plugin AmazonSpectrumAnalyzer Configuration: catalogName: "Default" 2020-03-08 14:55:17.749 INFO - ANALYSIS-0073: Plugin AmazonSpectrumAnalyzer Configuration: eventClass: null 2020-03-08 14:55:17.749 INFO - ANALYSIS-0073: Plugin AmazonSpectrumAnalyzer Configuration: eventCondition: null 2020-03-08 14:55:17.749 INFO - ANALYSIS-0073: Plugin AmazonSpectrumAnalyzer Configuration: nodeCondition: "name==\"LocalNode\"" 2020-03-08 14:55:17.749 INFO - ANALYSIS-0073: Plugin AmazonSpectrumAnalyzer Configuration: maxWorkSize: 100 2020-03-08 14:55:17.749 INFO - ANALYSIS-0073: Plugin AmazonSpectrumAnalyzer Configuration: tags: 2020-03-08 14:55:17.749 INFO - ANALYSIS-0073: Plugin AmazonSpectrumAnalyzer Configuration: - "SpecAnalyzer" 2020-03-08 14:55:17.749 INFO - ANALYSIS-0073: Plugin AmazonSpectrumAnalyzer Configuration: pluginType: "dataanalyzer" 2020-03-08 14:55:17.749 INFO - ANALYSIS-0073: Plugin AmazonSpectrumAnalyzer Configuration: dataSource: null 2020-03-08 14:55:17.749 INFO - ANALYSIS-0073: Plugin AmazonSpectrumAnalyzer Configuration: credential: null 2020-03-08 14:55:17.749 INFO - ANALYSIS-0073: Plugin AmazonSpectrumAnalyzer Configuration: businessApplicationName: "Spectrum_BA" 2020-03-08 14:55:17.749 INFO - ANALYSIS-0073: Plugin AmazonSpectrumAnalyzer Configuration: dryRun: false 2020-08-27 11:29:09.852 INFO  - ANALYSIS-0073: Plugin AmazonSpectrumAnalyzer Configuration: schedule: null   2020-03-08 14:55:17.749 INFO - ANALYSIS-0073: Plugin AmazonSpectrumAnalyzer Configuration: filter: null 2020-03-08 14:55:17.749 INFO - ANALYSIS-0073: Plugin AmazonSpectrumAnalyzer Configuration: histogramBuckets: 10 2020-03-08 14:55:17.749 INFO - ANALYSIS-0073: Plugin AmazonSpectrumAnalyzer Configuration: batchWrite: true 2020-03-08 14:55:17.749 INFO - ANALYSIS-0073: Plugin AmazonSpectrumAnalyzer Configuration: database: "world" 2020-03-08 14:55:17.749 INFO - ANALYSIS-0073: Plugin AmazonSpectrumAnalyzer Configuration: pluginName: "AmazonSpectrumAnalyzer" 2020-03-08 14:55:17.749 INFO - ANALYSIS-0073: Plugin AmazonSpectrumAnalyzer Configuration: queryBatchSize: 100 2020-03-08 14:55:17.749 INFO - ANALYSIS-0073: Plugin AmazonSpectrumAnalyzer Configuration: sampleDataCount: 25 2020-03-08 14:55:17.749 INFO - ANALYSIS-0073: Plugin AmazonSpectrumAnalyzer Configuration: schemas: [] 2020-03-08 14:55:17.749 INFO - ANALYSIS-0073: Plugin AmazonSpectrumAnalyzer Configuration: host: "redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com" 2020-03-08 14:55:17.749 INFO - ANALYSIS-0073: Plugin AmazonSpectrumAnalyzer Configuration: incremental: false 2020-03-08 14:55:17.749 INFO - ANALYSIS-0073: Plugin AmazonSpectrumAnalyzer Configuration: type: "Dataanalyzer" 2020-03-08 14:55:17.749 INFO - ANALYSIS-0073: Plugin AmazonSpectrumAnalyzer Configuration: topValues: 10 | ANALYSIS-0073 | AmazonSpectrumAnalyzer |                |
      | INFO | Plugin AmazonSpectrumAnalyzer Start Time:2020-03-08 14:55:17.748, End Time:2020-03-08 14:55:46.514, Processed Count:2, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | ANALYSIS-0072 | AmazonSpectrumAnalyzer |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:28.766)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | ANALYSIS-0020 |                        |                |
    And user enters the search text "SpecLinker" and clicks on search
    And user performs "facet selection" in "SpecLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "linker/AmazonSpectrumLinker/AmazonSpectrumLinker%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 2             |
      | Number of errors          | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "linker/AmazonSpectrumLinker/AmazonSpectrumLinker%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | logCode       | pluginName           | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | ANALYSIS-0019 |                      |                |
      | INFO | Plugin Name:AmazonSpectrumLinker, Plugin Type:linker, Plugin Version:1.0.0.SNAPSHOT, Node Name:LocalNode, Host Name:99fc7b5fffee, Plugin Configuration name:AmazonSpectrumLinker                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | ANALYSIS-0071 | AmazonSpectrumLinker | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin AmazonSpectrumLinker Configuration: --- 2020-03-08 14:56:29.454 INFO - ANALYSIS-0073: Plugin AmazonSpectrumLinker Configuration: name: "AmazonSpectrumLinker" 2020-03-08 14:56:29.454 INFO - ANALYSIS-0073: Plugin AmazonSpectrumLinker Configuration: pluginVersion: "LATEST" 2020-03-08 14:56:29.454 INFO - ANALYSIS-0073: Plugin AmazonSpectrumLinker Configuration: label: null 2020-03-08 14:56:29.454 INFO - ANALYSIS-0073: Plugin AmazonSpectrumLinker Configuration: catalogName: "Default" 2020-03-08 14:56:29.454 INFO - ANALYSIS-0073: Plugin AmazonSpectrumLinker Configuration: eventClass: null 2020-03-08 14:56:29.454 INFO - ANALYSIS-0073: Plugin AmazonSpectrumLinker Configuration: eventCondition: null 2020-03-08 14:56:29.454 INFO - ANALYSIS-0073: Plugin AmazonSpectrumLinker Configuration: nodeCondition: "name==\"LocalNode\"" 2020-03-08 14:56:29.454 INFO - ANALYSIS-0073: Plugin AmazonSpectrumLinker Configuration: maxWorkSize: 100 2020-03-08 14:56:29.454 INFO - ANALYSIS-0073: Plugin AmazonSpectrumLinker Configuration: tags: 2020-03-08 14:56:29.454 INFO - ANALYSIS-0073: Plugin AmazonSpectrumLinker Configuration: - "SpecLinker" 2020-03-08 14:56:29.454 INFO - ANALYSIS-0073: Plugin AmazonSpectrumLinker Configuration: pluginType: "linker" 2020-03-08 14:56:29.454 INFO - ANALYSIS-0073: Plugin AmazonSpectrumLinker Configuration: dataSource: null 2020-03-08 14:56:29.454 INFO - ANALYSIS-0073: Plugin AmazonSpectrumLinker Configuration: credential: null 2020-03-08 14:56:29.454 INFO - ANALYSIS-0073: Plugin AmazonSpectrumLinker Configuration: businessApplicationName: "Spectrum_BA" 2020-03-08 14:56:29.454 INFO - ANALYSIS-0073: Plugin AmazonSpectrumLinker Configuration: dryRun: false 2020-08-27 11:29:09.852 INFO  - ANALYSIS-0073: Plugin AmazonSpectrumLinker Configuration: schedule: null   2020-03-08 14:56:29.454 INFO - ANALYSIS-0073: Plugin AmazonSpectrumLinker Configuration: filter: null 2020-03-08 14:56:29.454 INFO - ANALYSIS-0073: Plugin AmazonSpectrumLinker Configuration: database: "world" 2020-03-08 14:56:29.454 INFO - ANALYSIS-0073: Plugin AmazonSpectrumLinker Configuration: pluginName: "AmazonSpectrumLinker" 2020-03-08 14:56:29.454 INFO - ANALYSIS-0073: Plugin AmazonSpectrumLinker Configuration: queryBatchSize: 100 2020-03-08 14:56:29.454 INFO - ANALYSIS-0073: Plugin AmazonSpectrumLinker Configuration: schemas: [] 2020-03-08 14:56:29.454 INFO - ANALYSIS-0073: Plugin AmazonSpectrumLinker Configuration: host: "redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com" 2020-03-08 14:56:29.454 INFO - ANALYSIS-0073: Plugin AmazonSpectrumLinker Configuration: incremental: false 2020-03-08 14:56:29.454 INFO - ANALYSIS-0073: Plugin AmazonSpectrumLinker Configuration: type: "Linker" 2020-03-08 14:56:29.454 INFO - ANALYSIS-0073: Plugin AmazonSpectrumLinker Configuration: region: "us-east-1" | ANALYSIS-0073 | AmazonSpectrumLinker |                |
      | INFO | Plugin AmazonSpectrumLinker Start Time:2020-03-08 14:56:29.453, End Time:2020-03-08 14:56:29.997, Processed Count:2, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | ANALYSIS-0072 | AmazonSpectrumLinker |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:00.544)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | ANALYSIS-0020 |                      |                |


    ##6532847##
  @amazonSpectrum @positve @regression @sanity @webtest
  Scenario:SC#24 Verify the data profiling metadata information for string datatype in redhisft Spectrum
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "city [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "city" item from search results
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | name  | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR       | Description |
      | Maximum value                 | Utrecht       | Statistics  |
      | Maximum length                | 14            | Statistics  |
      | Minimum length                | 4             | Statistics  |
      | Minimum value                 | Amsterdam     | Statistics  |
      | Number of non null values     | 10            | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 10            | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user "widget not present" on "Data Distribution" in Item view page
    And user "widget presence" on "Most frequent values" in Item view page


  @sanity @positive
  Scenario:SC#24:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonSpectrumCataloger/%                              | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/AmazonS3Cataloger/%                                    | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/AmazonSpectrumAnalyzer/%                            | Analysis |       |       |
      | MultipleIDDelete | Default | linker/AmazonSpectrumLinker/%                                    | Analysis |       |       |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |


    ##############################Analyzer_schemaname_table_include_filter#####################################
  Scenario Outline:SC#25 Run the Plugin configurations for Amazon Spectrum Cataloger and Amazon Spectrum Analyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                              | body                                                                                      | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumCataloger                                                       | ida/AmazonSpectrumPayloads/temp/SpectrumCataloger_without_filter.json                     | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumCataloger                                                       |                                                                                           | 200           | AmazonSpectrumCataloger |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumAnalyzer                                                        | ida/AmazonSpectrumPayloads/AmazonSpectrumAnalyzer_schema_table_Include_Configuration.json | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumAnalyzer                                                        |                                                                                           | 200           | AmazonSpectrumAnalyzer  |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/*                        |                                                                                           | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonSpectrumCataloger/*                         | ida/AmazonSpectrumPayloads/empty.json                                                     | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/*                        |                                                                                           | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer |                                                                                           | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer  | ida/AmazonSpectrumPayloads/empty.json                                                     | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer |                                                                                           | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status  |

    ##6532849##
  @amazonSpectrum @positve @regression @sanity @webtest
  Scenario:SC#25 Verify the Spectrum Analyzer analyze data if schema name and table name is mentioned with filter mode as Include
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "city [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "city" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | EXTERNAL      | Description |
      | Number of rows    | 10            | Statistics  |
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | name  | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR       | Description |
      | Maximum value                 | Utrecht       | Statistics  |
      | Maximum length                | 14            | Statistics  |
      | Minimum length                | 4             | Statistics  |
      | Minimum value                 | Amsterdam     | Statistics  |
      | Number of non null values     | 10            | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 10            | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "city1 [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "name_1" item from search results
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
      | Maximum length    | Statistics |
      | Maximum value     | Statistics |
      | Minimum length    | Statistics |
      | Minimum value     | Statistics |


  @sanity @positive
  Scenario:SC#25:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonSpectrumCataloger/%                              | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/AmazonSpectrumAnalyzer/%                            | Analysis |       |       |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |

    ###################Analyzer_Schema_Table_Exclude##############################
  Scenario Outline:SC#26 Run the Plugin configurations for Amazon Spectrum Cataloger and Amazon Spectrum Analyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                              | body                                                                                      | response code | response message       | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumAnalyzer                                                        | ida/AmazonSpectrumPayloads/AmazonSpectrumAnalyzer_schema_table_Exclude_Configuration.json | 204           |                        |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumAnalyzer                                                        |                                                                                           | 200           | AmazonSpectrumAnalyzer |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/*                        |                                                                                           | 200           | IDLE                   | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonSpectrumCataloger/*                         | ida/AmazonSpectrumPayloads/empty.json                                                     | 200           |                        |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/*                        |                                                                                           | 200           | IDLE                   | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer |                                                                                           | 200           | IDLE                   | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer  | ida/AmazonSpectrumPayloads/empty.json                                                     | 200           |                        |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer |                                                                                           | 200           | IDLE                   | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status  |

    ##6532850##
  @amazonSpectrum @positve @regression @sanity @webtest
  Scenario:SC#26 Verify the Spectrum Analyzer analyze data if schema name and table name is mentioned with filter mode as Exclude
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "city [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "city" item from search results
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
      | Number of rows    | Statistics |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | EXTERNAL      | Description |
    Then user performs click and verify in new window
      | Table   | value    | Action               | RetainPrevwindow | indexSwitch |
      | Columns | district | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | VARCHAR       | Description |
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute     | widgetName |
      | Last analyzed at      | Lifecycle  |
      | Number of null values | Statistics |
      | Maximum value         | Statistics |
      | Minimum value         | Statistics |
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "city1 [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "id_1" item from search results
    And user "verify metadata attributes" section has following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
      | Maximum value     | Statistics |
      | Minimum value     | Statistics |
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "city2 [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "id" item from search results
    And user "verify metadata attributes" section has following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
      | Maximum value     | Statistics |
      | Minimum value     | Statistics |


  @sanity @positive
  Scenario:SC#26:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonSpectrumCataloger/%                              | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/AmazonSpectrumAnalyzer/%                            | Analysis |       |       |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |

  #####################Analyzer_Multiple_Table_Include#################################
  Scenario Outline:SC#27 Run the Plugin configurations Amazon Spectrum Cataloger,Amazon Spectrum Analyzer,Amazon S3 Cataloger and Amazon Spectrum Linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                              | body                                                                                                   | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumCataloger                                                       | ida/AmazonSpectrumPayloads/temp/SpectrumCataloger_without_filter.json                                  | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumCataloger                                                       |                                                                                                        | 200           | AmazonSpectrumCataloger |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumAnalyzer                                                        | ida/AmazonSpectrumPayloads/AmazonSpectrumAnalyzer_one_schema_multiple_table_Include_Configuration.json | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumAnalyzer                                                        |                                                                                                        | 200           | AmazonSpectrumAnalyzer  |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                                             | ida/AmazonSpectrumPayloads/AmazonS3Cataloger_Configuration.json                                        | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                                             |                                                                                                        | 200           | AmazonS3Cataloger       |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumLinker                                                          | ida/AmazonSpectrumPayloads/AmazonSpectrumLinker_Configuration.json                                     | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumLinker                                                          |                                                                                                        | 200           | AmazonSpectrumLinker    |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/*                        |                                                                                                        | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonSpectrumCataloger/*                         | ida/AmazonSpectrumPayloads/empty.json                                                                  | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/*                        |                                                                                                        | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer |                                                                                                        | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer  | ida/AmazonSpectrumPayloads/empty.json                                                                  | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer |                                                                                                        | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/*                              |                                                                                                        | 200           | IDLE                    | $.[?(@.configurationName=='AmazonS3Cataloger')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*                               | ida/AmazonSpectrumPayloads/empty.json                                                                  | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/*                              |                                                                                                        | 200           | IDLE                    | $.[?(@.configurationName=='AmazonS3Cataloger')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AmazonSpectrumLinker/*                              |                                                                                                        | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumLinker')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/AmazonSpectrumLinker/*                               | ida/AmazonSpectrumPayloads/empty.json                                                                  | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AmazonSpectrumLinker/*                              |                                                                                                        | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumLinker')].status    |

 ##6532851##
  @amazonSpectrum @positve @regression @sanity @webtest
  Scenario:SC#27 Verify the Spectrum Analyzer analyze data if schema name and multiple table name is mentioned with filter mode as Include
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "city [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "city" item from search results
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | name  | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR       | Description |
      | Maximum value                 | Utrecht       | Statistics  |
      | Maximum length                | 14            | Statistics  |
      | Minimum length                | 4             | Statistics  |
      | Minimum value                 | Amsterdam     | Statistics  |
      | Number of non null values     | 10            | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 10            | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "city2 [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "city2" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | EXTERNAL      | Description |
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "city1 [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "city1" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Number of rows    | 10            | Statistics  |
      | Table Type        | EXTERNAL      | Description |
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | id_1  | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Average                       | 5004          | Statistics  |
      | Data type                     | INTEGER       | Description |
      | Maximum value                 | 5009          | Statistics  |
      | Median                        | 5004          | Statistics  |
      | Minimum value                 | 5000          | Statistics  |
      | Number of non null values     | 10            | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Standard deviation            | 3.03          | Statistics  |
      | Number of unique values       | 10            | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 9.17          | Statistics  |
    And user "chart widget presence" on "Data Distribution" in Item view page

  @sanity @positive
  Scenario:SC#27:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonSpectrumCataloger/%                              | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/AmazonS3Cataloger/%                                    | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/AmazonSpectrumAnalyzer/%                            | Analysis |       |       |
      | MultipleIDDelete | Default | linker/AmazonSpectrumLinker/%                                    | Analysis |       |       |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |

    ##############################Analyzer_Multiple_table_exclude##########################
  Scenario Outline:SC#28 Run the Plugin configurations for Amazon Spectrum Cataloger and Amazon Spectrum Analyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                              | body                                                                                                   | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumCataloger                                                       | ida/AmazonSpectrumPayloads/temp/SpectrumCataloger_without_filter.json                                  | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumCataloger                                                       |                                                                                                        | 200           | AmazonSpectrumCataloger |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumAnalyzer                                                        | ida/AmazonSpectrumPayloads/AmazonSpectrumAnalyzer_one_schema_multiple_table_Exclude_Configuration.json | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumAnalyzer                                                        |                                                                                                        | 200           | AmazonSpectrumAnalyzer  |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/*                        |                                                                                                        | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonSpectrumCataloger/*                         | ida/AmazonSpectrumPayloads/empty.json                                                                  | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/*                        |                                                                                                        | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer |                                                                                                        | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer  | ida/AmazonSpectrumPayloads/empty.json                                                                  | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer |                                                                                                        | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status  |

 ##6532852##
  @amazonSpectrum @positve @regression @sanity @webtest
  Scenario:SC#28 Verify the Analyzer analyze data if schema name and multiple table name is mentioned with filter mode as Exclude
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "city [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "city" item from search results
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
      | Number of rows    | Statistics |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | EXTERNAL      | Description |
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | id    | click and switch tab | No               |             |
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "city1 [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "city1" item from search results
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
      | Number of rows    | Statistics |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | EXTERNAL      | Description |
    Then user performs click and verify in new window
      | Table   | value  | Action               | RetainPrevwindow | indexSwitch |
      | Columns | name_1 | click and switch tab | No               |             |
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "city2 [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "city2" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | EXTERNAL      | Description |
      | Number of rows    | 8170          | Statistics  |
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | name  | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue                    | widgetName  |
      | Data type                     | VARCHAR                          | Description |
      | Maximum value                 | Ürgenc                           | Statistics  |
      | Maximum length                | 35                               | Statistics  |
      | Minimum length                | 3                                | Statistics  |
      | Minimum value                 | &quot;A Coruña (La Coruña)&quot; | Statistics  |
      | Number of non null values     | 8170                             | Statistics  |
      | Percentage of non null values | 100                              | Statistics  |
      | Number of null values         | 0                                | Statistics  |
      | Number of unique values       | 4646                             | Statistics  |
      | Percentage of unique values   | 56.87                            | Statistics  |

  @sanity @positive
  Scenario:SC#28:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonSpectrumCataloger/%                              | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/AmazonSpectrumAnalyzer/%                            | Analysis |       |       |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |

  ################Analyzer_No_Filter_Provided##################

  Scenario Outline:SC#29 Run the Plugin configurations for Amazon Spectrum Cataloger and Amazon Spectrum Analyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                              | body                                                                                          | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumCataloger                                                       | ida/AmazonSpectrumPayloads/AmazonSpectrumCataloger_with_single_schema_and_multiple_table.json | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumCataloger                                                       |                                                                                               | 200           | AmazonSpectrumCataloger |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumAnalyzer                                                        | ida/AmazonSpectrumPayloads/AmazonSpectrumAnalyzer_Configuration.json                          | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumAnalyzer                                                        |                                                                                               | 200           | AmazonSpectrumAnalyzer  |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/*                        |                                                                                               | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonSpectrumCataloger/*                         | ida/AmazonSpectrumPayloads/empty.json                                                         | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/*                        |                                                                                               | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer |                                                                                               | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer  | ida/AmazonSpectrumPayloads/empty.json                                                         | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer |                                                                                               | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status  |

    ##6532991##
  @amazonSpectrum @positve @regression @sanity @webtest
  Scenario:SC#29 Verify Spectrum Analyzer analyze data if no filters are provided
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | city2 |
      | city  |
    And user performs "item click" on "city" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | EXTERNAL      | Description |
      | Number of rows    | 10            | Statistics  |
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | id    | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Average                       | 5004          | Statistics  |
      | Data type                     | INTEGER       | Description |
      | Maximum value                 | 5009          | Statistics  |
      | Median                        | 5004          | Statistics  |
      | Minimum value                 | 5000          | Statistics  |
      | Number of non null values     | 10            | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Standard deviation            | 3.03          | Statistics  |
      | Number of unique values       | 10            | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 9.17          | Statistics  |
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "city2" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | EXTERNAL      | Description |
      | Number of rows    | 8170          | Statistics  |
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | name  | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue                    | widgetName  |
      | Data type                     | VARCHAR                          | Description |
      | Maximum value                 | Ürgenc                           | Statistics  |
      | Maximum length                | 35                               | Statistics  |
      | Minimum length                | 3                                | Statistics  |
      | Minimum value                 | &quot;A Coruña (La Coruña)&quot; | Statistics  |
      | Number of non null values     | 8170                             | Statistics  |
      | Percentage of non null values | 100                              | Statistics  |
      | Number of null values         | 0                                | Statistics  |
      | Number of unique values       | 4646                             | Statistics  |
      | Percentage of unique values   | 56.87                            | Statistics  |


  @sanity @positive
  Scenario:SC#29:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonSpectrumCataloger/%                              | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/AmazonSpectrumAnalyzer/%                            | Analysis |       |       |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |

    #######################Analyzer_Schema_Name_Alone_In_Filter######################################
  Scenario Outline:SC#30 Run the Plugin configurations for Amazon Spectrum Cataloger and Amazon Spectrum Analyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                              | body                                                                                | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumCataloger                                                       | ida/AmazonSpectrumPayloads/temp/SpectrumCataloger_without_filter.json               | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumCataloger                                                       |                                                                                     | 200           | AmazonSpectrumCataloger |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumAnalyzer                                                        | ida/AmazonSpectrumPayloads/AmazonSpectrumAnalyzer_schema_Include_Configuration.json | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumAnalyzer                                                        |                                                                                     | 200           | AmazonSpectrumAnalyzer  |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/*                        |                                                                                     | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonSpectrumCataloger/*                         | ida/AmazonSpectrumPayloads/empty.json                                               | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/*                        |                                                                                     | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer |                                                                                     | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer  | ida/AmazonSpectrumPayloads/empty.json                                               | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer |                                                                                     | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status  |

    ##6534851##
  @amazonSpectrum @positve @regression @sanity @webtest
  Scenario:SC#30 Verify the Spectrum Analyzer analyze data if Schema Name Alone is mentioned with mode as Include
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "city2" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "city2" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | EXTERNAL      | Description |
      | Number of rows    | 8170          | Statistics  |
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | name  | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue                    | widgetName  |
      | Data type                     | VARCHAR                          | Description |
      | Maximum value                 | Ürgenc                           | Statistics  |
      | Maximum length                | 35                               | Statistics  |
      | Minimum length                | 3                                | Statistics  |
      | Minimum value                 | &quot;A Coruña (La Coruña)&quot; | Statistics  |
      | Number of non null values     | 8170                             | Statistics  |
      | Percentage of non null values | 100                              | Statistics  |
      | Number of null values         | 0                                | Statistics  |
      | Number of unique values       | 4646                             | Statistics  |
      | Percentage of unique values   | 56.87                            | Statistics  |
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "city" item from search results
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | name  | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR       | Description |
      | Maximum value                 | Utrecht       | Statistics  |
      | Maximum length                | 14            | Statistics  |
      | Minimum length                | 4             | Statistics  |
      | Minimum value                 | Amsterdam     | Statistics  |
      | Number of non null values     | 10            | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 10            | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "city1" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | EXTERNAL      | Description |
      | Number of rows    | 10            | Statistics  |
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | id_1  | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Average                       | 5004          | Statistics  |
      | Data type                     | INTEGER       | Description |
      | Maximum value                 | 5009          | Statistics  |
      | Median                        | 5004          | Statistics  |
      | Minimum value                 | 5000          | Statistics  |
      | Number of non null values     | 10            | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Standard deviation            | 3.03          | Statistics  |
      | Number of unique values       | 10            | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 9.17          | Statistics  |
    And user "chart widget presence" on "Data Distribution" in Item view page


  ##6532848##
  Scenario Outline:SC#31:user get the Dynamic ID's (Database ID) for the Keyspaces "Amazon spectrum" and table "city"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive     | catalog | type   | name     | asg_scopeid | targetFile                                                      | jsonpath               |
      | APPDBPOSTGRES | AsgScope_ID | Default | Schema | spectrum | city        | payloads/ida/AmazonSpectrumPayloads/DataSample/sc31_ItemID.json | $.Schema.spectrum.city |

  ##6532848##
  Scenario Outline: SC#31:user hits the TablesID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                              | responseCode | inputJson              | inputFile                                                       | outPutFile                                                                | outPutJson |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Schema.spectrum.city | payloads/ida/AmazonSpectrumPayloads/DataSample/sc31_ItemID.json | payloads/ida/AmazonSpectrumPayloads/DataSample/sc31_actualDataSample.json |            |

  ##6532848##
  Scenario: SC#31 Verify the DataSamples values are as expected
    Then file content in "ida/AmazonSpectrumPayloads/DataSample/sc31_actualDataSample.json" should be same as the content in "ida/AmazonSpectrumPayloads/DataSample/sc31_expectedDataSample.json"

  @sanity @positive
  Scenario:SC#31:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonSpectrumCataloger/%                              | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/AmazonSpectrumAnalyzer/%                            | Analysis |       |       |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |

   ###################Analyzer_Schema_Name_Exclude#################################

  Scenario Outline:SC#32 Run the Plugin configurations for Amazon Spectrum Cataloger and Amazon Spectrum Analyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                              | body                                                                                | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumCataloger                                                       | ida/AmazonSpectrumPayloads/SpectrumCataloger_without_filter.json                    | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumCataloger                                                       |                                                                                     | 200           | AmazonSpectrumCataloger |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumAnalyzer                                                        | ida/AmazonSpectrumPayloads/AmazonSpectrumAnalyzer_schema_Exclude_Configuration.json | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumAnalyzer                                                        |                                                                                     | 200           | AmazonSpectrumAnalyzer  |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/*                        |                                                                                     | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonSpectrumCataloger/*                         | ida/AmazonSpectrumPayloads/empty.json                                               | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/*                        |                                                                                     | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer |                                                                                     | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer  | ida/AmazonSpectrumPayloads/empty.json                                               | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer |                                                                                     | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status  |

     ##6534858## ##Issue in Spectrum Cataloger running in Multiple Filter##
  @amazonSpectrum @positve @regression @sanity @webtest
  Scenario:SC#32 Verify the Spectrum Analyzer analyze data if Schema Name Alone is mentioned with mode as Exclude
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "spectrum" item from search results
    Then user performs click and verify in new window
      | Table  | value | Action               | RetainPrevwindow | indexSwitch |
      | Tables | city  | click and switch tab | No               |             |
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
      | Number of rows    | Statistics |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | EXTERNAL      | Description |
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | id    | click and switch tab | No               |             |
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | INTEGER       | Description |
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "spectrum" item from search results
    Then user performs click and verify in new window
      | Table  | value | Action               | RetainPrevwindow | indexSwitch |
      | Tables | city1 | click and switch tab | No               |             |
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
      | Number of rows    | Statistics |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | EXTERNAL      | Description |
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | id_1  | click and switch tab | No               |             |
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "spectrum" item from search results
    Then user performs click and verify in new window
      | Table  | value | Action               | RetainPrevwindow | indexSwitch |
      | Tables | city2 | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | EXTERNAL      | Description |
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | id    | click and switch tab | No               |             |
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "city3" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | EXTERNAL      | Description |
      | Number of rows    | 10            | Statistics  |
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | id    | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Average                       | 4             | Statistics  |
      | Data type                     | INTEGER       | Description |
      | Maximum value                 | 9             | Statistics  |
      | Median                        | 4             | Statistics  |
      | Minimum value                 | 0             | Statistics  |
      | Number of non null values     | 10            | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Standard deviation            | 3.03          | Statistics  |
      | Number of unique values       | 10            | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 9.17          | Statistics  |


      #Bug MLP-14440 raised for this scenario
  @webtest @jdbc @MLP-14019
  Scenario:SC#33 Verify proper error message is thrown in UI if Sample Data count/Top Values/Histogram Buckets values are not provided within valid range in AmazonSpectrumAnalyzer
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Add Data source Configuration"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute              |
      | Type      | Dataanalyzer           |
      | Plugin    | AmazonSpectrumAnalyzer |
    And user "Click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Sample data count     | 1001                   |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName         | errorMessage                                               |
      | Sample data count | Value of Sample data count should not be greater than 1000 |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Sample data count     | 9                      |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName         | errorMessage                                            |
      | Sample data count | Value of Sample data count should not be lesser than 10 |
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

  @sanity @positive
  Scenario:SC#33:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonSpectrumCataloger/%                              | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/AmazonSpectrumAnalyzer/%                            | Analysis |       |       |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |


   ###################Linker/Lineage_Hops_Multiple_Filter_Include##############################

  Scenario Outline:SC#34 Run the Plugin configurations for DataSource and Amazon Spectrum Cataloger,Amazon Spectrum Analyzer,Amazon S3 Catalogerand Amazon Spectrum Linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                              | body                                                                                                          | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumCataloger                                                       | ida/AmazonSpectrumPayloads/temp/SpectrumCataloger_without_filter.json                                         | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumCataloger                                                       |                                                                                                               | 200           | AmazonSpectrumCataloger |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumAnalyzer                                                        | ida/AmazonSpectrumPayloads/temp/AmazonSpectrumAnalyzer_schema_table_multiplefilter_Include_Configuration.json | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumAnalyzer                                                        |                                                                                                               | 200           | AmazonSpectrumAnalyzer  |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumLinker                                                          | ida/AmazonSpectrumPayloads/temp/AmazonSpectrumLinker_with_schema_and_table_name_multiplefilter_Include.json   | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumLinker                                                          |                                                                                                               | 200           | AmazonSpectrumLinker    |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                                             | ida/AmazonSpectrumPayloads/AmazonS3Cataloger_Configuration.json                                               | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                                             |                                                                                                               | 200           | AmazonS3Cataloger       |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/*                        |                                                                                                               | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonSpectrumCataloger/*                         | ida/AmazonSpectrumPayloads/empty.json                                                                         | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/*                        |                                                                                                               | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/*                              |                                                                                                               | 200           | IDLE                    | $.[?(@.configurationName=='AmazonS3Cataloger')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*                               | ida/AmazonSpectrumPayloads/empty.json                                                                         | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/*                              |                                                                                                               | 200           | IDLE                    | $.[?(@.configurationName=='AmazonS3Cataloger')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer |                                                                                                               | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer  | ida/AmazonSpectrumPayloads/empty.json                                                                         | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer |                                                                                                               | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AmazonSpectrumLinker/*                              |                                                                                                               | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumLinker')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/AmazonSpectrumLinker/*                               | ida/AmazonSpectrumPayloads/empty.json                                                                         | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AmazonSpectrumLinker/*                              |                                                                                                               | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumLinker')].status    |


  @amazonSpectrum @positve @regression @sanity @webtest @MLP-12887
  Scenario:SC#34 Verify the Linker assigns external location/lineage hops if redshift spectrum linker is configured with multiple filter having Include mode
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "city [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "city" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | EXTERNAL      | Description |
      | Number of rows    | 10            | Statistics  |
    And user "widget presence" on "Lineage Hops" in Item view page
    And user "widget presence" on "externalLocation" in Item view page
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "city1 [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "city1" item from search results
    And user "widget not present" on "externalLocation" in Item view page
    And user "widget not present" on "Lineage Hops" in Item view page
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | EXTERNAL      | Description |
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
    #temp execution
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "city2 [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "city2" item from search results
    And user "widget presence" on "Lineage Hops" in Item view page
    And user "widget presence" on "externalLocation" in Item view page
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | EXTERNAL      | Description |
      | Number of rows    | 8170          | Statistics  |
#end of temp execution

#    And user enters the search text "SpecCataloger" and clicks on search
#    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "city3 [Table]" attribute under "Hierarchy" facets in Item Search results page
#    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "item click" on "city3" item from search results
#    And user "widget presence" on "Lineage Hops" in Item view page
#    And user "widget presence" on "externalLocation" in Item view page
#    Then user "verify metadata attributes" section has following values
#      | metaDataAttribute | widgetName |
#      | Last catalogued at | Lifecycle  |
#      | Last analyzed at   | Lifecycle  |
#    Then the following metadata values should be displayed
#      | metaDataAttribute | metaDataValue | widgetName  |
#      | Table Type        | EXTERNAL      | Description |
#      | Number of rows    | 10            | Statistics  |

  Scenario Outline:SC#35 user retrieves ids for specific item name
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>"
    Examples:
      | database      | catalog | name  | type  | targetFile                                                                                 |
      | APPDBPOSTGRES | Default | city  | Table | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/actualJsonFiles/sc35_tableIDs.json |
#      | APPDBPOSTGRES | Default | city3 | Table | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | city2 | Table | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/actualJsonFiles/sc35_tableIDs.json |

  Scenario Outline:SC#35 user copy the id to payload
    Given user copy the id from "<file>" to "<payloadFile>" with "<type>" using "<jsonPath>"
    Examples:
      | file                                                                                       | payloadFile                                                                      | type  | jsonPath |
      | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/actualJsonFiles/sc35_tableIDs.json | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/payloads/sc35_city.json  | Table | $..city  |
#      | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/payloads/city3.json | Table | $..city3 |
      | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/actualJsonFiles/sc35_tableIDs.json | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/payloads/sc35_city2.json | Table | $..city2 |

  Scenario Outline:SC#35 user get the response of lineage edges and store the lineage values in file
    Given user hits "<request>" with "<url>" "<body>" for id from "<file>" "<type>" using "<path>" and verify "<statusCode>" and store response of "<jsonPath>" in "<targetFile>" for "<name>"
    Examples:
      | request | url                                                                                     | body                                                                             | file                                                                                       | type | path     | statusCode | jsonPath   | targetFile                                                                              | name  |
      | Post    | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/payloads/sc35_city.json  | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/actualJsonFiles/sc35_tableIDs.json | List | $..city  | 200        | $..edges.* | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/actualJsonFiles/sc35_city.json  | city  |
#      | Post    | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/payloads/city3.json | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/actualJsonFiles/tableIDs.json | List | $..city3 | 200        | $..edges.* | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/actualJsonFiles/city3.json | city3 |
      | Post    | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/payloads/sc35_city2.json | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/actualJsonFiles/sc35_tableIDs.json | List | $..city2 | 200        | $..edges.* | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/actualJsonFiles/sc35_city2.json | city2 |

  Scenario Outline:SC#35 user retrieve the name of id for each value stored in lineage data file
    Given user gets the name for each id stored in "<LineageFile>" under "<TableName>" and replace the id with name
    Examples:
      | LineageFile                                                                             | TableName |
      | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/actualJsonFiles/sc35_city.json  | city      |
#      | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/actualJsonFiles/city3.json | city3     |
      | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/actualJsonFiles/sc35_city2.json | city2     |

  Scenario Outline:SC#35 user compares the expected lineage data and actual lineage data
    Given user json assert between "<expectedJson>" data and "<actualJson>" data
    Examples:
      | expectedJson                                                                              | actualJson                                                                              |
      | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/expectedJsonFiles/sc35_city.json  | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/actualJsonFiles/sc35_city.json  |
#      | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/expectedJsonFiles/city3.json | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/actualJsonFiles/city3.json |
      | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/expectedJsonFiles/sc35_city2.json | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/actualJsonFiles/sc35_city2.json |


  @sanity @positive
  Scenario:SC35:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonSpectrumCataloger/%                              | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/AmazonS3Cataloger/%                                    | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/AmazonSpectrumAnalyzer/%                            | Analysis |       |       |
      | MultipleIDDelete | Default | linker/AmazonSpectrumLinker/%                                    | Analysis |       |       |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |

    ########################################################################################################################

  Scenario Outline:SC#36_Run the Plugin configurations for DataSource and Amazon Spectrum Cataloger,Amazon Spectrum Analyzer,Amazon S3 Catalogerand Amazon Spectrum Linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                              | body                                                                                                          | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumCataloger                                                       | ida/AmazonSpectrumPayloads/temp/SpectrumCataloger_without_filter.json                                         | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumCataloger                                                       |                                                                                                               | 200           | AmazonSpectrumCataloger |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumAnalyzer                                                        | ida/AmazonSpectrumPayloads/temp/AmazonSpectrumAnalyzer_schema_table_multiplefilter_Exclude_Configuration.json | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumAnalyzer                                                        |                                                                                                               | 200           | AmazonSpectrumAnalyzer  |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumLinker                                                          | ida/AmazonSpectrumPayloads/temp/AmazonSpectrumLinker_with_schema_and_table_name_multiplefilter_Exclude.json   | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumLinker                                                          |                                                                                                               | 200           | AmazonSpectrumLinker    |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                                             | ida/AmazonSpectrumPayloads/AmazonS3Cataloger_Configuration.json                                               | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                                             |                                                                                                               | 200           | AmazonS3Cataloger       |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/*                        |                                                                                                               | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonSpectrumCataloger/*                         | ida/AmazonSpectrumPayloads/empty.json                                                                         | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/*                        |                                                                                                               | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/*                              |                                                                                                               | 200           | IDLE                    | $.[?(@.configurationName=='AmazonS3Cataloger')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*                               | ida/AmazonSpectrumPayloads/empty.json                                                                         | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/*                              |                                                                                                               | 200           | IDLE                    | $.[?(@.configurationName=='AmazonS3Cataloger')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer |                                                                                                               | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer  | ida/AmazonSpectrumPayloads/empty.json                                                                         | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer |                                                                                                               | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AmazonSpectrumLinker/*                              |                                                                                                               | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumLinker')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/AmazonSpectrumLinker/*                               | ida/AmazonSpectrumPayloads/empty.json                                                                         | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AmazonSpectrumLinker/*                              |                                                                                                               | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumLinker')].status    |

  @amazonSpectrum @positve @regression @sanity @webtest @MLP-12887
  Scenario:SC#36_Verify the Linker assigns external location/lineage hops if redshift spectrum linker is configured with multiple filter having Exclude mode
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "city [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "city" item from search results
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | EXTERNAL      | Description |
    And user "widget not present" on "externalLocation" in Item view page
    And user "widget not present" on "Lineage Hops" in Item view page
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "city1 [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "city1" item from search results
    And user "widget presence" on "Lineage Hops" in Item view page
    And user "widget presence" on "externalLocation" in Item view page
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | EXTERNAL      | Description |
      | Number of rows    | 10            | Statistics  |

    #commented due to temp execution
#    And user enters the search text "SpecCataloger" and clicks on search
#    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "city3 [Table]" attribute under "Hierarchy" facets in Item Search results page
#    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "item click" on "city3" item from search results
#    And user "widget not present" on "externalLocation" in Item view page
#    And user "widget not present" on "Lineage Hops" in Item view page
#    And user "verify metadata attributes" section does not have the following values
#      | metaDataAttribute | widgetName |
#      | Last analyzed at   | Lifecycle  |
#    Then the following metadata values should be displayed
#      | metaDataAttribute | metaDataValue | widgetName  |
#      | Table Type        | EXTERNAL      | Description |



  Scenario Outline:SC#36.1 user retrieves ids for specific item name
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>"
    Examples:
      | database      | catalog | name  | type  | targetFile                                                                                 |
      | APPDBPOSTGRES | Default | city1 | Table | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/actualJsonFiles/sc36_tableIDs.json |

  Scenario Outline:SC#36.2 user copy the id to payload
    Given user copy the id from "<file>" to "<payloadFile>" with "<type>" using "<jsonPath>"
    Examples:
      | file                                                                                       | payloadFile                                                                      | type  | jsonPath |
      | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/actualJsonFiles/sc36_tableIDs.json | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/payloads/sc36_city1.json | Table | $..city1 |

  Scenario Outline:SC#36.3 user get the response of lineage edges and store the lineage values in file
    Given user hits "<request>" with "<url>" "<body>" for id from "<file>" "<type>" using "<path>" and verify "<statusCode>" and store response of "<jsonPath>" in "<targetFile>" for "<name>"
    Examples:
      | request | url                                                                                     | body                                                                             | file                                                                                       | type | path     | statusCode | jsonPath   | targetFile                                                                              | name  |
      | Post    | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/payloads/sc36_city1.json | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/actualJsonFiles/sc36_tableIDs.json | List | $..city1 | 200        | $..edges.* | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/actualJsonFiles/sc36_city1.json | city1 |

  Scenario Outline:SC#36.4 user retrieve the name of id for each value stored in lineage data file
    Given user gets the name for each id stored in "<LineageFile>" under "<TableName>" and replace the id with name
    Examples:
      | LineageFile                                                                             | TableName |
      | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/actualJsonFiles/sc36_city1.json | city1     |

  Scenario Outline:SC#36.5 user compares the expected lineage data and actual lineage data
    Given user json assert between "<expectedJson>" data and "<actualJson>" data
    Examples:
      | expectedJson                                                                              | actualJson                                                                              |
      | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/expectedJsonFiles/sc36_city1.json | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/actualJsonFiles/sc36_city1.json |


  @sanity @positive
  Scenario:SC36:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonSpectrumCataloger/%                              | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/AmazonS3Cataloger/%                                    | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/AmazonSpectrumAnalyzer/%                            | Analysis |       |       |
      | MultipleIDDelete | Default | linker/AmazonSpectrumLinker/%                                    | Analysis |       |       |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |

################################################################################################################################

  Scenario Outline:SC#37_Run the Plugin configurations for DataSource and Amazon Spectrum Cataloger,Amazon Spectrum Analyzer,Amazon S3 Catalogerand Amazon Spectrum Linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                              | body                                                                                                                 | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumCataloger                                                       | ida/AmazonSpectrumPayloads/temp/SpectrumCataloger_without_filter.json                                                | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumCataloger                                                       |                                                                                                                      | 200           | AmazonSpectrumCataloger |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumAnalyzer                                                        | ida/AmazonSpectrumPayloads/temp/AmazonSpectrumAnalyzer_schema_table_multiplefilter_IncludeExclude_Configuration.json | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumAnalyzer                                                        |                                                                                                                      | 200           | AmazonSpectrumAnalyzer  |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumLinker                                                          | ida/AmazonSpectrumPayloads/temp/AmazonSpectrumLinker_with_schema_and_table_name_multiplefilter_IncludeExclude.json   | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumLinker                                                          |                                                                                                                      | 200           | AmazonSpectrumLinker    |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                                             | ida/AmazonSpectrumPayloads/AmazonS3Cataloger_Configuration.json                                                      | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                                             |                                                                                                                      | 200           | AmazonS3Cataloger       |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/*                        |                                                                                                                      | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonSpectrumCataloger/*                         | ida/AmazonSpectrumPayloads/empty.json                                                                                | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/*                        |                                                                                                                      | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/*                              |                                                                                                                      | 200           | IDLE                    | $.[?(@.configurationName=='AmazonS3Cataloger')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*                               | ida/AmazonSpectrumPayloads/empty.json                                                                                | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/*                              |                                                                                                                      | 200           | IDLE                    | $.[?(@.configurationName=='AmazonS3Cataloger')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer |                                                                                                                      | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer  | ida/AmazonSpectrumPayloads/empty.json                                                                                | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer |                                                                                                                      | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AmazonSpectrumLinker/*                              |                                                                                                                      | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumLinker')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/AmazonSpectrumLinker/*                               | ida/AmazonSpectrumPayloads/empty.json                                                                                | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AmazonSpectrumLinker/*                              |                                                                                                                      | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumLinker')].status    |


  @amazonSpectrum @positve @regression @sanity @webtest @MLP-12887
  Scenario:SC#37_Verify the Linker assigns external location/lineage hops if redshift spectrum linker is configured with multiple filter having Include/Exclude mode
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "city [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "city" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | EXTERNAL      | Description |
      | Number of rows    | 10            | Statistics  |
    And user "widget presence" on "Lineage Hops" in Item view page
    And user "widget presence" on "externalLocation" in Item view page
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "city1 [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "city1" item from search results
    And user "widget presence" on "Lineage Hops" in Item view page
    And user "widget presence" on "externalLocation" in Item view page
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | EXTERNAL      | Description |
      | Number of rows    | 10            | Statistics  |
    #temp execution
    And user enters the search text "SpecCataloger" and clicks on search
    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "city2" item from search results
    And user "widget not present" on "externalLocation" in Item view page
    And user "widget not present" on "Lineage Hops" in Item view page
    Then user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | EXTERNAL      | Description |
    #end of temp execution

    #commented for temp
#    And user enters the search text "SpecCataloger" and clicks on search
#    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "item click" on "city3" item from search results
#    And user "widget not present" on "externalLocation" in Item view page
#    And user "widget not present" on "Lineage Hops" in Item view page
#    Then user "verify metadata attributes" section does not have the following values
#      | metaDataAttribute | widgetName |
#      | Last analyzed at   | Lifecycle  |
#    Then the following metadata values should be displayed
#      | metaDataAttribute | metaDataValue | widgetName  |
#      | Table Type        | EXTERNAL      | Description |

#    And user copy metadata value from Item View Page and write to file using below parameters
#      | itemName       | city3                                          |
#      | attributeName  | Technical Data                                 |
#      | actualFilePath | ida/AmazonSpectrumPayloads/actualTechData.json |
#    Then file content in "ida/AmazonSpectrumPayloads/expectedcity3TechData.json" should be same as the content in "ida/AmazonSpectrumPayloads/actualTechData.json"

    #commented for temp
#    And user enters the search text "SpecCataloger" and clicks on search
#    And user performs "facet selection" in "SpecCataloger" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "item click" on "city4" item from search results
#    And user "widget presence" on "Lineage Hops" in Item view page
#    And user "widget presence" on "externalLocation" in Item view page
#    Then user "verify metadata attributes" section has following values
#      | metaDataAttribute | widgetName |
#      | Last catalogued at | Lifecycle  |
#    Then the following metadata values should be displayed
#      | metaDataAttribute | metaDataValue | widgetName  |
#      | Table Type        | EXTERNAL      | Description |

#    And user copy metadata value from Item View Page and write to file using below parameters
#      | itemName       | city4                                          |
#      | attributeName  | Technical Data                                 |
#      | actualFilePath | ida/AmazonSpectrumPayloads/actualTechData.json |
#    Then file content in "ida/AmazonSpectrumPayloads/expectedcity4TechData.json" should be same as the content in "ida/AmazonSpectrumPayloads/actualTechData.json"


  Scenario Outline:SC#38.1 user retrieves ids for specific item name
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>"
    Examples:
      | database      | catalog | name  | type  | targetFile                                                                                 |
      | APPDBPOSTGRES | Default | city  | Table | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/actualJsonFiles/sc38_tableIDs.json |
      | APPDBPOSTGRES | Default | city1 | Table | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/actualJsonFiles/sc38_tableIDs.json |
#      | APPDBPOSTGRES | Default | city4 | Table | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/actualJsonFiles/tableIDs.json |

  Scenario Outline:SC#38.2user copy the id to payload
    Given user copy the id from "<file>" to "<payloadFile>" with "<type>" using "<jsonPath>"
    Examples:
      | file                                                                                       | payloadFile                                                                      | type  | jsonPath |
      | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/actualJsonFiles/sc38_tableIDs.json | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/payloads/sc38_city.json  | Table | $..city  |
      | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/actualJsonFiles/sc38_tableIDs.json | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/payloads/sc38_city1.json | Table | $..city1 |
#      | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/payloads/city4.json | Table | $..city4 |

  Scenario Outline:SC#38.3 user get the response of lineage edges and store the lineage values in file
    Given user hits "<request>" with "<url>" "<body>" for id from "<file>" "<type>" using "<path>" and verify "<statusCode>" and store response of "<jsonPath>" in "<targetFile>" for "<name>"
    Examples:
      | request | url                                                                                     | body                                                                             | file                                                                                       | type | path     | statusCode | jsonPath   | targetFile                                                                              | name  |
      | Post    | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/payloads/sc38_city.json  | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/actualJsonFiles/sc38_tableIDs.json | List | $..city  | 200        | $..edges.* | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/actualJsonFiles/sc38_city.json  | city  |
      | Post    | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/payloads/sc38_city1.json | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/actualJsonFiles/sc38_tableIDs.json | List | $..city1 | 200        | $..edges.* | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/actualJsonFiles/sc38_city1.json | city1 |
#      | Post    | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/payloads/city4.json | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/actualJsonFiles/tableIDs.json | List | $..city4 | 200        | $..edges.* | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/actualJsonFiles/city4.json | city4 |

  Scenario Outline:SC#38.4 user retrieve the name of id for each value stored in lineage data file
    Given user gets the name for each id stored in "<LineageFile>" under "<TableName>" and replace the id with name
    Examples:
      | LineageFile                                                                             | TableName |
      | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/actualJsonFiles/sc38_city.json  | city      |
      | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/actualJsonFiles/sc38_city1.json | city1     |
#      | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/actualJsonFiles/city4.json | city4     |

  Scenario Outline:SC#38.5 user compares the expected lineage data and actual lineage data
    Given user json assert between "<expectedJson>" data and "<actualJson>" data
    Examples:
      | expectedJson                                                                              | actualJson                                                                              |
      | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/expectedJsonFiles/sc38_city.json  | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/actualJsonFiles/sc38_city.json  |
      | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/expectedJsonFiles/sc38_city1.json | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/actualJsonFiles/sc38_city1.json |
#      | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/expectedJsonFiles/city4.json | Constant.REST_DIR/response/AmazonSpectrumLinker_Lineage/actualJsonFiles/city4.json |


  @sanity @positive
  Scenario:SC38:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonSpectrumCataloger/%                              | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/AmazonS3Cataloger/%                                    | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/AmazonSpectrumAnalyzer/%                            | Analysis |       |       |
      | MultipleIDDelete | Default | linker/AmazonSpectrumLinker/%                                    | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/AmazonRedshiftCataloger/%                              | Analysis |       |       |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |

######################################################################################################################################

  Scenario Outline:SC#39_Run the Plugin configurations for Amazon Redshift DataSource and Amazon Redshift Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                       | body                                                     | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftDataSource                               | ida/AmazonSpectrumPayloads/AmazonRedshiftDataSource.json | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftDataSource                               |                                                          | 200           | RedshiftDS        |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger                                | ida/AmazonSpectrumPayloads/AmazonRedshiftCataloger.json  | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftCataloger                                |                                                          | 200           | RedshiftCataloger |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/* |                                                          | 200           | IDLE              | $.[?(@.configurationName=='RedshiftCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/*  | ida/AmazonSpectrumPayloads/empty.json                    | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/* |                                                          | 200           | IDLE              | $.[?(@.configurationName=='RedshiftCataloger')].status |


    ##Need to create dependent tables
  ##6876624## ##6876626##
  @webtest @MLP-15785
  Scenario:SC#39_Verify Table Type 'View' gets collected under Table Type when Redshift Cataloger plugin is ran (View to be created in Redshift Schema from the External table that is available in the Spectrum Schema) and Verify the Technology Tag
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "viewexternaltagdetails" and clicks on search
    And user performs "facet selection" in "RedshiftCat" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "testschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    Then the following tags "Redshift,RedshiftCat" should get displayed for the column "viewexternaltagdetails"
    And user performs "item click" on "viewexternaltagdetails" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | VIEW          | Description |
      | Created by        | master        | Description |


  Scenario Outline:SC#40_Run the Plugin configurations for Amazon Redshift Analyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | body                                                   | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftAnalyzer                                                  | ida/AmazonSpectrumPayloads/AmazonRedshiftAnalyzer.json | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftAnalyzer                                                  |                                                        | 200           | RedshiftAnalyzer |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer |                                                        | 200           | IDLE             | $.[?(@.configurationName=='RedshiftAnalyzer')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer  | ida/AmazonSpectrumPayloads/empty.json                  | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer |                                                        | 200           | IDLE             | $.[?(@.configurationName=='RedshiftAnalyzer')].status |


  ##6876630## ##6876626## ##6876629##
  @webtest @MLP-15785
  Scenario:SC#40_Verify the Createdby and Tabletype should not be overriden for Views (created from External Table) when Redshiftanalyzer is ran successfully.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "viewexternaltagdetails" and clicks on search
    And user performs "facet selection" in "RedshiftAna" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "viewexternaltagdetails [Table]" attribute under "Hierarchy" facets in Item Search results page
    Then the following tags "Redshift,RedshiftCat,RedshiftAna" should get displayed for the column "viewexternaltagdetails"
    And user performs "item click" on "viewexternaltagdetails" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | VIEW          | Description |
      | Created by        | master        | Description |

  #6876628##
  @webtest @MLP-15785
  Scenario:SC#41_Verify the data sampling works fine for views if RedshiftAnalyzer is run successfully
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "viewexternaltagdetails" and clicks on search
    And user performs "facet selection" in "viewexternaltagdetails [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "viewexternaltagdetails" item from search results
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | Gender | Full_name      | Email            | State | Phone_number | Employee_id | Postal_code | Ssn         | Ip_address    |
      | f      | Jones Campbell | cambie@gmail.com | TX    | 515.123.4356 | 11          | 46581       | 345-53-3779 | 255.249.12.0  |
      | m      | Alex Ferguson  | fergie@gmail.com | DC    | 515.123.4568 | 10          | 46576       | 345-53-3222 | 255.249.255.0 |
      | f      | Irina Shayk    | ishayk@gmail.com | VI    | 515.123.2580 | 13          | 48276       | 345-66-3222 | 255.71.255.56 |
      | m      | Lionel Messi   | lmessi@gmail.com | NY    | 515.123.6666 | 12          | 78576       | 315-53-3222 | 255.83.45.0   |



  ##6876627##
  @webtest @MLP-15785
  Scenario:SC#42_Verify the data profiling happens for string,numeric,date,time,timestamp datatype columns for Views (created from External Table) and should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "viewexternaltagdetails" and clicks on search
    And user performs "facet selection" in "RedshiftCat" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "viewexternaltagdetails" item from search results
    Then user performs click and verify in new window
      | Table   | value       | Action               | RetainPrevwindow | indexSwitch |
      | Columns | employee_id | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Average                       | 11            | Statistics  |
      | Data type                     | INTEGER       | Description |
      | Maximum value                 | 13            | Statistics  |
      | Median                        | 11            | Statistics  |
      | Minimum value                 | 10            | Statistics  |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Standard deviation            | 1.29          | Statistics  |
      | Number of unique values       | 4             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 1.67          | Statistics  |
    And user enters the search text "viewexternaltagdetails" and clicks on search
    And user performs "facet selection" in "RedshiftCat" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "email" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue    | widgetName  |
      | Length                        | 25               | Statistics  |
      | Data type                     | VARCHAR          | Description |
      | Maximum length                | 16               | Statistics  |
      | Maximum value                 | lmessi@gmail.com | Statistics  |
      | Minimum value                 | cambie@gmail.com | Statistics  |
      | Minimum length                | 16               | Statistics  |
      | Number of non null values     | 4                | Statistics  |
      | Percentage of non null values | 100              | Statistics  |
      | Number of null values         | 0                | Statistics  |
      | Number of unique values       | 4                | Statistics  |
      | Percentage of unique values   | 100              | Statistics  |
    And user enters the search text "viewexternaldiffdatatypes" and clicks on search
    And user performs "facet selection" in "RedshiftCat" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "testdata" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Length                        | 13            | Statistics  |
      | Data type                     | DATE          | Description |
      | Maximum value                 | 2017-07-07    | Statistics  |
      | Minimum value                 | 2013-03-03    | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user enters the search text "viewexternaldiffdatatypes" and clicks on search
    And user performs "facet selection" in "RedshiftCat" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "testtimewithzone" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue              | widgetName  |
      | Length                        | 29                         | Statistics  |
      | Data type                     | TIMESTAMP                  | Description |
      | Maximum value                 | 2010-10-01 00:45:10.000000 | Statistics  |
      | Minimum value                 | 2000-11-05 03:45:10.000000 | Statistics  |
      | Number of non null values     | 5                          | Statistics  |
      | Percentage of non null values | 100                        | Statistics  |
      | Number of null values         | 0                          | Statistics  |
      | Number of unique values       | 5                          | Statistics  |
      | Percentage of unique values   | 100                        | Statistics  |

  @sanity @positive
  Scenario:SC42:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonRedshiftCataloger/%                              | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/AmazonRedshiftAnalyzer/%                            | Analysis |       |       |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |

    ###########################################################################################################
    ##6529362##
  @amazonSpectrum @positve @regression @sanity @webtest
  Scenario:SC#43_Verify proper error message is shown if mandatory fields are not filled in Spectrum Linker plugin configuration
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Add Data source Configuration"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute            |
      | Type*     | Linker               |
      | Plugin*   | AmazonSpectrumLinker |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName      | validationMessage                       |
      | Name*          | Name field should not be empty          |
      | Host name*     | Host name field should not be empty     |
      | Database Name* | Database Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

    ##6533167##
  @amazonSpectrum @positve @regression @sanity @webtest
  Scenario:SC#44_Verify proper error message is shown if mandatory fields are not filled in Spectrum Cataloger plugin configuration
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Add Data source Configuration"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute               |
      | Type      | Cataloger               |
      | Plugin    | AmazonSpectrumCataloger |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

    ##6533168##
  @amazonSpectrum @positve @regression @sanity @webtest
  Scenario:SC#45_Verify proper error message is shown if mandatory fields are not filled in Spectrum Analyzer plugin configuration
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Add Data source Configuration"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute              |
      | Type      | Dataanalyzer           |
      | Plugin*   | AmazonSpectrumAnalyzer |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName      | validationMessage                       |
      | Name*          | Name field should not be empty          |
      | Host name*     | Host name field should not be empty     |
      | Database Name* | Database Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"


  ##########################################################################################################3333


  @positive @webtest
  Scenario: Delete the created Business Application Tag
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage                      | queryField |
      | APPDBPOSTGRES      | EXECUTEQUERY | json/IDA.json | AmazonSpectrumCatalogerQueries | deleteBA   |

  @regression @positiveRedshiftDataSource
  Scenario Outline: Delete plugin Configurations and credentials
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                             | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/Spectrum_Credentials       |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/AWS_Amazon_Credentials     |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/Redshift_Credentials       |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/SpectrumInvalidCredentials |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/AmazonS3DataSource           |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/AmazonS3Cataloger            |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/AmazonSpectrumDataSource     |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/AmazonSpectrumCataloger      |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/AmazonSpectrumLinker         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/AmazonSpectrumAnalyzer       |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/AmazonRedshiftDataSource     |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/AmazonRedshiftCataloger      |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/AmazonRedshiftAnalyzer       |      | 204           |                  |          |
