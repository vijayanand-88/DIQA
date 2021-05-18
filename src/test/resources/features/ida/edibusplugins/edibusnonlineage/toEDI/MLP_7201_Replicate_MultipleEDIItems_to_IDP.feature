Feature: MLP-7201 Replicating Multiple EDI items mapped to a IDP item

  @MLP-7201 @sanity @positive @regression
  Scenario Outline:Precondition:Run the Plugin configurations for Git
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                         | body                                        | response code | response message               | jsonPath                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/credentials/sparkGitEDIBus                                                         | idc/EdiBusPayloads/GitCredentials.json      | 200           |                                |                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollectorDataSource                                                   | idc/EdiBusPayloads/gitDatasourceConfig.json | 204           |                                |                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                                             | idc/EdiBusPayloads/Git_Pyspark.json         | 204           |                                |                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/GitCollector                                                             |                                             | 200           | GitCollector_TransformationAPI |                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector_TransformationAPI |                                             | 200           | IDLE                           | $.[?(@.configurationName=='GitCollector_TransformationAPI')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector_TransformationAPI  | idc/EdiBusPayloads/Git_Pyspark_empty.json   | 200           |                                |                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector_TransformationAPI |                                             | 200           | IDLE                           | $.[?(@.configurationName=='GitCollector_TransformationAPI')].status |


  @edibus @mlp-7612 @webtest @positive @toEDI
  Scenario:MLP-7612_SC1#_Verification of attributes item in metability for EDI
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                    | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP-7612_Config.json | 204           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/FileAttributes |                                         | 200           | IDLE             | $.[?(@.configurationName=='FileAttributes')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/FileAttributes  |                                         | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/FileAttributes |                                         | 200           | IDLE             | $.[?(@.configurationName=='FileAttributes')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "FileAttributes" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/FileAttributes%"
    Then METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |
    And user connects Rochade Server and "verify attributeValues" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | itemName       | itemType     | attributeName          | attributeValue |
      | AP-DATA      | AUTOMATION  | 1.0                | with_column.py | DWR_DAT_FILE | DWR_ORIG_CREATION_USER | Siddharthan.G  |
      | AP-DATA      | AUTOMATION  | 1.0                | with_column.py | DWR_DAT_FILE | DWR_DAT_SIZE           | 2254           |
      | AP-DATA      | AUTOMATION  | 1.0                | with_column.py | DWR_DAT_FILE | DWR_DAT_CONTENT_TYPE   | text/x-python  |
#      | AP-DATA      | AUTOMATION  | 1.0                | /user/hive/warehouse/ice_supply | DWR_DAT_DIRECTORY | DWR_ORIG_CREATION_GROUP | hive           |
#      | AP-DATA      | AUTOMATION  | 1.0                | /user/hive/warehouse/ice_supply | DWR_DAT_DIRECTORY | DWR_ORIG_CREATION_USER  | root           |
#      | AP-DATA      | AUTOMATION  | 1.0                | /user/hive/warehouse/ice_supply | DWR_DAT_DIRECTORY | DWR_DAT_PERMISSIONS     | rwxrwxrwx      |
    And user clicks on logout button

  @edibus @positive
  Scenario:MLP-7612_SC2#_Delete plugin Configurations and Clearing of Subject Area in EDI
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                   | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/FileAttributes%                            | Analysis |       |       |
      | SingleItemDelete | Default | pythonanalyzerdemo                                     | Project  |       |       |
      | SingleItemDelete | Default | collector/GitCollector/GitCollector_TransformationAPI% | Analysis |       |       |
    And  Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                       | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/EDIBus                 |      | 204           |                  |          |
      |                  |       |       | Delete | settings/credentials/sparkGitEDIBus       |      | 200           |                  |          |
      |                  |       |       | Delete | settings/analyzers/GitCollectorDataSource |      | 204           |                  |          |
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
