Feature: MLP_26233_MLP-26841_Replicate attribute values to DD

  @MLP-26233 @edibus
  Scenario Outline: SC1#-Set the DataSource for Attribute
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                           | bodyFile                                                           | path                                       | response code | response message          | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusAttributeDataSource | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusAttributeDataSource.configurations | 204           |                           |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                           |                                                                    |                                            | 200           | EDIBusAttributeDataSource |          |

#7191030#
  @edibus @mlp-26233 @webtest @positive @toIDP
  Scenario:SC1#MLP-26233 Verification of RDB attribute values to DD
    Given user update the json file "idc/EdiBusPayloads/MLP_26233_AttributeConfig.json" file for following values
      | jsonPath        | jsonValues |
      | $..['function'] | replicate  |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                              | response code | response message | jsonPath                                             |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                            | idc/EdiBusPayloads/MLP_26233_AttributeConfig.json | 204           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/AttributeEDIBus |                                                   | 200           | IDLE             | $.[?(@.configurationName=='AttributeEDIBus')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/AttributeEDIBus  |                                                   | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/AttributeEDIBus |                                                   | 200           | IDLE             | $.[?(@.configurationName=='AttributeEDIBus')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/AttributeEDIBus%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/AttributeEDIBus%" should display below info/error/warning
      | type | logValue                | logCode      | pluginName | removableText |
      | INFO | replication of 71 items | EDIBUS-I0024 |            |               |
    And user enters the search text "AttributeDBSystem" and clicks on search
    And user performs "facet selection" in "AttributeDBSystem≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Service" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "AttributeDBSystem≫DB" item from search results
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                      |
      | Definition        | This is the RDB test service.                      |
      | Description       | The test service is best described as a test case. |
    Then user performs click and verify in new window
      | Table     | value             | Action               | RetainPrevwindow | indexSwitch |
      | Databases | AttributeDatabase | click and switch tab | No               |             |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                       |
      | Definition        | This is the RDB test database.                      |
      | Description       | The test database is best described as a test case. |
      | Storage type      | ON_DISK                                             |
    Then user performs click and verify in new window
      | Table   | value           | Action               | RetainPrevwindow | indexSwitch |
      | Schemas | AttributeSchema | click and switch tab | No               |             |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue  |
      | Definition        | TestDefinition |
      | Description       | Test           |
    Then user performs click and verify in new window
      | Table  | value          | Action               | RetainPrevwindow | indexSwitch |
      | Tables | AttributeTable | click and switch tab | No               |             |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                    |
#      | Definition        | This is the RDB test table.                      |
      | Description       | The test table is best described as a test case. |
      | Table Type        | VIEW                                             |
      | Created by        | EDIBUS-1.0                                       |
      | Modified by       | EDIBUS-1.1                                       |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue            | widgetName |
      | Created           | Aug 28, 2020, 5:49:31 AM | Lifecycle  |
      | Modified          | Aug 28, 2020, 6:16:29 AM | Lifecycle  |
    Then user performs click and verify in new window
      | Table     | value     | Action               | RetainPrevwindow | indexSwitch |
      | SQLSource | SQLSource | click and switch tab | No               |             |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue         | widgetName |
      | Data              | select * from nowhere | Data       |
    And user enters the search text "AttributeColumn" and clicks on search
    And user performs "facet selection" in "AttributeDBSystem≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "AttributeColumn" item from search results
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                     |
#      | Definition        | This is the RDB test column.                      |
      | Description       | The test column is best described as a test case. |
      | Created by        | EDIBUS-1.0                                        |
      | Modified by       | EDIBUS-1.1                                        |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue            | widgetName |
      | Created           | Aug 28, 2020, 5:49:31 AM | Lifecycle  |
      | Modified          | Aug 28, 2020, 5:49:32 AM | Lifecycle  |
      | Length            | 10                       | Statistics |
#      | dataDefaultValue  | 2                        | Statistics |
#      | dataAllowedValues | 1,2,3       | Statistics |
    And user enters the search text "AttributeTrigger" and clicks on search
    And user performs "facet selection" in "AttributeDBSystem≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "AttributeTrigger" item from search results
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                 |
      | Definition        | This is the RDB test trigger. |
      | Created by        | EDIBUS-1.0                    |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue            | widgetName |
      | Created           | Aug 28, 2020, 6:26:20 AM | Lifecycle  |
      | Modified          | Aug 28, 2020, 6:26:50 AM | Lifecycle  |
    Then user performs click and verify in new window
      | Table     | value     | Action               | RetainPrevwindow | indexSwitch |
      | SQLSource | SQLSource | click and switch tab | No               |             |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue       | widgetName  |
      | source            | select * from table | Description |
    And user enters the search text "AttributeProcedure" and clicks on search
    And user performs "facet selection" in "AttributeDBSystem≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "AttributeProcedure≫Procedure" item from search results
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                   |
      | Definition        | This is the RDB test procedure. |
      | Created by        | EDIBUS-1.0                      |
      | routineType       | PROCEDURE                       |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue            | widgetName |
      | Created           | Aug 28, 2020, 6:48:34 AM | Lifecycle  |
      | Modified          | Aug 28, 2020, 6:48:34 AM | Lifecycle  |
    Then user performs click and verify in new window
      | Table     | value    | Action               | RetainPrevwindow | indexSwitch |
      | SQLSource | SQLSoure | click and switch tab | No               |             |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue       | widgetName  |
      | source            | select * from table | Description |
    And user enters the search text "AttributeFunction" and clicks on search
    And user performs "facet selection" in "AttributeDBSystem≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "AttributeFunction≫Function" item from search results
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                  |
      | Definition        | This is the RDB test function. |
      | Created by        | EDIBUS-1.0                     |
      | routineType       | FUNCTION                       |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue            | widgetName |
      | Created           | Aug 28, 2020, 6:50:43 AM | Lifecycle  |
      | Modified          | Aug 28, 2020, 6:51:22 AM | Lifecycle  |
    Then user performs click and verify in new window
      | Table     | value     | Action               | RetainPrevwindow | indexSwitch |
      | SQLSource | SQLSource | click and switch tab | No               |             |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue       | widgetName  |
      | source            | select * from table | Description |

#7191031#
  @edibus @mlp-26233 @webtest @positive @toIDP
  Scenario:SC2#MLP-26233 Verification of DAT attribute values to DD
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AttributeDataPackage" and clicks on search
    And user performs "facet selection" in "AttributeDataPackage [DataPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "AttributeDataPackage" item from search results
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue  |
      | Definition        | TestDefinition |
      | Description       | Test           |
    Then user performs click and verify in new window
      | Table         | value        | Action               | RetainPrevwindow | indexSwitch |
      | Data Packages | PackageCheck | click and switch tab | No               |             |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue    |
      | Definition        | Test             |
      | Description       | Test description |
    And user enters the search text "AttributeRecordType" and clicks on search
    And user performs "facet selection" in "AttributeDataPackage [DataPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "AttributeRecordType" item from search results
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue  |
      | Definition        | TestDefinition |
      | Description       | Test           |
    And user enters the search text "AttributeField" and clicks on search
    And user performs "facet selection" in "AttributeFile [File]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "AttributeField" item from search results
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName |
      | Length            | 10            | Statistics |
      | Minimum length    | 0             | Statistics |
#      | dataScale         | 0                  | Statistics  |
#      | Definition        | TestDefinition     | Description |
#      | Description       | Test               | Description |
#      | dataDefaultValue  | TRUE               | Description |
#      | dataAllowedValues | TRUE ,FALSE ,OTHER | Description |
    And user enters the search text "AttributeDataDomain" and clicks on search
    And user performs "facet selection" in "AttributeDataPackage [DataPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "AttributeDataDomain" item from search results
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue  |
      | Definition        | TestDefinition |
      | Description       | Desc           |
    And user enters the search text "AttributeDataType" and clicks on search
    And user performs "facet selection" in "AttributeDataPackage [DataPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "AttributeDataType" item from search results
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                        |
      | Definition        | TestDefinition                                       |
      | Description       | The test data type is best described as a test case. |
      | Data type         | text                                                 |
      | dataDefaultValue  | TRUE                                                 |
      | dataAllowedValues | TRUE ,FALSE ,OTHER                                   |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName |
      | dataLength        | 10            | Statistics |
      | dataMinimumLength | 0             | Statistics |
      | dataScale         | 0             | Statistics |
    And user enters the search text "AttributeFileSystem≫FS" and clicks on search
    And user performs "facet selection" in "AttributeFileSystem≫FS [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "AttributeFileSystem≫FS" item from search results
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                          |
      | Definition        | This is the test file system.                          |
      | Description       | The test file system is best described as a test case. |
    And user enters the search text "AttributeTestDirectory" and clicks on search
    And user performs "facet selection" in "AttributeFileSystem≫FS [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "AttributeTestDirectory" item from search results
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                       | widgetName  |
      | Definition        | This is the test directory.                         | Description |
      | Description       | The test directory is best described as a test case | Description |
      | Permission        | RW                                                  | Description |
      | Group             | dev                                                 | Description |
      | Created by        | Test                                                | Description |
#      | Modified by       | TestOne                                             | Description |
      | Created           | Aug 28, 2020, 5:19:06 AM                            | Lifecycle   |
      | Modified          | Aug 28, 2020, 9:20:00 AM                            | Lifecycle   |
      | Size of files     | 120000                                              | Statistics  |
    Then user performs click and verify in new window
      | Table | value            | Action               | RetainPrevwindow | indexSwitch |
      | Files | AttributeFileOne | click and switch tab | No               |             |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                  | widgetName  |
#      | Definition        | This is the test file.                         | Description |
      | Description       | The test file is best described as a test case | Description |
      | Permission        | RW                                             | Description |
      | Group             | dev                                            | Description |
      | Created by        | Test                                           | Description |
      | Modified by       | TestOne                                        | Description |
      | File size         | 120.00 Bytes                                   | Description |
      | MIME type         | xml                                            | Description |
      | Created           | Aug 28, 2020, 7:23:13 AM                       | Lifecycle   |
      | Modified          | Aug 28, 2020, 11:23:24 AM                      | Lifecycle   |

#7191032#
  @edibus @mlp-26233 @webtest @positive @toIDP
  Scenario:SC3#MLP-26233 Verification of TFM attribute values to DD
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AttributeTFMSystem" and clicks on search
    And user performs "facet selection" in "AttributeTFMSystem≫Operation [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "AttributeTFMSystem≫Operation" item from search results
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                         |
      | Definition        | This is the test tfm package.                         |
      | Description       | The test tfm package is best described as a test case |
    Then user performs click and verify in new window
      | Table    | value                     | Action               | RetainPrevwindow | indexSwitch |
      | Services | AttributeHasTFM≫Operation | click and switch tab | Yes              |             |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                         |
      | Definition        | This is the test tfm package.                         |
      | Description       | The test tfm package is best described as a test case |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table      | value            | Action               | RetainPrevwindow | indexSwitch |
      | Operations | AttributeTFMTask | click and switch tab | Yes              |             |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                       |
      | Definition        | This is the test operation.                         |
      | Description       | The test operation is best described as a test case |
    Then user performs click and verify in new window
      | Table | value        | Action               | RetainPrevwindow | indexSwitch |
      | Data  | Instructions | click and switch tab | No               |             |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                              | widgetName |
      | Data              | select * from xyz where table can be found | Data       |
    And user enters the search text "AttributeTransformation" and clicks on search
    And user performs "facet selection" in "AttributeTFMSystem≫Operation [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "AttributeTransformation" item from search results
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                       |
      | Definition        | This is the test operation.                         |
      | Description       | The test operation is best described as a test case |
    Then user performs click and verify in new window
      | Table        | value                      | Action               | RetainPrevwindow | indexSwitch |
      | Lineage Hops | AttributeTransformationMap | click and switch tab | No               |             |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                              | widgetName  |
      | Definition        | TestDefinition                             | Description |
      | source            | select * from xyz where table can be found | Description |
      | mode              | TRANSFORM                                  | Description |
    And user enters the search text "AttributeTransformation" and clicks on search
    And user performs "facet selection" in "AttributeTFMSystem≫Operation [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "AttributeTransformation" item from search results
    Then user performs click and verify in new window
      | Table | value        | Action               | RetainPrevwindow | indexSwitch |
      | Data  | Instructions | click and switch tab | No               |             |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                              | widgetName |
      | Data              | select * from xyz where table can be found | Data       |
    And user enters the search text "AttributeContainer" and clicks on search
    And user performs "facet selection" in "AttributeContainer≫Stitching [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "AttributeContainer≫Stitching" item from search results
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                            |
      | Definition        | This is the test sti container.                          |
      | Description       | The test sti container is best described as a test case. |
    Then user performs click and verify in new window
      | Table      | value            | Action               | RetainPrevwindow | indexSwitch |
      | Operations | AttributeStrLink | click and switch tab | No               |             |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                              |
      | Definition        | This is the test stitching structure link. |
    Then user performs click and verify in new window
      | Table        | value              | Action               | RetainPrevwindow | indexSwitch |
      | Lineage Hops | AttributeFieldLink | click and switch tab | No               |             |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                       |
      | Definition        | This is the test stitching element. |
      | mode              | STITCH                              |

    #7191033#
  @edibus @mlp-26233 @webtest @positive @toIDP
  Scenario:SC4#MLP-26233 Verification of ERM attribute values to DD
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AttributeERMModel" and clicks on search
    And user performs "facet selection" in "AttributeERMModel [ER-Model]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "ER-Model" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "AttributeERMModel" item from search results
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                       |
      | Definition        | This is the test ER model.                          |
      | Description       | The test ER model is best described as a test case. |
      | caseName          | important                                           |
      | idName            | secret id                                           |
      | owner             | Hugo                                                |
      | stage             | Operational                                         |
    Then user performs click and verify in new window
      | Table        | value           | Action               | RetainPrevwindow | indexSwitch |
      | has_ER-Model | AttrERMHasModel | click and switch tab | Yes              |             |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                          |
      | Definition        | This is the test sub ER model.                         |
      | Description       | The test sub ER model is best described as a test case |
      | caseName          | warehouse                                              |
      | idName            | public id                                              |
      | owner             | Victor                                                 |
      | stage             | ETL                                                    |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table           | value          | Action               | RetainPrevwindow | indexSwitch |
      | has_SubjectArea | AttrERMSubArea | click and switch tab | Yes              |             |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                           |
      | Definition        | This is the test subject area                           |
      | Description       | The test subject area is best described as a test case. |
      | caseName          | customer analysis                                       |
      | idName            | illegal id                                              |
      | stage             | Olap                                                    |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table      | value         | Action               | RetainPrevwindow | indexSwitch |
      | has_Entity | AttrERMEntity | click and switch tab | No               |             |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                     |
      | Definition        | This is the test entity                           |
      | Description       | The test entity is best described as a test case. |
      | caseName          | invoice                                           |
      | idName            | no id                                             |
      | stage             | BigData                                           |
      | caseAliasName     | fraud                                             |
      | purpose           | fundamental                                       |
    Then user performs click and verify in new window
      | Table         | value        | Action               | RetainPrevwindow | indexSwitch |
      | has_Attribute | ERMAttribute | click and switch tab | Yes              |             |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                        |
      | Definition        | This is the test attribute                           |
      | Description       | The test attribute is best described as a test case. |
      | caseName          | price                                                |
      | idName            | $                                                    |
      | stage             | DataMart                                             |
      | caseAliasName     | money                                                |
      | dataAllowedValues | 1000                                                 |
      | dataDefaultValue  | 1000                                                 |
      | dataLength        | 7                                                    |
      | dataMinimumLength | 1                                                    |
      | isOptional        | true                                                 |
      | isUnique          | false                                                |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table          | value             | Action               | RetainPrevwindow | indexSwitch |
      | has_Identifier | AttrERMIdentifier | click and switch tab | Yes              |             |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                         |
      | Definition        | This is the test identifier.                          |
      | Description       | The test identifier is best described as a test case. |
      | isUnique          | false                                                 |
      | isPrimaryKey      | true                                                  |
      | stage             | DataMart                                              |
    And user enters the search text "AttrERMRelationship" and clicks on search
    And user performs "facet selection" in "AttributeERMModel [ER-Model]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "AttrERMRelationship" item from search results
    And the following metadata values should be displayed
      | metaDataAttribute     | metaDataValue                                           |
      | Definition            | This is the test relationship.                          |
      | Description           | The test relationship is best described as a test case. |
      | caseName_FromTo       | consumes                                                |
      | caseName_ToFrom       | produces                                                |
      | minCardinality_FromTo | 1                                                       |
      | minCardinality_ToFrom | 0                                                       |
      | name_FromTo           | CONSUMES                                                |
      | name_ToFrom           | PRODUCES                                                |
      | maxCardinality_FromTo | n                                                       |
      | maxCardinality_ToFrom | 1                                                       |
      | stage                 | DataMart                                                |

    #7191034#
  @edibus @mlp-26233 @webtest @positive @toIDP
  Scenario:SC5#MLP-26233 Verification of OLAP attribute values to DD
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AttributeOLAPPackage" and clicks on search
    And user performs "facet selection" in "AttributeOLAPPackage [OlapPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "OlapPackage" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "AttributeOLAPPackage" item from search results
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                           |
      | Definition        | This is the test olap package.                          |
      | Description       | The test olap package is best described as a test case. |
      | owner             | James Olap Package                                      |
    Then user performs click and verify in new window
      | Table           | value                 | Action               | RetainPrevwindow | indexSwitch |
      | has_OlapPackage | AttrANLHasOLAPPackage | click and switch tab | Yes              |             |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                           |
      | Definition        | This is the test olap package.                          |
      | Description       | The test olap package is best described as a test case. |
      | owner             | James Olap Has Package                                  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table          | value               | Action               | RetainPrevwindow | indexSwitch |
      | has_OlapSchema | AttributeOLAPSchema | click and switch tab | No               |             |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue     |
      | Definition        | TestDefinition    |
      | Description       | Test              |
      | owner             | James Olap Schema |
    Then user performs click and verify in new window
      | Table    | value         | Action               | RetainPrevwindow | indexSwitch |
      | has_Cube | AttributeCube | click and switch tab | No               |             |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                   |
      | Definition        | This is the test cube.                          |
      | Description       | The test cube is best described as a test case. |
      | owner             | James Cube                                      |
    Then user performs click and verify in new window
      | Table    | value            | Action               | RetainPrevwindow | indexSwitch |
      | has_Cube | AttrANLHasRegion | click and switch tab | Yes              |             |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                   |
      | Definition        | This is the test cube.                          |
      | Description       | The test cube is best described as a test case. |
      | owner             | James Cube                                      |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table         | value              | Action               | RetainPrevwindow | indexSwitch |
      | has_Dimension | AttributeDimension | click and switch tab | No               |             |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                        |
      | Definition        | This is the test dimension.                          |
      | Description       | The test dimension is best described as a test case. |
      | owner             | James Dimension                                      |
      | dimensionType     | time                                                 |
      | query             | select x, y from customer where revenue > 1000       |
    Then user performs click and verify in new window
      | Table        | value                 | Action               | RetainPrevwindow | indexSwitch |
      | Lineage Hops | AttributeDimensionMap | click and switch tab | No               |             |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Definition        | Definition    | Description |
      | source            | Test          | Description |
    And user enters the search text "Attributehierarchy" and clicks on search
    And user performs "facet selection" in "AttributeOLAPPackage [OlapPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "Attributehierarchy" item from search results
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                       |
      | Definition        | This is the test hierarchy.                         |
      | Description       | The test hierachy is best described as a test case. |
      | owner             | James Hierarchy                                     |
    And user enters the search text "AttributeLevel" and clicks on search
    And user performs "facet selection" in "AttributeOLAPPackage [OlapPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "AttributeLevel" item from search results
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                    |
      | Definition        | This is the test level.                          |
      | Description       | The test level is best described as a test case. |
      | owner             | James Level                                      |
    And user enters the search text "AttributeANLMember" and clicks on search
    And user performs "facet selection" in "AttributeOLAPPackage [OlapPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "AttributeANLMember" item from search results
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                      |
      | Definition        | This is the test measure.                          |
      | Description       | The test measure is best described as a test case. |
      | owner             | James Member                                       |
      | dataDefaultValue  | 2                                                  |
      | dataAllowedValues | 1,2,3                                              |
      | dataLength        | 17                                                 |
      | dataMinimumLength | 0                                                  |
      | dataScale         | 0                                                  |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | AttributeANLMember                              |
      | attributeName  | isMeasure                                       |
      | actualFilePath | idc\EdiBusPayloads\ActualMetadataValidation.txt |
    Then file content in "idc\EdiBusPayloads\ActualMetadataValidation.txt" should be same as the content in "idc\EdiBusPayloads\ExpectedMetadataValidation.txt"


#7191035#
  @edibus @mlp-26233 @webtest @positive @toIDP
  Scenario:SC6#MLP-26233 Verification of RPT attribute values to DD
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AttributeRPTPackage" and clicks on search
    And user performs "facet selection" in "AttributeRPTPackage [ReportPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "ReportPackage" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "AttributeRPTPackage" item from search results
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                             |
      | Definition        | This is the test report package.                          |
      | Description       | The test report package is best described as a test case. |
      | owner             | James Package                                             |
    Then user performs click and verify in new window
      | Table             | value             | Action               | RetainPrevwindow | indexSwitch |
      | has_ReportPackage | AttrANLHasRPTPckg | click and switch tab | Yes              |             |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                            |
      | Definition        | This is the test report package.                         |
      | Description       | The test report package is best described as a test case |
      | owner             | James Package                                            |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table            | value              | Action               | RetainPrevwindow | indexSwitch |
      | has_ReportSchema | AttributeRPTSchema | click and switch tab | No               |             |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                            |
      | Definition        | This is the test report schema.                          |
      | Description       | The test report schema is best described as a test case. |
      | owner             | James Schema                                             |
    And user enters the search text "AttributeRPTStructure" and clicks on search
    And user performs "facet selection" in "AttributeRPTPackage [ReportPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "AttributeRPTStructure" item from search results
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue  |
      | Definition        | TestDefinition |
      | Description       | Desc           |
    Then user performs click and verify in new window
      | Table      | value            | Action               | RetainPrevwindow | indexSwitch |
      | Data Types | AttrANLHasRPTStr | click and switch tab | Yes              |             |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                               |
      | Definition        | This is the test report structure.                          |
      | Description       | The test report structure is best described as a test case. |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table        | value           | Action               | RetainPrevwindow | indexSwitch |
      | Lineage Hops | AttributeRPTMap | click and switch tab | No               |             |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue  | widgetName  |
      | Definition        | TestDefinition | Description |
      | source            | Test           | Description |
      | mode              | VIRTUAL        | Description |
    And user enters the search text "AttrRPTFieldNew" and clicks on search
    And user performs "facet selection" in "AttributeRPTPackage [ReportPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "AttrRPTFieldNew" item from search results
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                              | widgetName  |
      | Definition        | This is the test report field 11                           | Description |
      | Description       | The test report field 11 is best described as a test case. | Description |
      | dataDefaultValue  | TRUE                                                       | Description |
      | dataAllowedValues | TRUE ,FALSE ,OTHER                                         | Description |
      | dataLength        | 10                                                         | Statistics  |
      | dataMinimumLength | 0                                                          | Statistics  |
      | dataScale         | 0                                                          | Statistics  |
    And user enters the search text "AttributeReport" and clicks on search
    And user performs "facet selection" in "AttributeRPTPackage [ReportPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "AttributeReport" item from search results
#    And the following metadata values should be displayed
#      | metaDataAttribute | metaDataValue |
#      | Definition        | This is the test report.                          |
#      | Description       | The test report is best described as a test case. |
#      | owner             | James Report              |
    And user enters the search text "AttributeRPTField" and clicks on search
    And user performs "facet selection" in "AttributeRPTPackage [ReportPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "AttributeRPTField" item from search results
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
#      | Definition        | This is the test report. |
      | Length            | 17            |
      | Minimum length    | 6             |
    And user enters the search text "AttributeRPTDashboard" and clicks on search
    And user performs "facet selection" in "AttributeRPTPackage [ReportPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "AttributeRPTDashboard" item from search results
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                        |
      | Definition        | This is the test dashboard.                          |
      | Description       | The test dashboard is best described as a test case. |
      | owner             | James Dashboard                                      |
    Then user performs click and verify in new window
      | Table            | value         | Action               | RetainPrevwindow | indexSwitch |
      | has_ReportFilter | AttrANLPrompt | click and switch tab | Yes              |             |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                    |
      | Definition        | This is the test prompt.                         |
      | Description       | The test prompt is best described as a test case |
      | owner             | James Prompt                                     |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table             | value              | Action               | RetainPrevwindow | indexSwitch |
      | has_DashboardPage | AttrDashBrdPageNew | click and switch tab | No               |             |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                             |
      | Definition        | This is the test dashboard page.                          |
      | Description       | The test dashboard page is best described as a test case. |
      | owner             | James Dashboard Page                                      |
    Then user performs click and verify in new window
      | Table             | value          | Action               | RetainPrevwindow | indexSwitch |
      | has_DashboardPage | AttrANLHasPage | click and switch tab | No               |             |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                            |
      | Definition        | This is the test dashboard page.                         |
      | Description       | The test dashboard page is best described as a test case |
      | owner             | James Dashboard Page                                     |


  Scenario:SC7#:Delete the analysis item
    Given user update the json file "idc/EdiBusPayloads/MLP_26233_AttributeConfig.json" file for following values
      | jsonPath        | jsonValues |
      | $..['function'] | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                              | response code | response message | jsonPath                                             |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                            | idc/EdiBusPayloads/MLP_26233_AttributeConfig.json | 204           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/AttributeEDIBus |                                                   | 200           | IDLE             | $.[?(@.configurationName=='AttributeEDIBus')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/AttributeEDIBus  |                                                   | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/AttributeEDIBus |                                                   | 200           | IDLE             | $.[?(@.configurationName=='AttributeEDIBus')].status |
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                         | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/AttributeEDIBus% | Analysis |       |       |

  @MLP-26841 @edibus
  Scenario Outline: SC8#-Set the DataSource for Foreign Key
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                     | bodyFile                                                           | path                                 | response code | response message    | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusKeyDataSource | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusKeyDataSource.configurations | 204           |                     |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                     |                                                                    |                                      | 200           | EDIBusKeyDataSource |          |

    #7199333#7199375#
  @MLP-26841 @edibus @webtest
  Scenario:SC8#MLP-26841 Verification of replication of Foreign key to DD
    Given user update the json file "idc/EdiBusPayloads/MLP_26841_KeyConfig.json" file for following values
      | jsonPath        | jsonValues |
      | $..['function'] | replicate  |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                            | body                                        | response code | response message | jsonPath                                       |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                      | idc/EdiBusPayloads/MLP_26841_KeyConfig.json | 204           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusKey |                                             | 200           | IDLE             | $.[?(@.configurationName=='EDIBusKey')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusKey  |                                             | 200           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusKey |                                             | 200           | IDLE             | $.[?(@.configurationName=='EDIBusKey')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusKey%"
    And the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of errors          | 0             |
      | Number of processed items | 7             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/EDIBusKey%" should display below info/error/warning
      | type | logValue                                                                                             | logCode      | pluginName | removableText |
      | INFO | The replication of 7 items in 1 cycles took 1s; 7 items were written and 0 items were deleted in DD. | EDIBUS-I0024 |            |               |
      | INFO | Start of replication from EDI to DD with batchsize=1000                                              | EDIBUS-I0017 |            |               |
    And user enters the search text "RDBForeignKey" and clicks on search
    And user performs "facet selection" in "KeyDBSystem≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "RDBForeignKey" item from search results
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Constraint Type   | FOREIGN_KEY   |
    Then user performs click and verify in new window
      | Table   | value        | Action                 | RetainPrevwindow | indexSwitch |
      | columns | KeyColumnOne | verify widget contains | No               |             |
      | parent  | KeyColumn    | verify widget contains | No               |             |

  Scenario:SC8#:Delete the analysis item
    Given user update the json file "idc/EdiBusPayloads/MLP_26841_KeyConfig.json" file for following values
      | jsonPath        | jsonValues |
      | $..['function'] | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                            | body                                        | response code | response message | jsonPath                                       |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                      | idc/EdiBusPayloads/MLP_26841_KeyConfig.json | 204           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusKey |                                             | 200           | IDLE             | $.[?(@.configurationName=='EDIBusKey')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusKey  |                                             | 200           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusKey |                                             | 200           | IDLE             | $.[?(@.configurationName=='EDIBusKey')].status |
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                   | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/EDIBusKey% | Analysis |       |       |

    #7199334#
  @edibus @mlp-26841 @webtest @positive @toIDP
  Scenario:SC9#_MLP-26841_Verification of replicating items of non supported technology
    Given user update the json file "idc/EdiBusPayloads/toIDPNonSupportedTechnology.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | replicate  |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                    | body                                                | response code | response message | jsonPath                                               |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                              | idc/EdiBusPayloads/toIDPNonSupportedTechnology.json | 204           |                  |                                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPNotSupported |                                                     | 200           | IDLE             | $.[?(@.configurationName=='toIDPNotSupported')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/toIDPNotSupported  |                                                     | 200           |                  |                                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPNotSupported |                                                     | 200           | IDLE             | $.[?(@.configurationName=='toIDPNotSupported')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "toIDPNotSupported" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 1             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/toIDPNotSupported%" should display below info/error/warning
      | type  | logValue                                                                                                       | logCode      |
      | ERROR | Cannot do the replication because the specified technologies: [Test] are not supported in this EDIBus release. | EDIBUS-E0217 |

  Scenario:SC9#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/toIDPNotSupported% | Analysis |       |       |

  @edibus @mlp-24779 @positive @release10.0
  Scenario:MLP-24779 Deleting EDIBus configuration
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                           | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/EDIBus                                     |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/EDIBusDataSource/EDIBusAttributeDataSource |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/EDIBusDataSource/EDIBusKeyDataSource       |      | 204           |                  |          |






