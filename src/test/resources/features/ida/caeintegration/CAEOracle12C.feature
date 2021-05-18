@MLP-27307 @25500
Feature: CAE based Oracle Collector Plugin

  Scenario Outline:PreCondition#Configure CAE Oracle Credentials and Data Source for Entry Point,Oracle,Feed,DD Load and Lineage data source
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                           | bodyFile                                         | path                                        | response code | response message         | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/OracleEntryPointServer                   | payloads/ida/CAEOracleCollector/credentials.json | $.CAEOracleServer                           | 200           |                          |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/OracleEntryPointServer                   |                                                  |                                             | 200           |                          |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CAEDataSource/OracleEntryPointCreateDS     | payloads/ida/CAEOracleCollector/datasource.json  | $.OracleEntryPointServer.configurations.[0] | 204           |                          |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CAEDataSource/OracleEntryPointCreateDS     |                                                  |                                             | 200           | OracleEntryPointCreateDS |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/Oracle12CDataServer                      | payloads/ida/CAEOracleCollector/credentials.json | $.Oracle12CDataServer                       | 200           |                          |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/Oracle12CDataServer                      |                                                  |                                             | 200           |                          |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/DataSource_for_Oracle/CAEOracleCollectorDS | payloads/ida/CAEOracleCollector/datasource.json  | $.OracleCollectorDS.configurations.[0]      | 204           |                          |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/DataSource_for_Oracle/CAEOracleCollectorDS |                                                  |                                             | 200           | CAEOracleCollectorDS     |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/OracleEntryPoint                         | payloads/ida/CAEOracleCollector/credentials.json | $.OracleEntryPoint                          | 200           |                          |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/OracleEntryPoint                         |                                                  |                                             | 200           |                          |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CAEDataSource/CAEFeedETLLINDS              | payloads/ida/CAEOracleCollector/datasource.json  | $.CAEFeedETLLINDS.configurations.[0]        | 204           |                          |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CAEDataSource/CAEFeedETLLINDS              |                                                  |                                             | 200           | CAEFeedETLLINDS          |          |


  Scenario Outline: PreCondition#Create BusinessApplication tag and run the plugin configuration with the new field for CAE Oracle Collector
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                 | body                                            | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | /items/Default/root | ida/CAEOracleCollector/BusinessApplication.json | 200           |                  |          |


  Scenario Outline:PreCondition#Configure and run Create Entry Point,Oracle Collector,Feed,Load Plugins
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                            | bodyFile                                          | path                                | response code | response message   | jsonPath                                                |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAECreateEntryPoint/OracleEntryPoint                                        | payloads/ida/CAEOracleCollector/pluginconfig.json | $.CAEOracleCreator.configurations   | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAECreateEntryPoint/OracleEntryPoint                                        |                                                   |                                     | 200           | OracleEntryPoint   |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAECreateEntryPoint/OracleEntryPoint            |                                                   |                                     | 200           | IDLE               | $.[?(@.configurationName=='OracleEntryPoint')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/other/CAECreateEntryPoint/OracleEntryPoint             |                                                   |                                     | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAECreateEntryPoint/OracleEntryPoint            |                                                   |                                     | 200           | IDLE               | $.[?(@.configurationName=='OracleEntryPoint')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAE_Collector_for_Oracle/CAEOracleCollector                                 | payloads/ida/CAEOracleCollector/pluginconfig.json | $.CAEOracleCollector.configurations | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAE_Collector_for_Oracle/CAEOracleCollector                                 |                                                   |                                     | 200           | CAEOracleCollector |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Oracle/CAEOracleCollector |                                                   |                                     | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleCollector')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/collector/CAE_Collector_for_Oracle/CAEOracleCollector  |                                                   |                                     | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Oracle/CAEOracleCollector |                                                   |                                     | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleCollector')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEFeed/CAEOracleFeed                                                       | payloads/ida/CAEOracleCollector/pluginconfig.json | $.CAEOracleFeeder.configurations    | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEFeed/CAEOracleFeed                                                       |                                                   |                                     | 200           | CAEOracleFeed      |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEFeed/CAEOracleFeed                           |                                                   |                                     | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleFeed')].status      |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/other/CAEFeed/CAEOracleFeed                            |                                                   |                                     | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEFeed/CAEOracleFeed                           |                                                   |                                     | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleFeed')].status      |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDDLoader/CAEOracleDDLoad                                                 | payloads/ida/CAEOracleCollector/pluginconfig.json | $.CAEOracleDDLoad.configurations    | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDDLoader/CAEOracleDDLoad                                                 |                                                   |                                     | 200           | CAEOracleDDLoad    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/CAEOracleDDLoad                 |                                                   |                                     | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleDDLoad')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/collector/CAEDDLoader/CAEOracleDDLoad                  |                                                   |                                     | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/CAEOracleDDLoad                 |                                                   |                                     | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleDDLoad')].status    |

  #@7200366 ##Bug-ID - MLP-30351##
  @webtest
  Scenario:SC1#Validate the number of data types items loaded from EDI Bus for Table,Column,Service and Schema
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Oracle" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ORACLE12C [Database]" attribute under "Hierarchy" facets in Item Search results page
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName | dataBaseType | queryPath     | queryPage | queryField         | columnName | queryOperation | facet         | facetValue | count      |
      | ORACLE12C    | STRUCTURED   | json/IDA.json | CAEORACLE | getTableCount      | count      | returnValue    | Metadata Type | Table      | fromSource |
      | ORACLE12C    | STRUCTURED   | json/IDA.json | CAEORACLE | getColumnCount     | count      | returnValue    | Metadata Type | Column     | fromSource |
      | ORACLE12C    | STRUCTURED   | json/IDA.json | CAEORACLE | getIndexCount      | count      | returnValue    | Metadata Type | Index      | fromSource |
      | ORACLE12C    | STRUCTURED   | json/IDA.json | CAEORACLE | getConstraintCount | count      | returnValue    | Metadata Type | Constraint | fromSource |
      | ORACLE12C    | STRUCTURED   | json/IDA.json | CAEORACLE | getTriggerCount    | count      | returnValue    | Metadata Type | Trigger    | fromSource |
      | ORACLE12C    | STRUCTURED   | json/IDA.json | CAEORACLE | getRoutineCount    | count      | returnValue    | Metadata Type | Routine    | fromSource |

   #7200361
  @webtest
  Scenario: SC2#:#Verify breadcrumb hierarchy for items collected from CAE Oracle Collector
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Oracle" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ORACLE12C_SCHEMA2 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "EMPLOYEE_ID" item from search results
    Then user "verify presence" of following "hierarchy" in Item View Page
      | DIDORACLE01V.DID.DEV.ASGINT.LOC |
      | ORACLE:1521                     |
      | ORACLE12C                       |
      | ORACLE12C_SCHEMA2               |
      | BASELINES                       |
      | EMPLOYEE_ID                     |


  #7200347 ##MLP-30351##
  @webtest
  Scenario: SC3#Verify if data collected in previous run is cleared when clear option is "TRUE" in CAEDD Loader plugin
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CAE_ORACLE_BA" and clicks on search
    And user performs "facet selection" in "CAE_ORACLE_BA" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Database    |
      | Schema      |
      | Service     |
      | DataPackage |
      | DataType    |
      | Analysis    |
      | Cluster     |
      | Table       |
      | Column      |
      | Trigger     |
      | Index       |
      | Constraint  |
      | Routine     |


  #7200352 7200348 ##MLP-30351##
  @webtest
  Scenario:SC4#_Verify Bussiness tag,Technology Tag and Asset Tag appears correctly in CAE Oracle collected items
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Oracle" and clicks on search
    And user performs "facet selection" in "CAE_ORACLE_BA" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "CAE_ORACLE_BA,BEC" should get displayed for the column "collector/CAE_Collector_for_Oracle"
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag                      | fileName                        | userTag |
      | Default     | Cluster    | Metadata Type | Oracle,BEC,CAE_ORACLE_BA | DIDORACLE01V.DID.DEV.ASGINT.LOC | Oracle  |
      | Default     | Service    | Metadata Type | Oracle,BEC,CAE_ORACLE_BA | ORACLE:1521                     | Oracle  |
      | Default     | Database   | Metadata Type | Oracle,BEC,CAE_ORACLE_BA | ORACLE12C                       | Oracle  |
      | Default     | Schema     | Metadata Type | Oracle,BEC,CAE_ORACLE_BA | ORACLE12C_SCHEMA1               | Oracle  |
      | Default     | Table      | Metadata Type | Oracle,BEC,CAE_ORACLE_BA | ADMIN_DOCINDEX                  | Oracle  |
      | Default     | Column     | Metadata Type | Oracle,BEC,CAE_ORACLE_BA | TOKEN                           | Oracle  |
      | Default     | Index      | Metadata Type | Oracle,BEC,CAE_ORACLE_BA | EMP_EMAIL_UK                    | Oracle  |
      | Default     | Constraint | Metadata Type | Oracle,BEC,CAE_ORACLE_BA | FKEY11                          | Oracle  |
      | Default     | Routine    | Metadata Type | Oracle,BEC,CAE_ORACLE_BA | PRODSV2T                        | Oracle  |
      | Default     | Trigger    | Metadata Type | Oracle,BEC,CAE_ORACLE_BA | QATRIGGER1                      | Oracle  |


  #7200354 #7200355 #7200357
  @webtest
  Scenario: SC5#:#Verify Cluster,Service,Schema and Database has appropriate metadata information
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Oracle" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Cluster" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "DIDORACLE01V.DID.DEV.ASGINT.LOC" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Description       | ORACLE        | Description |
    And user performs click and verify in new window
      | Table    | value       | Action               | RetainPrevwindow | indexSwitch |
      | Services | ORACLE:1521 | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Description       | ORACLE        | Description |
    And user performs click and verify in new window
      | Table     | value     | Action               | RetainPrevwindow | indexSwitch |
      | Databases | ORACLE12C | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Description       | ORACLE        | Description |
    And user performs click and verify in new window
      | Table   | value             | Action               | RetainPrevwindow | indexSwitch |
      | Schemas | ORACLE12C_SCHEMA1 | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Description       | Oracle        | Description |

  #7200358
  @webtest
  Scenario: SC6#:#Verify Table and Column  has appropriate metadata information
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CUSTOMERDETAILS_TABLE" and clicks on search
    And user enters the search text "CAE_ORACLE_BA" and clicks on search
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "CUSTOMERDETAILS_TABLE" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Description       | Oracle        | Description |
      | Table Type        | TABLE         | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute | widgetName |
      | Created           | Lifecycle  |
    And user performs click and verify in new window
      | Table   | value        | Action               | RetainPrevwindow | indexSwitch |
      | Columns | CUSTOMERNAME | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Description       |               | Description |
      | Data type         | VARCHAR2      | Description |
      | Length            | 10            | Statistics  |


  #7202123 #7202118 #7202274 #7202084 ##MLP-30351## ##MLP-30359##
  @webtest
  Scenario: SC7#:#Verify Trigger,Index,Constraint and Routine has appropriate metadata information
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CAE_ORACLE_BA" and clicks on search
    And user performs "facet selection" in "Index" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "EMP_EMAIL_UK" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Constraint Type   | U             | Description |
    And user enters the search text "CAE_ORACLE_BA" and clicks on search
    And user performs "facet selection" in "Constraint" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "FKEYHOSP" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Constraint Type   | FOREIGN_KEY   | Description |
    And user enters the search text "CAE_ORACLE_BA" and clicks on search
    And user performs "facet selection" in "Trigger" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "QATRIGGER1" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Description       | Oracle        | Description |
    And user enters the search text "CAE_ORACLE_BA" and clicks on search
    And user performs "facet selection" in "Routine" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "PRODSV2T" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | routineType       | PROCEDURE     | Description |

  #7200349
  @webtest
  Scenario: SC8#Verify only included schema is collected when specific schema is included in configuration
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Oracle" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ORACLE12C [Database]" attribute under "Hierarchy" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Schema    | 3     |

  #7200359 ##MLP-30351## ##MLP-30359##
  @webtest
  Scenario: SC9#Verify the Oracle Schema has Constraints,index,routine and trigger widget section if value present in source data server.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ORACLE12C_SCHEMA1" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    Then user performs click and verify in new window
      | Table       | value                      | Action                 | RetainPrevwindow | indexSwitch |
      | has_Trigger | QATRIGGER1                 | verify widget contains | No               |             |
      | has_Index   | ORACLEINDEXTEST            | verify widget contains | No               |             |
      | has_Index   | ORACLE_SUPPLIER_UNIQUETEST | verify widget contains | No               |             |
      | has_Index   | PERSON_INFO_PK             | verify widget contains | No               |             |
      | has_Index   | PRIMARY_PK                 | verify widget contains | No               |             |
      | has_Index   | SYS_C0065673               | verify widget contains | No               |             |
      | has_Index   | SYS_C0065674               | verify widget contains | No               |             |
      | has_Index   | SYS_C0065676               | verify widget contains | No               |             |
      | has_Routine | OCPPTESTFUNCTION           | verify widget contains | No               |             |
      | has_Routine | PRODSV2T                   | verify widget contains | No               |             |
      | has_Routine | PROT2T                     | verify widget contains | No               |             |
      | has_Routine | PROV2T                     | verify widget contains | No               |             |
      | Constraints | FKEYHOSP                   | verify widget contains | No               |             |
      | Constraints | FKEYPATIENT                | verify widget contains | No               |             |
      | Constraints | FK_PERSON_INFO             | verify widget contains | No               |             |



  #7200360
  @webtest
  Scenario: SC10#Verify  Oracle Schema  do not have constraints window if the table is not having any constraints.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ORACLE12C_SCHEMA2" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    Then user verify "non presence of facets" with following values under "Metadata Type" section in item search results page
      | Trigger    |
      | Index      |
      | Constraint |
      | Routine    |
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA2" item from search results
    Then user "widget not present" on "Constraints" in Item view page
    Then user "widget not present" on "has_Index" in Item view page
    Then user "widget not present" on "has_Routine" in Item view page
    Then user "widget not present" on "has_Trigger" in Item view page


    #7200362
  @webtest
  Scenario:SC11#Verify the dependencies appearing properly for VIEW/Triggers/Procedure/Functions
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ORACLESINGLEVIEWTOVIEW" and clicks on search
    And user performs "facet selection" in "CAE_ORACLE_BA" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLESINGLEVIEWTOVIEW" item from search results
    And user performs click and verify in new window
      | Table        | value                   | Action                 | RetainPrevwindow | indexSwitch |
      | dependencies | ORACLEVIEWTOSINGLETABLE | verify widget contains | No               |             |



    #############################################################Lineage Verfication for Oracle############################################################################################

  Scenario: SC#1 update the Lineage tags to the data items
    Given user updates the tags to the data items in DD
      | firstItemType | item hierarchy                                                                 | tableName                                                                                                    | LineageFor | getTagsPayloadURL              | bodyFile1                                           | assignTagsURL            | bodyFile2                                        | jsonPath1                                                | jsonPath2                                               | jsonValue |
      | Cluster       | DIDORACLE01V.DID.DEV.ASGINT.LOC,ORACLE:1521,ORACLE12C,ORACLE12C_LINEAGESCHEMA1 | ORACLEVIEWTOSINGLETABLE,ORACLESINGLEVIEWTOVIEW,ORACLEVIEWTOMULTIPLETABLE,ORACLEVIEWFROMVIEWTOVIEWVIEWTOTABLE | Column     | tags/Default/items/assignments | payloads/ida/CAEOracleCollector/columnsPayload.json | tags/Default/assignments | payloads/ida/CAEOracleCollector/tagsPayload.json | $..[?(@.name=='Backward Lineage Candidate')].cardinality | $..[?(@.name=='Forward Lineage Candidate')].cardinality | ALL       |
      | Cluster       | DIDORACLE01V.DID.DEV.ASGINT.LOC,ORACLE:1521,ORACLE12C,ORACLE12C_SCHEMA2        | TRANSVIEW                                                                                                    | Column     | tags/Default/items/assignments | payloads/ida/CAEOracleCollector/columnsPayload.json | tags/Default/assignments | payloads/ida/CAEOracleCollector/tagsPayload.json | $..[?(@.name=='Backward Lineage Candidate')].cardinality | $..[?(@.name=='Forward Lineage Candidate')].cardinality | ALL       |


  ##7200363## ##7200365## ##7201019## ##7201020## ##7201021##
  Scenario Outline: SC#1: Configure and run the CAELineage Plugin.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                        | bodyFile                                          | path                              | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAELineage/CAEOracleLineage                             | payloads/ida/CAEOracleCollector/pluginconfig.json | $.CAEOracleLineage.configurations | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAELineage/CAEOracleLineage                             |                                                   |                                   | 200           | CAEOracleLineage |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAELineage/CAEOracleLineage |                                                   |                                   | 200           | IDLE             | $.[?(@.configurationName=='CAEOracleLineage')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Headless-EDI/other/CAELineage/CAEOracleLineage  | payloads/ida/CAEOracleCollector/empty.json        | $.emptyJson                       | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAELineage/CAEOracleLineage |                                                   |                                   | 200           | IDLE             | $.[?(@.configurationName=='CAEOracleLineage')].status |


  ##7200363## ##7200365## ##7201019## ##7201020## ##7201021##
  Scenario Outline: user retrieves ids for specific item name
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>"
    Examples:
      | database      | catalog | name                                | type  | targetFile                                                          |
      | APPDBPOSTGRES | Default | ORACLEVIEWTOSINGLETABLE             | Table | Constant.REST_DIR/response/CAE_Oracle/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | ORACLESINGLEVIEWTOVIEW              | Table | Constant.REST_DIR/response/CAE_Oracle/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | ORACLEVIEWTOMULTIPLETABLE           | Table | Constant.REST_DIR/response/CAE_Oracle/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | ORACLEVIEWFROMVIEWTOVIEWVIEWTOTABLE | Table | Constant.REST_DIR/response/CAE_Oracle/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | TRANSVIEW                           | Table | Constant.REST_DIR/response/CAE_Oracle/actualJsonFiles/tableIDs.json |


  ##7200363## ##7200365## ##7201019## ##7201020## ##7201021##
  Scenario Outline: user copy the id to payload
    Given user copy the id from "<file>" to "<payloadFile>" with "<type>" using "<jsonPath>"
    Examples:
      | file                                                                | payloadFile                                                                             | type  | jsonPath                               |
      | Constant.REST_DIR/response/CAE_Oracle/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/CAE_Oracle/payloads/ORACLEVIEWTOSINGLETABLE.json             | Table | $..ORACLEVIEWTOSINGLETABLE             |
      | Constant.REST_DIR/response/CAE_Oracle/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/CAE_Oracle/payloads/ORACLESINGLEVIEWTOVIEW.json              | Table | $..ORACLESINGLEVIEWTOVIEW              |
      | Constant.REST_DIR/response/CAE_Oracle/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/CAE_Oracle/payloads/ORACLEVIEWTOMULTIPLETABLE.json           | Table | $..ORACLEVIEWTOMULTIPLETABLE           |
      | Constant.REST_DIR/response/CAE_Oracle/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/CAE_Oracle/payloads/ORACLEVIEWFROMVIEWTOVIEWVIEWTOTABLE.json | Table | $..ORACLEVIEWFROMVIEWTOVIEWVIEWTOTABLE |
      | Constant.REST_DIR/response/CAE_Oracle/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/CAE_Oracle/payloads/TRANSVIEW.json                           | Table | $..TRANSVIEW                           |


  ##7200363## ##7200365## ##7201019## ##7201020## ##7201021##
  Scenario Outline: user get the response of lineage edges and store the lineage values in file
    Given user hits "<request>" with "<url>" "<body>" for id from "<file>" "<type>" using "<path>" and verify "<statusCode>" and store response of "<jsonPath>" in "<targetFile>" for "<name>"
    Examples:
      | request | url                                                                               | body                                                                                    | file                                                                | type | path                                   | statusCode | jsonPath   | targetFile                                                                                     | name                                |
      | Post    | lineages/Default?dir=OUT&what=id,type,name,catalog&excludeUnusedViewColumns=false | Constant.REST_DIR/response/CAE_Oracle/payloads/ORACLEVIEWTOSINGLETABLE.json             | Constant.REST_DIR/response/CAE_Oracle/actualJsonFiles/tableIDs.json | List | $..ORACLEVIEWTOSINGLETABLE             | 200        | $..edges.* | Constant.REST_DIR/response/CAE_Oracle/actualJsonFiles/ORACLEVIEWTOSINGLETABLE.json             | ORACLEVIEWTOSINGLETABLE             |
      | Post    | lineages/Default?dir=OUT&what=id,type,name,catalog&excludeUnusedViewColumns=false | Constant.REST_DIR/response/CAE_Oracle/payloads/ORACLESINGLEVIEWTOVIEW.json              | Constant.REST_DIR/response/CAE_Oracle/actualJsonFiles/tableIDs.json | List | $..ORACLESINGLEVIEWTOVIEW              | 200        | $..edges.* | Constant.REST_DIR/response/CAE_Oracle/actualJsonFiles/ORACLESINGLEVIEWTOVIEW.json              | ORACLESINGLEVIEWTOVIEW              |
      | Post    | lineages/Default?dir=OUT&what=id,type,name,catalog&excludeUnusedViewColumns=false | Constant.REST_DIR/response/CAE_Oracle/payloads/ORACLEVIEWTOMULTIPLETABLE.json           | Constant.REST_DIR/response/CAE_Oracle/actualJsonFiles/tableIDs.json | List | $..ORACLEVIEWTOMULTIPLETABLE           | 200        | $..edges.* | Constant.REST_DIR/response/CAE_Oracle/actualJsonFiles/ORACLEVIEWTOMULTIPLETABLE.json           | ORACLEVIEWTOMULTIPLETABLE           |
      | Post    | lineages/Default?dir=OUT&what=id,type,name,catalog&excludeUnusedViewColumns=false | Constant.REST_DIR/response/CAE_Oracle/payloads/ORACLEVIEWFROMVIEWTOVIEWVIEWTOTABLE.json | Constant.REST_DIR/response/CAE_Oracle/actualJsonFiles/tableIDs.json | List | $..ORACLEVIEWFROMVIEWTOVIEWVIEWTOTABLE | 200        | $..edges.* | Constant.REST_DIR/response/CAE_Oracle/actualJsonFiles/ORACLEVIEWFROMVIEWTOVIEWVIEWTOTABLE.json | ORACLEVIEWFROMVIEWTOVIEWVIEWTOTABLE |
      | Post    | lineages/Default?dir=OUT&what=id,type,name,catalog&excludeUnusedViewColumns=false | Constant.REST_DIR/response/CAE_Oracle/payloads/TRANSVIEW.json                           | Constant.REST_DIR/response/CAE_Oracle/actualJsonFiles/tableIDs.json | List | $..TRANSVIEW                           | 200        | $..edges.* | Constant.REST_DIR/response/CAE_Oracle/actualJsonFiles/TRANSVIEW.json                           | TRANSVIEW                           |


  ##7200363## ##7200365## ##7201019## ##7201020## ##7201021##
  Scenario Outline: user retrieve the name of id for each value stored in lineage data file
    Given user gets the name for each id stored in "<LineageFile>" under "<TableName>" and replace the id with name
    Examples:
      | LineageFile                                                                                    | TableName                           |
      | Constant.REST_DIR/response/CAE_Oracle/actualJsonFiles/ORACLEVIEWTOSINGLETABLE.json             | ORACLEVIEWTOSINGLETABLE             |
      | Constant.REST_DIR/response/CAE_Oracle/actualJsonFiles/ORACLESINGLEVIEWTOVIEW.json              | ORACLESINGLEVIEWTOVIEW              |
      | Constant.REST_DIR/response/CAE_Oracle/actualJsonFiles/ORACLEVIEWTOMULTIPLETABLE.json           | ORACLEVIEWTOMULTIPLETABLE           |
      | Constant.REST_DIR/response/CAE_Oracle/actualJsonFiles/ORACLEVIEWFROMVIEWTOVIEWVIEWTOTABLE.json | ORACLEVIEWFROMVIEWTOVIEWVIEWTOTABLE |
      | Constant.REST_DIR/response/CAE_Oracle/actualJsonFiles/TRANSVIEW.json                           | TRANSVIEW                           |


  ##Bug ID - MLP-30376## ##7200363## ##7200365## ##7201019## ##7201020## ##7201021##
  Scenario Outline: user compares the expected lineage data and actual lineage data
    Given user json assert between "<expectedJson>" data and "<actualJson>" data
    Examples:
      | expectedJson                                                                                     | actualJson                                                                                     |
      | Constant.REST_DIR/response/CAE_Oracle/expectedJsonFiles/ORACLEVIEWTOSINGLETABLE.json             | Constant.REST_DIR/response/CAE_Oracle/actualJsonFiles/ORACLEVIEWTOSINGLETABLE.json             |
      | Constant.REST_DIR/response/CAE_Oracle/expectedJsonFiles/ORACLESINGLEVIEWTOVIEW.json              | Constant.REST_DIR/response/CAE_Oracle/actualJsonFiles/ORACLESINGLEVIEWTOVIEW.json              |
      | Constant.REST_DIR/response/CAE_Oracle/expectedJsonFiles/ORACLEVIEWTOMULTIPLETABLE.json           | Constant.REST_DIR/response/CAE_Oracle/actualJsonFiles/ORACLEVIEWTOMULTIPLETABLE.json           |
      | Constant.REST_DIR/response/CAE_Oracle/expectedJsonFiles/ORACLEVIEWFROMVIEWTOVIEWVIEWTOTABLE.json | Constant.REST_DIR/response/CAE_Oracle/actualJsonFiles/ORACLEVIEWFROMVIEWTOVIEWVIEWTOTABLE.json |
      | Constant.REST_DIR/response/CAE_Oracle/expectedJsonFiles/TRANSVIEW.json                           | Constant.REST_DIR/response/CAE_Oracle/actualJsonFiles/TRANSVIEW.json                           |


    ############################################End of Lineage Case##########################################################################


  Scenario Outline:PostCondition1#Delete Entry Point
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | bodyFile                                          | path                              | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDeleteEntryPoint/DeleteOracleEntryPoint                             | payloads/ida/CAEOracleCollector/pluginconfig.json | $.DeleteEntryPoint.configurations | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDeleteEntryPoint/DeleteOracleEntryPoint                             |                                                   |                                   | 200           | DeleteOracleEntryPoint |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEDeleteEntryPoint/DeleteOracleEntryPoint |                                                   |                                   | 200           | IDLE                   | $.[?(@.configurationName=='DeleteOracleEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/other/CAEDeleteEntryPoint/DeleteOracleEntryPoint  |                                                   |                                   | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEDeleteEntryPoint/DeleteOracleEntryPoint |                                                   |                                   | 200           | IDLE                   | $.[?(@.configurationName=='DeleteOracleEntryPoint')].status |


  Scenario Outline:SC#12PreCondition_Configure and run Create Entry Point,Oracle Collector with invalid schema included,Feed,Load Plugins
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                            | bodyFile                                          | path                              | response code | response message   | jsonPath                                                |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAECreateEntryPoint/OracleEntryPoint                                        | payloads/ida/CAEOracleCollector/pluginconfig.json | $.CAEOracleCreator.configurations | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAECreateEntryPoint/OracleEntryPoint                                        |                                                   |                                   | 200           | OracleEntryPoint   |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAECreateEntryPoint/OracleEntryPoint            |                                                   |                                   | 200           | IDLE               | $.[?(@.configurationName=='OracleEntryPoint')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/other/CAECreateEntryPoint/OracleEntryPoint             |                                                   |                                   | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAECreateEntryPoint/OracleEntryPoint            |                                                   |                                   | 200           | IDLE               | $.[?(@.configurationName=='OracleEntryPoint')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAE_Collector_for_Oracle/CAEOracleCollector                                 | payloads/ida/CAEOracleCollector/pluginconfig.json | $.InvalidSchema.configurations    | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAE_Collector_for_Oracle/CAEOracleCollector                                 |                                                   |                                   | 200           | CAEOracleCollector |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Oracle/CAEOracleCollector |                                                   |                                   | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleCollector')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/collector/CAE_Collector_for_Oracle/CAEOracleCollector  |                                                   |                                   | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Oracle/CAEOracleCollector |                                                   |                                   | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleCollector')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEFeed/CAEOracleFeed                                                       | payloads/ida/CAEOracleCollector/pluginconfig.json | $.CAEOracleFeeder.configurations  | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEFeed/CAEOracleFeed                                                       |                                                   |                                   | 200           | CAEOracleFeed      |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEFeed/CAEOracleFeed                           |                                                   |                                   | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleFeed')].status      |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/other/CAEFeed/CAEOracleFeed                            |                                                   |                                   | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEFeed/CAEOracleFeed                           |                                                   |                                   | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleFeed')].status      |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDDLoader/CAEOracleDDLoad                                                 | payloads/ida/CAEOracleCollector/pluginconfig.json | $.CAEOracleDDLoad.configurations  | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDDLoader/CAEOracleDDLoad                                                 |                                                   |                                   | 200           | CAEOracleDDLoad    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/CAEOracleDDLoad                 |                                                   |                                   | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleDDLoad')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/collector/CAEDDLoader/CAEOracleDDLoad                  |                                                   |                                   | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/CAEOracleDDLoad                 |                                                   |                                   | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleDDLoad')].status    |



  #7200353
  @webtest
  Scenario: SC12#Verify no items are collected when non existing schema is included in Oracle collector configuration
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CAE_ORACLE_BA" and clicks on search
    And user performs "facet selection" in "CAE_ORACLE_BA" attribute under "Tags" facets in Item Search results page
    Then user verify "non presence of facets" with following values under "Metadata Type" section in item search results page
      | Database |
      | Schema   |
      | Service  |
      | Cluster  |


  Scenario Outline:SC#13PreCondition_Configure and run Oracle Collector with few Types in Config lines,Feed,Load Plugins
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                            | bodyFile                                          | path                                          | response code | response message   | jsonPath                                                |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAE_Collector_for_Oracle/CAEOracleCollector                                 | payloads/ida/CAEOracleCollector/pluginconfig.json | $.CAEOracleCollectorTypeFilter.configurations | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAE_Collector_for_Oracle/CAEOracleCollector                                 |                                                   |                                               | 200           | CAEOracleCollector |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Oracle/CAEOracleCollector |                                                   |                                               | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleCollector')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/collector/CAE_Collector_for_Oracle/CAEOracleCollector  |                                                   |                                               | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Oracle/CAEOracleCollector |                                                   |                                               | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleCollector')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEFeed/CAEOracleFeed                                                       | payloads/ida/CAEOracleCollector/pluginconfig.json | $.CAEOracleFeeder.configurations              | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEFeed/CAEOracleFeed                                                       |                                                   |                                               | 200           | CAEOracleFeed      |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEFeed/CAEOracleFeed                           |                                                   |                                               | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleFeed')].status      |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/other/CAEFeed/CAEOracleFeed                            |                                                   |                                               | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEFeed/CAEOracleFeed                           |                                                   |                                               | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleFeed')].status      |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDDLoader/CAEOracleDDLoad                                                 | payloads/ida/CAEOracleCollector/pluginconfig.json | $.CAEOracleDDLoad.configurations              | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDDLoader/CAEOracleDDLoad                                                 |                                                   |                                               | 200           | CAEOracleDDLoad    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/CAEOracleDDLoad                 |                                                   |                                               | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleDDLoad')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/collector/CAEDDLoader/CAEOracleDDLoad                  |                                                   |                                               | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/CAEOracleDDLoad                 |                                                   |                                               | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleDDLoad')].status    |

  #7202455
  @webtest
  Scenario: SC13#Verify if only Data types provided in collector config lines are collected in DD
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CAE_ORACLE_BA" and clicks on search
    And user performs "definite facet selection" in "CAE_ORACLE_BA" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Database    |
      | Schema      |
      | Service     |
      | Analysis    |
      | DataType    |
      | DataPackage |
      | Cluster     |
      | Table       |
      | Column      |
    Then user verify "non presence of facets" with following values under "Metadata Type" section in item search results page
      | Trigger    |
      | Index      |
      | Constraint |
      | Routine    |

  Scenario Outline:SC14#PreCondition_Configure and run Loader with Clear option FALSE
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                            | bodyFile                                          | path                                 | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDDLoader/CAEOracleDDLoad                                 | payloads/ida/CAEOracleCollector/pluginconfig.json | $.CAEDDLoadClearFalse.configurations | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDDLoader/CAEOracleDDLoad                                 |                                                   |                                      | 200           | CAEOracleDDLoad  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/CAEOracleDDLoad |                                                   |                                      | 200           | IDLE             | $.[?(@.configurationName=='CAEOracleDDLoad')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/collector/CAEDDLoader/CAEOracleDDLoad  |                                                   |                                      | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/CAEOracleDDLoad |                                                   |                                      | 200           | IDLE             | $.[?(@.configurationName=='CAEOracleDDLoad')].status |

  #7201339
  @webtest
  Scenario: SC14#Verify if only Data types provided in collector config lines are collected in DD
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CAE_ORACLE_BA" and clicks on search
    And user performs "facet selection" in "CAE_ORACLE_BA" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Database    |
      | Schema      |
      | Analysis    |
      | DataType    |
      | DataPackage |
      | Service     |
      | Cluster     |
      | Table       |
      | Column      |

  Scenario Outline:SC15#PreCondition_Configure and run Loader with Clear option TRUE with technology values not in entry point
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                            | bodyFile                                          | path                                | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDDLoader/CAEOracleDDLoad                                 | payloads/ida/CAEOracleCollector/pluginconfig.json | $.CAEDDLoadClearTrue.configurations | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDDLoader/CAEOracleDDLoad                                 |                                                   |                                     | 200           | CAEOracleDDLoad  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/CAEOracleDDLoad |                                                   |                                     | 200           | IDLE             | $.[?(@.configurationName=='CAEOracleDDLoad')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/collector/CAEDDLoader/CAEOracleDDLoad  |                                                   |                                     | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/CAEOracleDDLoad |                                                   |                                     | 200           | IDLE             | $.[?(@.configurationName=='CAEOracleDDLoad')].status |


  #7201340
  @webtest
  Scenario: SC15#Verify if data collected in previous run is cleared when clear option is "TRUE" in CAEDD Loader plugin
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CAE_ORACLE_BA" and clicks on search
    And user performs "facet selection" in "CAE_ORACLE_BA" attribute under "Tags" facets in Item Search results page
    Then user verify "non presence of facets" with following values under "Metadata Type" section in item search results page
      | Database   |
      | Schema     |
      | Service    |
      | Cluster    |
      | Table      |
      | Column     |
      | Trigger    |
      | Index      |
      | Constraint |
      | Routine    |

  #7200351
  @webtest
  Scenario:SC16#Verify proper error message is shown if mandatory fields are not filled in CAE Oracle data source
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Data Sources" in "Add Data source Configuration"
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data source Configuration"
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute             |
      | Data Source Type | DataSource_for_Oracle |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute |
      | Name*     | A         |
    And user press "BACK_SPACE" key using key press event
    Then user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name*     | Name field should not be empty |

  #7200351
  @webtest
  Scenario:SC16#Verify proper error message is shown if mandatory fields are not filled in CAE Oracle Collector config page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem   |
      | Open Deployment | Headless-EDI |
    And user "click" on "Add Configuration" button under "Headless-EDI" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute                |
      | Type      | Collector                |
      | Plugin    | CAE_Collector_for_Oracle |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute |
      | Name*     | A         |
    And user press "BACK_SPACE" key using key press event
    Then user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name*     | Name field should not be empty |


  Scenario Outline:PostCondition2#Delete Entry Point
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | bodyFile                                          | path                              | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDeleteEntryPoint/DeleteOracleEntryPoint                             | payloads/ida/CAEOracleCollector/pluginconfig.json | $.DeleteEntryPoint.configurations | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDeleteEntryPoint/DeleteOracleEntryPoint                             |                                                   |                                   | 200           | DeleteOracleEntryPoint |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEDeleteEntryPoint/DeleteOracleEntryPoint |                                                   |                                   | 200           | IDLE                   | $.[?(@.configurationName=='DeleteOracleEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/other/CAEDeleteEntryPoint/DeleteOracleEntryPoint  |                                                   |                                   | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEDeleteEntryPoint/DeleteOracleEntryPoint |                                                   |                                   | 200           | IDLE                   | $.[?(@.configurationName=='DeleteOracleEntryPoint')].status |


    ######################################################################Filter Case: Schema Excluded###############################################################################################

  Scenario Outline:PreCondition17#Configure and run Oracle Collector with Schemas Excluded,Feed,Load Plugins
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                            | bodyFile                                          | path                                       | response code | response message   | jsonPath                                                |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAECreateEntryPoint/OracleEntryPoint                                        | payloads/ida/CAEOracleCollector/pluginconfig.json | $.CAEOracleCreator.configurations          | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAECreateEntryPoint/OracleEntryPoint                                        |                                                   |                                            | 200           | OracleEntryPoint   |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAECreateEntryPoint/OracleEntryPoint            |                                                   |                                            | 200           | IDLE               | $.[?(@.configurationName=='OracleEntryPoint')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/other/CAECreateEntryPoint/OracleEntryPoint             |                                                   |                                            | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAECreateEntryPoint/OracleEntryPoint            |                                                   |                                            | 200           | IDLE               | $.[?(@.configurationName=='OracleEntryPoint')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAE_Collector_for_Oracle/CAEOracleCollector                                 | payloads/ida/CAEOracleCollector/pluginconfig.json | $.CAEOracleCollectorExclude.configurations | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAE_Collector_for_Oracle/CAEOracleCollector                                 |                                                   |                                            | 200           | CAEOracleCollector |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Oracle/CAEOracleCollector |                                                   |                                            | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleCollector')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/collector/CAE_Collector_for_Oracle/CAEOracleCollector  |                                                   |                                            | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Oracle/CAEOracleCollector |                                                   |                                            | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleCollector')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEFeed/CAEOracleFeed                                                       | payloads/ida/CAEOracleCollector/pluginconfig.json | $.CAEOracleFeeder.configurations           | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEFeed/CAEOracleFeed                                                       |                                                   |                                            | 200           | CAEOracleFeed      |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEFeed/CAEOracleFeed                           |                                                   |                                            | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleFeed')].status      |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/other/CAEFeed/CAEOracleFeed                            |                                                   |                                            | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEFeed/CAEOracleFeed                           |                                                   |                                            | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleFeed')].status      |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDDLoader/CAEOracleDDLoad                                                 | payloads/ida/CAEOracleCollector/pluginconfig.json | $.CAEOracleDDLoad.configurations           | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDDLoader/CAEOracleDDLoad                                                 |                                                   |                                            | 200           | CAEOracleDDLoad    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/CAEOracleDDLoad                 |                                                   |                                            | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleDDLoad')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/collector/CAEDDLoader/CAEOracleDDLoad                  |                                                   |                                            | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/CAEOracleDDLoad                 |                                                   |                                            | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleDDLoad')].status    |


  @webtest
  Scenario: SC#17: Validate the data type counts in db2 after running collector, Feed and CAEDDLoader
    Given Verify Analysis log "collector/CAE_Collector_for_Oracle/CAEOracleCollector/%" info/error/warning for below parameters
      | assertion      | type | code           | logMessage                                                                 |
      | should contain | INFO | VHC-INF-300900 | VHC-INF-300900 : Total number of directory objects processed  =      12702 |
      | should contain | INFO | VHC-INF-300901 | VHC-INF-300901 : Total number of objects loaded               =      12702 |
      | should contain | INFO | VHC-INF-300902 | VHC-INF-300902 : Total number of objects deleted              =          0 |
    And Analysis log "collector/CAE_Collector_for_Oracle/CAEOracleCollector/%" should display below info/error/warning
      | type | logValue                                                                                                                                                     | logCode       | pluginName               | removableText |
      | INFO | ANALYSIS-0072: Plugin CAE_Collector_for_Oracle Start Time:2020-09-22 20:29:09.842, End Time:2020-09-22 20:29:11.896, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | CAE_Collector_for_Oracle |               |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                                               | ANALYSIS-0020 | CAE_Collector_for_Oracle |               |
    And Analysis log "collector/CAEDDLoader/CAEOracleDDLoad/%" should display below info/error/warning
      | type | logValue                                                                                                                            | logCode       | pluginName  | removableText |
      | INFO | Plugin CAEDDLoader Start Time:2020-09-22 20:30:28.559, End Time:2020-09-22 20:30:37.210, Processed Count:2472, Errors:0, Warnings:0 | ANALYSIS-0072 | CAEDDLoader |               |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                      | ANALYSIS-0020 | CAEDDLoader |               |
    And user delete all "Analysis" log with name "collector/CAE_Collector_for_Oracle/CAEOracleCollector/%" using database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify non presence" of following "Values" in Search Results Page
      | ORACLE12C_LINEAGESCHEMA1 | No data found |
    And user enters the search text "ORACLE12C_LINEAGESCHEMA2" and clicks on search
    And user performs "facet selection" in "CAE_ORACLE_BA" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Column |
      | Table  |
      | Index  |
      | Schema |
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName | dataBaseType | queryPath     | queryPage | queryField                    | columnName | queryOperation | facet         | facetValue | count      |
      | ORACLE12C    | STRUCTURED   | json/IDA.json | CAEORACLE | getLineageSchmea2_TableCount  | count      | returnValue    | Metadata Type | Table      | fromSource |
      | ORACLE12C    | STRUCTURED   | json/IDA.json | CAEORACLE | getLineageSchmea2_ColumnCount | count      | returnValue    | Metadata Type | Column     | fromSource |
      | ORACLE12C    | STRUCTURED   | json/IDA.json | CAEORACLE | getLineageSchmea2_IndexCount  | count      | returnValue    | Metadata Type | Index      | fromSource |
      |              |              |               |           |                               |            |                | Metadata Type | Schema     | 1          |


  Scenario Outline:PostCondition17#Delete Entry Point
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | bodyFile                                          | path                              | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDeleteEntryPoint/DeleteOracleEntryPoint                             | payloads/ida/CAEOracleCollector/pluginconfig.json | $.DeleteEntryPoint.configurations | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDeleteEntryPoint/DeleteOracleEntryPoint                             |                                                   |                                   | 200           | DeleteOracleEntryPoint |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEDeleteEntryPoint/DeleteOracleEntryPoint |                                                   |                                   | 200           | IDLE                   | $.[?(@.configurationName=='DeleteOracleEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/other/CAEDeleteEntryPoint/DeleteOracleEntryPoint  |                                                   |                                   | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEDeleteEntryPoint/DeleteOracleEntryPoint |                                                   |                                   | 200           | IDLE                   | $.[?(@.configurationName=='DeleteOracleEntryPoint')].status |

  Scenario:SC#17:Delete Cluster and all the Analysis log for db2 for entry point deletion
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                    | type     | query | param |
      | MultipleIDDelete | Default | other/CAECreateEntryPoint/OracleEntryPoint/%            | Analysis |       |       |
      | MultipleIDDelete | Default | other/CAEDeleteEntryPoint/DeleteOracleEntryPoint/%      | Analysis |       |       |
      | MultipleIDDelete | Default | other/CAEFeed/CAEOracleFeed/%                           | Analysis |       |       |
      | MultipleIDDelete | Default | collector/CAEDDLoader/CAEOracleDDLoad/%                 | Analysis |       |       |
      | MultipleIDDelete | Default | collector/CAE_Collector_for_Oracle/CAEOracleCollector/% | Analysis |       |       |
      | MultipleIDDelete | Default | other/CAELineage/CAEOracleLineage/%                     | Analysis |       |       |


  ###################################################################################Incremental Scenario for Addition of Data##############################################################

  ##7201337##
  Scenario Outline:PreCondition18#Configure and run Oracle Collector with Schemas Include,Feed,Load Plugins
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                            | bodyFile                                          | path                                                       | response code | response message   | jsonPath                                                |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAECreateEntryPoint/OracleEntryPoint                                        | payloads/ida/CAEOracleCollector/pluginconfig.json | $.CAEOracleCreator.configurations                          | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAECreateEntryPoint/OracleEntryPoint                                        |                                                   |                                                            | 200           | OracleEntryPoint   |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAECreateEntryPoint/OracleEntryPoint            |                                                   |                                                            | 200           | IDLE               | $.[?(@.configurationName=='OracleEntryPoint')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/other/CAECreateEntryPoint/OracleEntryPoint             |                                                   |                                                            | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAECreateEntryPoint/OracleEntryPoint            |                                                   |                                                            | 200           | IDLE               | $.[?(@.configurationName=='OracleEntryPoint')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAE_Collector_for_Oracle/CAEOracleCollector                                 | payloads/ida/CAEOracleCollector/pluginconfig.json | $.CAEOracleCollectorIncremental_ProcessLoad.configurations | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAE_Collector_for_Oracle/CAEOracleCollector                                 |                                                   |                                                            | 200           | CAEOracleCollector |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Oracle/CAEOracleCollector |                                                   |                                                            | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleCollector')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/collector/CAE_Collector_for_Oracle/CAEOracleCollector  |                                                   |                                                            | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Oracle/CAEOracleCollector |                                                   |                                                            | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleCollector')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEFeed/CAEOracleFeed                                                       | payloads/ida/CAEOracleCollector/pluginconfig.json | $.CAEOracleFeeder.configurations                           | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEFeed/CAEOracleFeed                                                       |                                                   |                                                            | 200           | CAEOracleFeed      |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEFeed/CAEOracleFeed                           |                                                   |                                                            | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleFeed')].status      |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/other/CAEFeed/CAEOracleFeed                            |                                                   |                                                            | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEFeed/CAEOracleFeed                           |                                                   |                                                            | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleFeed')].status      |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDDLoader/CAEOracleDDLoad                                                 | payloads/ida/CAEOracleCollector/pluginconfig.json | $.CAEOracleDDLoad.configurations                           | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDDLoader/CAEOracleDDLoad                                                 |                                                   |                                                            | 200           | CAEOracleDDLoad    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/CAEOracleDDLoad                 |                                                   |                                                            | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleDDLoad')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/collector/CAEDDLoader/CAEOracleDDLoad                  |                                                   |                                                            | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/CAEOracleDDLoad                 |                                                   |                                                            | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleDDLoad')].status    |


  ##7201337##
  @webtest
  Scenario: SC#18: Validate the data type counts in Oracle after running collector, Feed and CAEDDLoader (Before Incremental Verification)
    Given Verify Analysis log "collector/CAE_Collector_for_Oracle/CAEOracleCollector/%" info/error/warning for below parameters
      | assertion      | type | code           | logMessage                                                                 |
      | should contain | INFO | VHC-INF-300900 | VHC-INF-300900 : Total number of directory objects processed  =         92 |
      | should contain | INFO | VHC-INF-300901 | VHC-INF-300901 : Total number of objects loaded               =         92 |
      | should contain | INFO | VHC-INF-300902 | VHC-INF-300902 : Total number of objects deleted              =          0 |
    And Analysis log "collector/CAE_Collector_for_Oracle/CAEOracleCollector/%" should display below info/error/warning
      | type | logValue                                                                                                                                                     | logCode       | pluginName               | removableText |
      | INFO | ANALYSIS-0072: Plugin CAE_Collector_for_Oracle Start Time:2020-09-22 20:29:09.842, End Time:2020-09-22 20:29:11.896, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | CAE_Collector_for_Oracle |               |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                                               | ANALYSIS-0020 | CAE_Collector_for_Oracle |               |
    And Analysis log "collector/CAEDDLoader/CAEOracleDDLoad/%" should display below info/error/warning
      | type | logValue                                                                                                                           | logCode       | pluginName  | removableText |
      | INFO | Plugin CAEDDLoader Start Time:2020-09-22 20:30:28.559, End Time:2020-09-22 20:30:37.210, Processed Count:655, Errors:0, Warnings:0 | ANALYSIS-0072 | CAEDDLoader |               |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                     | ANALYSIS-0020 | CAEDDLoader |               |
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Oracle" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName | dataBaseType | queryPath     | queryPage | queryField                   | columnName | queryOperation | facet         | facetValue | count      |
      | ORACLE12C    | STRUCTURED   | json/IDA.json | CAEORACLE | getLineageSchmea1_TableCount | count      | returnValue    | Metadata Type | Table      | fromSource |


  @jdbc
  Scenario:SC#18: create Table for incremental scenario
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage | queryField                |
      | ORACLE12C          | EXECUTEQUERY | json/IDA.json | CAEORACLE | createTableForIncremental |
      | ORACLE12C          | EXECUTEQUERY | json/IDA.json | CAEORACLE | createViewForIncremental  |


  ##7201337##
  Scenario Outline:PreCondition18#Configure and run Oracle Collector with Schemas Include,Feed,Load Plugins (Process Auto)
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                            | bodyFile                                          | path                                                       | response code | response message   | jsonPath                                                |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAE_Collector_for_Oracle/CAEOracleCollector                                 | payloads/ida/CAEOracleCollector/pluginconfig.json | $.CAEOracleCollectorIncremental_ProcessAuto.configurations | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAE_Collector_for_Oracle/CAEOracleCollector                                 |                                                   |                                                            | 200           | CAEOracleCollector |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Oracle/CAEOracleCollector |                                                   |                                                            | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleCollector')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/collector/CAE_Collector_for_Oracle/CAEOracleCollector  |                                                   |                                                            | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Oracle/CAEOracleCollector |                                                   |                                                            | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleCollector')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEFeed/CAEOracleFeed                                                       | payloads/ida/CAEOracleCollector/pluginconfig.json | $.CAEOracleFeeder.configurations                           | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEFeed/CAEOracleFeed                                                       |                                                   |                                                            | 200           | CAEOracleFeed      |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEFeed/CAEOracleFeed                           |                                                   |                                                            | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleFeed')].status      |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/other/CAEFeed/CAEOracleFeed                            |                                                   |                                                            | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEFeed/CAEOracleFeed                           |                                                   |                                                            | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleFeed')].status      |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDDLoader/CAEOracleDDLoad                                                 | payloads/ida/CAEOracleCollector/pluginconfig.json | $.CAEOracleDDLoadIncremental.configurations                | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDDLoader/CAEOracleDDLoad                                                 |                                                   |                                                            | 200           | CAEOracleDDLoad    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/CAEOracleDDLoad                 |                                                   |                                                            | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleDDLoad')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/collector/CAEDDLoader/CAEOracleDDLoad                  |                                                   |                                                            | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/CAEOracleDDLoad                 |                                                   |                                                            | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleDDLoad')].status    |


  ##7201337##
  @webtest
  Scenario: SC#18: Validate the data type counts in Oracle after running collector, Feed and CAEDDLoader (Incremental Verification)
    Given Verify Analysis log "collector/CAE_Collector_for_Oracle/CAEOracleCollector/%" info/error/warning for below parameters
      | assertion      | type | code           | logMessage                                                                 |
      | should contain | INFO | VHC-INF-300900 | VHC-INF-300900 : Total number of directory objects processed  =         94 |
      | should contain | INFO | VHC-INF-300901 | VHC-INF-300901 : Total number of objects loaded               =          2 |
      | should contain | INFO | VHC-INF-300902 | VHC-INF-300902 : Total number of objects deleted              =          0 |
    And Analysis log "collector/CAE_Collector_for_Oracle/CAEOracleCollector/%" should display below info/error/warning
      | type | logValue                                                                                                                                                     | logCode       | pluginName               | removableText |
      | INFO | ANALYSIS-0072: Plugin CAE_Collector_for_Oracle Start Time:2020-09-22 20:29:09.842, End Time:2020-09-22 20:29:11.896, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | CAE_Collector_for_Oracle |               |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                                               | ANALYSIS-0020 | CAE_Collector_for_Oracle |               |
    And Analysis log "collector/CAEDDLoader/CAEOracleDDLoad/%" should display below info/error/warning
      | type | logValue                                                                                                                          | logCode       | pluginName  | removableText |
      | INFO | Plugin CAEDDLoader Start Time:2020-09-22 20:30:28.559, End Time:2020-09-22 20:30:37.210, Processed Count:10, Errors:0, Warnings:0 | ANALYSIS-0072 | CAEDDLoader |               |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                    | ANALYSIS-0020 | CAEDDLoader |               |
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Oracle" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName | dataBaseType | queryPath     | queryPage | queryField                   | columnName | queryOperation | facet         | facetValue | count      |
      | ORACLE12C    | STRUCTURED   | json/IDA.json | CAEORACLE | getLineageSchmea1_TableCount | count      | returnValue    | Metadata Type | Table      | fromSource |


  ###########################################################Verify Incremental Scenario for Deleting the Data from OracleDB########################################################################

  @jdbc
  Scenario:SC#19: drop Table for incremental scenario
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage | queryField              |
      | ORACLE12C          | EXECUTEQUERY | json/IDA.json | CAEORACLE | dropTableForIncremental |
      | ORACLE12C          | EXECUTEQUERY | json/IDA.json | CAEORACLE | dropViewForIncremental  |


  ##7201338##
  Scenario Outline:PreCondition19#Configure and run Oracle Collector with Schemas Include,Feed,Load Plugins (Process Auto)
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                            | bodyFile                                          | path                                                       | response code | response message   | jsonPath                                                |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAE_Collector_for_Oracle/CAEOracleCollector                                 | payloads/ida/CAEOracleCollector/pluginconfig.json | $.CAEOracleCollectorIncremental_ProcessAuto.configurations | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAE_Collector_for_Oracle/CAEOracleCollector                                 |                                                   |                                                            | 200           | CAEOracleCollector |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Oracle/CAEOracleCollector |                                                   |                                                            | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleCollector')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/collector/CAE_Collector_for_Oracle/CAEOracleCollector  |                                                   |                                                            | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Oracle/CAEOracleCollector |                                                   |                                                            | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleCollector')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEFeed/CAEOracleFeed                                                       | payloads/ida/CAEOracleCollector/pluginconfig.json | $.CAEOracleFeeder.configurations                           | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEFeed/CAEOracleFeed                                                       |                                                   |                                                            | 200           | CAEOracleFeed      |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEFeed/CAEOracleFeed                           |                                                   |                                                            | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleFeed')].status      |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/other/CAEFeed/CAEOracleFeed                            |                                                   |                                                            | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEFeed/CAEOracleFeed                           |                                                   |                                                            | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleFeed')].status      |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDDLoader/CAEOracleDDLoad                                                 | payloads/ida/CAEOracleCollector/pluginconfig.json | $.CAEOracleDDLoadNegative.configurations                   | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDDLoader/CAEOracleDDLoad                                                 |                                                   |                                                            | 200           | CAEOracleDDLoad    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/CAEOracleDDLoad                 |                                                   |                                                            | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleDDLoad')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/collector/CAEDDLoader/CAEOracleDDLoad                  |                                                   |                                                            | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/CAEOracleDDLoad                 |                                                   |                                                            | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleDDLoad')].status    |


  ##7201338## ##Bug-ID MLP-28935##
  @webtest
  Scenario: SC#19: Validate the data type counts in Oracle after running collector, Feed and CAEDDLoader (Incremental Verification)
    Given Verify Analysis log "collector/CAE_Collector_for_Oracle/CAEOracleCollector/%" info/error/warning for below parameters
      | assertion      | type | code           | logMessage                                                                 |
      | should contain | INFO | VHC-INF-300900 | VHC-INF-300900 : Total number of directory objects processed  =         92 |
      | should contain | INFO | VHC-INF-300901 | VHC-INF-300901 : Total number of objects loaded               =          0 |
      | should contain | INFO | VHC-INF-300902 | VHC-INF-300902 : Total number of objects deleted              =          2 |
    And Analysis log "collector/CAE_Collector_for_Oracle/CAEOracleCollector/%" should display below info/error/warning
      | type | logValue                                                                                                                                                     | logCode       | pluginName               | removableText |
      | INFO | ANALYSIS-0072: Plugin CAE_Collector_for_Oracle Start Time:2020-09-22 20:29:09.842, End Time:2020-09-22 20:29:11.896, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | CAE_Collector_for_Oracle |               |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                                               | ANALYSIS-0020 | CAE_Collector_for_Oracle |               |
    And Analysis log "collector/CAEDDLoader/CAEOracleDDLoad/%" should display below info/error/warning
      | type | logValue                                                                                                                         | logCode       | pluginName  | removableText |
      | INFO | Plugin CAEDDLoader Start Time:2020-09-22 20:30:28.559, End Time:2020-09-22 20:30:37.210, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | CAEDDLoader |               |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                   | ANALYSIS-0020 | CAEDDLoader |               |
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Oracle" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName | dataBaseType | queryPath     | queryPage | queryField                   | columnName | queryOperation | facet         | facetValue | count      |
      | ORACLE12C    | STRUCTURED   | json/IDA.json | CAEORACLE | getLineageSchmea1_TableCount | count      | returnValue    | Metadata Type | Table      | fromSource |


  Scenario:SC#19:Delete Cluster and all the Analysis log for db2 for entry point deletion
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                    | type     | query | param |
      | MultipleIDDelete | Default | other/CAEFeed/CAEOracleFeed/%                           | Analysis |       |       |
      | MultipleIDDelete | Default | collector/CAEDDLoader/CAEOracleDDLoad/%                 | Analysis |       |       |
      | MultipleIDDelete | Default | collector/CAE_Collector_for_Oracle/CAEOracleCollector/% | Analysis |       |       |


  ############################################################Verification of the Process Delete for CAEOracle Collector, Followed by CAEFeed and CAEDDLoader###########################################################################

   ##7203854##
  Scenario Outline:PreCondition20#Configure and run Oracle Collector with Schemas Include,Feed,Load Plugins (Process Delete)
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                            | bodyFile                                          | path                                                         | response code | response message   | jsonPath                                                |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAE_Collector_for_Oracle/CAEOracleCollector                                 | payloads/ida/CAEOracleCollector/pluginconfig.json | $.CAEOracleCollectorIncremental_ProcessDelete.configurations | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAE_Collector_for_Oracle/CAEOracleCollector                                 |                                                   |                                                              | 200           | CAEOracleCollector |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Oracle/CAEOracleCollector |                                                   |                                                              | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleCollector')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/collector/CAE_Collector_for_Oracle/CAEOracleCollector  |                                                   |                                                              | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Oracle/CAEOracleCollector |                                                   |                                                              | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleCollector')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEFeed/CAEOracleFeed                                                       | payloads/ida/CAEOracleCollector/pluginconfig.json | $.CAEOracleFeeder.configurations                             | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEFeed/CAEOracleFeed                                                       |                                                   |                                                              | 200           | CAEOracleFeed      |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEFeed/CAEOracleFeed                           |                                                   |                                                              | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleFeed')].status      |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/other/CAEFeed/CAEOracleFeed                            |                                                   |                                                              | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEFeed/CAEOracleFeed                           |                                                   |                                                              | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleFeed')].status      |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDDLoader/CAEOracleDDLoad                                                 | payloads/ida/CAEOracleCollector/pluginconfig.json | $.CAEOracleDDLoadNegative.configurations                     | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDDLoader/CAEOracleDDLoad                                                 |                                                   |                                                              | 200           | CAEOracleDDLoad    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/CAEOracleDDLoad                 |                                                   |                                                              | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleDDLoad')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/collector/CAEDDLoader/CAEOracleDDLoad                  |                                                   |                                                              | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/CAEOracleDDLoad                 |                                                   |                                                              | 200           | IDLE               | $.[?(@.configurationName=='CAEOracleDDLoad')].status    |


  ##7203854## ##Bug-ID MLP-28935##
  @webtest
  Scenario: SC#20: Validate the data type counts in Oracle after running collector, Feed and CAEDDLoader (PROCESS DELETE)
    Given Verify Analysis log "collector/CAE_Collector_for_Oracle/CAEOracleCollector/%" info/error/warning for below parameters
      | assertion      | type | code           | logMessage                                                                 |
      | should contain | INFO | VHC-INF-300900 | VHC-INF-300900 : Total number of directory objects processed  =          0 |
      | should contain | INFO | VHC-INF-300901 | VHC-INF-300901 : Total number of objects loaded               =          0 |
      | should contain | INFO | VHC-INF-300902 | VHC-INF-300902 : Total number of objects deleted              =         92 |
    And Analysis log "collector/CAE_Collector_for_Oracle/CAEOracleCollector/%" should display below info/error/warning
      | type | logValue                                                                                                                                                     | logCode       | pluginName               | removableText |
      | INFO | ANALYSIS-0072: Plugin CAE_Collector_for_Oracle Start Time:2020-09-22 20:29:09.842, End Time:2020-09-22 20:29:11.896, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | CAE_Collector_for_Oracle |               |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                                               | ANALYSIS-0020 | CAE_Collector_for_Oracle |               |
    And Analysis log "collector/CAEDDLoader/CAEOracleDDLoad/%" should display below info/error/warning
      | type | logValue                                                                                                                          | logCode       | pluginName  | removableText |
      | INFO | Plugin CAEDDLoader Start Time:2020-09-22 20:30:28.559, End Time:2020-09-22 20:30:37.210, Processed Count:13, Errors:0, Warnings:0 | ANALYSIS-0072 | CAEDDLoader |               |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                    | ANALYSIS-0020 | CAEDDLoader |               |
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify non presence" of following "Values" in Search Results Page
      | DIDORACLE01V.DID.DEV.ASGINT.LOC | No data found |

  Scenario Outline:PostCondition20#Delete Entry point
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | bodyFile                                          | path                              | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDeleteEntryPoint/DeleteOracleEntryPoint                             | payloads/ida/CAEOracleCollector/pluginconfig.json | $.DeleteEntryPoint.configurations | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDeleteEntryPoint/DeleteOracleEntryPoint                             |                                                   |                                   | 200           | DeleteOracleEntryPoint |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEDeleteEntryPoint/DeleteOracleEntryPoint |                                                   |                                   | 200           | IDLE                   | $.[?(@.configurationName=='DeleteOracleEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/other/CAEDeleteEntryPoint/DeleteOracleEntryPoint  |                                                   |                                   | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEDeleteEntryPoint/DeleteOracleEntryPoint |                                                   |                                   | 200           | IDLE                   | $.[?(@.configurationName=='DeleteOracleEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Delete       | settings/analyzers/CAEDeleteEntryPoint/DeleteOracleEntryPoint                             |                                                   |                                   | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Delete       | settings/analyzers/CAECreateEntryPoint/OracleEntryPoint                                   |                                                   |                                   | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Delete       | settings/analyzers/CAE_Collector_for_Oracle/CAEOracleCollector                            |                                                   |                                   | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Delete       | settings/analyzers/CAEFeed/CAEOracleFeed                                                  |                                                   |                                   | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Delete       | settings/analyzers/CAEDDLoader/CAEOracleDDLoad                                            |                                                   |                                   | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Delete       | settings/analyzers/DataSource_for_Oracle/CAEOracleCollectorDS                             |                                                   |                                   | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Delete       | settings/analyzers/CAEDataSource/CAEFeedETLLINDS                                          |                                                   |                                   | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Delete       | settings/analyzers/CAEDataSource/OracleEntryPointCreateDS                                 |                                                   |                                   | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Delete       | settings/credentials/OracleEntryPointServer                                               |                                                   |                                   | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Delete       | settings/credentials/Oracle12CDataServer                                                  |                                                   |                                   | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Delete       | settings/credentials/OracleEntryPoint                                                     |                                                   |                                   | 200           |                        |                                                             |

  Scenario:SC#20:Delete Cluster and all the Analysis log for db2 for entry point deletion
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                    | type     | query | param |
      | SingleItemDelete | Default | DIDORACLE01V.DID.DEV.ASGINT.LOC                         | Cluster  |       |       |
      | MultipleIDDelete | Default | other/CAECreateEntryPoint/OracleEntryPoint/%            | Analysis |       |       |
      | MultipleIDDelete | Default | other/CAEDeleteEntryPoint/DeleteOracleEntryPoint/%      | Analysis |       |       |
      | MultipleIDDelete | Default | other/CAEFeed/CAEOracleFeed/%                           | Analysis |       |       |
      | MultipleIDDelete | Default | collector/CAEDDLoader/CAEOracleDDLoad/%                 | Analysis |       |       |
      | MultipleIDDelete | Default | collector/CAE_Collector_for_Oracle/CAEOracleCollector/% | Analysis |       |       |