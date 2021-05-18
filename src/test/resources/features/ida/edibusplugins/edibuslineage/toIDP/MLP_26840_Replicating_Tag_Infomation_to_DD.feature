Feature: MLP_26840_MLP_28343_Replicate tag information to DD

  @MLP-26840 @edibus
  Scenario Outline: SC1#-Set the DataSource for Tags
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                      | bodyFile                                                           | path                                  | response code | response message     | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusTagsDataSource | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusTagsDataSource.configurations | 204           |                      |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                      |                                                                    |                                       | 200           | EDIBusTagsDataSource |          |

#7197648#7201798#7202358#
  @edibus @mlp-26840 @webtest @positive @toIDP
  Scenario:SC1#MLP-26840 Verification of tags defined for items in EDI are replicated to DD
    Given user update the json file "idc/EdiBusPayloads/MLP_26840_TagsConfig.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | replicate  |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                             | body                                         | response code | response message | jsonPath                                        |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                       | idc/EdiBusPayloads/MLP_26840_TagsConfig.json | 204           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTags |                                              | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTags')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusTags  |                                              | 200           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTags |                                              | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTags')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusTags%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/EDIBusTags%" should display below info/error/warning
      | type | logValue                | logCode      | pluginName | removableText |
      | INFO | replication of 48 items | EDIBUS-I0024 |            |               |
    And user enters the search text "EDITag" and clicks on search
    And user performs "facet selection" in "EDITag" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ROC" attribute under "Tags" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | DataType         |
      | Database         |
      | Column           |
      | Table            |
      | Service          |
      | Attribute        |
      | ER-Model         |
      | Entity           |
      | Identifier       |
      | Relationship     |
      | Dimension        |
      | Field            |
      | Measure          |
      | Operation        |
      | Routine          |
      | AggregationLevel |
      | Cube             |
      | Dashboard        |
      | DashboardPage    |
      | DataDomain       |
      | DataPackage      |
      | Directory        |
      | File             |
      | Hierarchy        |
      | OlapPackage      |
      | OlapSchema       |
      | Report           |
      | ReportFilter     |
      | ReportPackage    |
      | ReportSchema     |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name   | facet         | Tag        | fileName  | userTag |
      | Default     | Column | Metadata Type | EDITag,ROC | TagColumn | EDITag  |
    And user enters the search text "TagTransformation" and clicks on search
    And user performs "facet selection" in "EDITag" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "TagTransformation" item from search results
    Then user performs click and verify in new window
      | Table        | value                | Action               | RetainPrevwindow | indexSwitch |
      | Lineage Hops | TagTransformationMap | click and switch tab | No               |             |
    And User performs following actions in the Item view Page
      | Actiontype          | ActionItem |
      | Verify Tag Presence | EDITag,ROC |
    And user enters the search text "TagRPTStructure" and clicks on search
    And user performs "facet selection" in "EDITag" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "TagRPTStructure" item from search results
    Then user performs click and verify in new window
      | Table        | value     | Action               | RetainPrevwindow | indexSwitch |
      | Lineage Hops | TagRPTMap | click and switch tab | No               |             |
    And User performs following actions in the Item view Page
      | Actiontype          | ActionItem |
      | Verify Tag Presence | EDITag,ROC |
    And user enters the search text "TagDimension" and clicks on search
    And user performs "facet selection" in "EDITag" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "TagDimension" item from search results
    Then user performs click and verify in new window
      | Table        | value           | Action               | RetainPrevwindow | indexSwitch |
      | Lineage Hops | TagDimensionMap | click and switch tab | No               |             |
    And User performs following actions in the Item view Page
      | Actiontype          | ActionItem |
      | Verify Tag Presence | EDITag,ROC |

  @edibus @mlp-26840 @webtest @positive @toIDP
  Scenario:SC1#MLP-26840 Verification of assigning and unassigning custom tags replicated to DD
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "TagModel" and clicks on search
    And user performs "facet selection" in "EDITag" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "TagModel" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     |
      | Click      | Add Tag Button |
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem | Section  |
      | Verify Tag Presence in Section | EDITag     | Assigned |
    And User performs following actions in the "Assign a Business Application" popup
      | Actiontype                        | ActionItem | Section  |
      | Remove tagged item in the Section | EDITag     | Assigned |
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem | Section   |
      | Verify Tag Absence in Section  | EDITag     | Assigned  |
      | Verify Tag Presence in Section | EDITag     | Available |
    And user "click" on "Assign" button in "Assign a Tag"
    And User performs following actions in the Item view Page
      | Actiontype          | ActionItem |
      | Verify Tag Presence | ROC        |
    And user enters the search text "TagModel" and clicks on search
    And user performs "item click" on "TagModel" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     |
      | Click      | Add Tag Button |
    And User performs following actions in the Item view Page
      | Actiontype    | ActionItem | Section   |
      | Tag Selection | EDITag     | Available |
    And user "click" on "Assign" button in "Assign a Tag"
    And User performs following actions in the Item view Page
      | Actiontype          | ActionItem |
      | Verify Tag Presence | EDITag,ROC |


  Scenario:SC1#:Delete the analysis item
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                         | body | response code | response message | jsonPath           |
      | application/json |       |       | Get  | tags/Default/EDITag/subtags |      | 200           | EDI Tags         | $..['rootTagName'] |
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                    | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/EDIBusTags% | Analysis |       |       |

    #7197650#7201801#7208898#
  @edibus @mlp-26840 @webtest @positive @toIDP
  Scenario Outline:SC2#MLP-26840 Verification of deleting the replicated tag items
    Given user update the json file "idc/EdiBusPayloads/MLP_26840_TagsConfig.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                             | body                                         | response code | response message | jsonPath                                        |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                       | idc/EdiBusPayloads/MLP_26840_TagsConfig.json | 204           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTags |                                              | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTags')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusTags  |                                              | 200           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTags |                                              | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTags')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusTags%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    And User performs following actions in the Item view Page
      | Actiontype          | ActionItem |
      | Verify Tag Presence | ROC        |
    And user "widget not present" on "Processed Items" in Item view page
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/EDIBusTags%" should display below info/error/warning
      | type | logValue         | logCode      | pluginName | removableText |
      | INFO | 53 items deleted | EDIBUS-I0010 |            |               |
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type | name   | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | deletedID | Default | Tag  | EDITag |             |            |          |

  Scenario Outline:SC2#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                    | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/EDIBusTags% | Analysis |       |       |
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type | name | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | deletedID | Default | Tag  | ROC  |             |            |          |


  @MLP-26840 @edibus
  Scenario Outline: SC3#-Set the DataSource for Tags
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                          | bodyFile                                                           | path                                      | response code | response message         | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusTagsInfoDataSource | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusTagsInfoDataSource.configurations | 204           |                          |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                          |                                                                    |                                           | 200           | EDIBusTagsInfoDataSource |          |

#7197652#
  @edibus @mlp-26840 @webtest @positive @toIDP
  Scenario:SC3#MLP-26840 Verification of replication and removal of EDI tag assignments to DD with incremental false
    Given user update the json file "idc/EdiBusPayloads/MLP_26840_TagsInfoConfig.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | replicate  |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                             | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP_26840_TagsInfoConfig.json | 204           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTagsInfo |                                                  | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTagsInfo')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusTagsInfo  |                                                  | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTagsInfo |                                                  | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTagsInfo')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusTagsInfo%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/EDIBusTagsInfo%" should display below info/error/warning
      | type | logValue               | logCode      | pluginName | removableText |
      | INFO | replication of 6 items | EDIBUS-I0024 |            |               |
    And user enters the search text "TestEDITag" and clicks on search
    And user performs "facet selection" in "InfoDBSystem≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "ROC" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "TestEDITag" attribute under "Tags" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Database |
      | Column   |
      | Table    |
      | Schema   |
      | Service  |
    And user connects Rochade Server and "linkItem" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | itemType       | itemName  | linkItemType | linkItemName | attributeName | operationName |
      | AP-DATA      | TAGSINFO    | 1.0                | RO_TAG_POINTER | TableTag  | DWR_TAG      | TestEDITag   | RO_TAGGED     | REMOVE        |
      | AP-DATA      | TAGSINFO    | 1.0                | RO_TAG_POINTER | ColumnTag | DWR_TAG      | TestEDITag   | RO_TAGGED     | REMOVE        |
    Given user update the json file "idc/EdiBusPayloads/MLP_26840_TagsInfoConfig.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | replicate  |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                 | body | response code | response message | jsonPath                                            |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTagsInfo |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTagsInfo')].status |
      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusTagsInfo  |      | 200           |                  |                                                     |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTagsInfo |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTagsInfo')].status |
    And user enters the search text "TestEDITag" and clicks on search
    And user performs "facet selection" in "InfoDBSystem≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "TestEDITag" attribute under "Tags" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Database |
      | Schema   |
      | Service  |
    Then user verify "non presence of facets" with following values under "Type" section in item search results page
      | Table  |
      | Column |
    And user enters the search text "InfoDBSystem" and clicks on search
    And user performs "facet selection" in "InfoDBSystem≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "ROC" attribute under "Tags" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Database |
      | Schema   |
      | Service  |
      | Table    |
      | Column   |

  Scenario:SC3#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                        | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/EDIBusTagsInfo% | Analysis |       |       |

    #7197656#7201803#
  @edibus @mlp-26840 @webtest @positive @toIDP
  Scenario Outline:SC4#MLP-26840 Verification of removal of the replicated tag items with incremental false
    Given user update the json file "idc/EdiBusPayloads/MLP_26840_TagsInfoConfig.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                             | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP_26840_TagsInfoConfig.json | 204           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTagsInfo |                                                  | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTagsInfo')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusTagsInfo  |                                                  | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTagsInfo |                                                  | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTagsInfo')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusTagsInfo%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/EDIBusTagsInfo%" should display below info/error/warning
      | type | logValue        | logCode      | pluginName | removableText |
      | INFO | 8 items deleted | EDIBUS-I0010 |            |               |
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type | name       | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | deletedID | Default | Tag  | TestEDITag |             |            |          |


  Scenario Outline:SC4#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                        | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/EDIBusTagsInfo% | Analysis |       |       |
    And user connects Rochade Server and "linkItem" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | itemType       | itemName  | linkItemType | linkItemName | attributeName | operationName |
      | AP-DATA      | TAGSINFO    | 1.0                | RO_TAG_POINTER | TableTag  | DWR_TAG      | TestEDITag   | RO_TAGGED     | SET           |
      | AP-DATA      | TAGSINFO    | 1.0                | RO_TAG_POINTER | ColumnTag | DWR_TAG      | TestEDITag   | RO_TAGGED     | SET           |
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type | name | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | deletedID | Default | Tag  | ROC  |             |            |          |

#7197659#7201802#
  @edibus @mlp-26840 @webtest @positive @toIDP
  Scenario:SC5#MLP-26840 Verification of replication and deletion of EDI tag assignments to DD with incremental true
    Given user update the json file "idc/EdiBusPayloads/MLP_26840_TagsInfoConfig.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | replicate  |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                             | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP_26840_TagsInfoConfig.json | 204           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTagsInfo |                                                  | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTagsInfo')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusTagsInfo  |                                                  | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTagsInfo |                                                  | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTagsInfo')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBusTagsInfo" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusTagsInfo%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/EDIBusTagsInfo%" should display below info/error/warning
      | type | logValue               | logCode      | pluginName | removableText |
      | INFO | replication of 6 items | EDIBUS-I0024 |            |               |
    And user enters the search text "TestEDITag" and clicks on search
    And user performs "facet selection" in "InfoDBSystem≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "TestEDITag" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ROC" attribute under "Tags" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Database |
      | Column   |
      | Table    |
      | Schema   |
      | Service  |
    And user connects Rochade Server and "linkItem" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | itemType       | itemName  | linkItemType | linkItemName | attributeName | operationName |
      | AP-DATA      | TAGSINFO    | 1.0                | RO_TAG_POINTER | TableTag  | DWR_TAG      | TestEDITag   | RO_TAGGED     | REMOVE        |
      | AP-DATA      | TAGSINFO    | 1.0                | RO_TAG_POINTER | ColumnTag | DWR_TAG      | TestEDITag   | RO_TAGGED     | REMOVE        |
    Given user update the json file "idc/EdiBusPayloads/MLP_26840_TagsInfoTrue.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | replicate  |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                 | body                                           | response code | response message | jsonPath                                            |
      |        |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP_26840_TagsInfoTrue.json | 204           |                  |                                                     |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTagsInfo |                                                | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTagsInfo')].status |
      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusTagsInfo  |                                                | 200           |                  |                                                     |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTagsInfo |                                                | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTagsInfo')].status |
    And user enters the search text "TestEDITag" and clicks on search
    And user performs "facet selection" in "InfoDBSystem≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "TestEDITag" attribute under "Tags" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Database |
      | Schema   |
      | Service  |
    Then user verify "non presence of facets" with following values under "Type" section in item search results page
      | Table  |
      | Column |
    And user enters the search text "InfoDBSystem" and clicks on search
    And user performs "facet selection" in "InfoDBSystem≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "ROC" attribute under "Tags" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Database |
      | Schema   |
      | Service  |
      | Table    |
      | Column   |

  Scenario:SC5#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                        | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/EDIBusTagsInfo% | Analysis |       |       |

#7197663#
  @edibus @mlp-26840 @webtest @positive @toIDP
  Scenario Outline:SC6#MLP-26840 Verification of deleting the replicated tag items with incremental true
    Given user update the json file "idc/EdiBusPayloads/MLP_26840_TagsInfoConfig.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                             | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP_26840_TagsInfoConfig.json | 204           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTagsInfo |                                                  | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTagsInfo')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusTagsInfo  |                                                  | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTagsInfo |                                                  | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTagsInfo')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusTagsInfo%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/EDIBusTagsInfo%" should display below info/error/warning
      | type | logValue        | logCode      | pluginName | removableText |
      | INFO | 8 items deleted | EDIBUS-I0010 |            |               |
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type | name       | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | deletedID | Default | Tag  | TestEDITag |             |            |          |

  Scenario Outline:SC6#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                        | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/EDIBusTagsInfo% | Analysis |       |       |
    And user connects Rochade Server and "linkItem" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | itemType       | itemName  | linkItemType | linkItemName | attributeName | operationName |
      | AP-DATA      | TAGSINFO    | 1.0                | RO_TAG_POINTER | TableTag  | DWR_TAG      | TestEDITag   | RO_TAGGED     | SET           |
      | AP-DATA      | TAGSINFO    | 1.0                | RO_TAG_POINTER | ColumnTag | DWR_TAG      | TestEDITag   | RO_TAGGED     | SET           |
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type | name | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | deletedID | Default | Tag  | ROC  |             |            |          |

  @MLP-26840 @regression @positive
  Scenario Outline: SC7#_Create EDITag
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                     | body                                    | response code | response message | filePath | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Put  | tags/Default/structures | payloads\idc\EdiBusPayloads\EDITag.json | 200           |                  |          |          |

  @MLP-26840 @regression @positive
  Scenario Outline: SC7#_Verify EDITag created
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive | catalog | type | name   | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | ID      | Default | Tag  | EDITag |             |            |          |

    #7199297#
  @edibus @mlp-26840 @webtest @positive @toIDP
  Scenario Outline:SC7#MLP-26840_Verification of already present tag in DD is not deleted while doing cleanup of replicated items with same tag name from EDI
    Given user update the json file "idc/EdiBusPayloads/MLP_26840_TagsConfig.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | replicate  |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                             | body                                         | response code | response message | jsonPath                                        |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                       | idc/EdiBusPayloads/MLP_26840_TagsConfig.json | 204           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTags |                                              | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTags')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusTags  |                                              | 200           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTags |                                              | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTags')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusTags%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/EDIBusTags%" should display below info/error/warning
      | type | logValue                | logCode      | pluginName | removableText |
      | INFO | replication of 48 items | EDIBUS-I0024 |            |               |
    And user update the json file "idc/EdiBusPayloads/MLP_26840_TagsConfig.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                             | body                                         | response code | response message | jsonPath                                        |
      |        |       |       | Put          | settings/analyzers/EDIBus                                       | idc/EdiBusPayloads/MLP_26840_TagsConfig.json | 204           |                  |                                                 |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTags |                                              | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTags')].status |
      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusTags  |                                              | 200           |                  |                                                 |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTags |                                              | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTags')].status |
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive | catalog | type | name   | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | ID      | Default | Tag  | EDITag |             |            |          |

  Scenario:SC7#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                    | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/EDIBusTags% | Analysis |       |       |
      | SingleItemDelete | Default | EDITag                  | Tag      |       |       |

#7199661#
  @edibus @mlp-26841 @webtest @positive @toIDP
  Scenario Outline:SC8#MLP-26841 Verification of deletion of EDI tag with incremental false
    Given user connects Rochade Server and "add" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | itemType | itemName     |
      | AP-DATA      | TAGSINFO    | 1.0                | DWR_TAG  | EDIDeleteTag |
    And user connects Rochade Server and "linkItem" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | itemType       | itemName     | linkItemType | linkItemName | attributeName | operationName |
      | AP-DATA      | TAGSINFO    | 1.0                | RO_TAG_POINTER | ColumnOneTag | DWR_TAG      | EDIDeleteTag | RO_TAGGED     | SET           |
    And user update the json file "idc/EdiBusPayloads/MLP_26840_TagsInfoConfig.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | replicate  |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                             | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP_26840_TagsInfoConfig.json | 204           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTagsInfo |                                                  | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTagsInfo')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusTagsInfo  |                                                  | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTagsInfo |                                                  | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTagsInfo')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusTagsInfo%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    And user enters the search text "TestEDITag" and clicks on search
    And user performs "facet selection" in "InfoDBSystem≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "TestEDITag" attribute under "Tags" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Database |
      | Column   |
      | Table    |
      | Schema   |
      | Service  |
    And user enters the search text "EDIDeleteTag" and clicks on search
    And user performs "facet selection" in "InfoDBSystem≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "EDIDeleteTag" attribute under "Tags" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Database |
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                       |
      | AP-DATA      | TAGSINFO    | 1.0                | (XNAME * *  ~= EDIDeleteTag ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TAG ) |
    And user update the json file "idc/EdiBusPayloads/MLP_26840_TagsInfoConfig.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | replicate  |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                 | body | response code | response message | jsonPath                                            |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTagsInfo |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTagsInfo')].status |
      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusTagsInfo  |      | 200           |                  |                                                     |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTagsInfo |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTagsInfo')].status |
    And user enters the search text "TestEDITag" and clicks on search
    And user performs "facet selection" in "InfoDBSystem≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "TestEDITag" attribute under "Tags" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Database |
      | Schema   |
      | Service  |
      | Table    |
      | Column   |
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type | name         | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | deletedID | Default | Tag  | EDIDeleteTag |             |            |          |

  Scenario:SC8#:Delete the analysis item
    And user update the json file "idc/EdiBusPayloads/MLP_26840_TagsInfoConfig.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                             | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP_26840_TagsInfoConfig.json | 204           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTagsInfo |                                                  | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTagsInfo')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusTagsInfo  |                                                  | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTagsInfo |                                                  | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTagsInfo')].status |
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                        | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/EDIBusTagsInfo% | Analysis |       |       |

    #7199668#
  @edibus @mlp-26841 @webtest @positive @toIDP
  Scenario Outline:SC9#MLP-26841 Verification of deletion of EDI tag with incremental true
    Given user connects Rochade Server and "add" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | itemType | itemName     |
      | AP-DATA      | TAGSINFO    | 1.0                | DWR_TAG  | EDIDeleteTag |
    And user connects Rochade Server and "linkItem" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | itemType       | itemName     | linkItemType | linkItemName | attributeName | operationName |
      | AP-DATA      | TAGSINFO    | 1.0                | RO_TAG_POINTER | ColumnOneTag | DWR_TAG      | EDIDeleteTag | RO_TAGGED     | SET           |
    And user update the json file "idc/EdiBusPayloads/MLP_26840_TagsInfoConfig.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | replicate  |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                             | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP_26840_TagsInfoConfig.json | 204           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTagsInfo |                                                  | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTagsInfo')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusTagsInfo  |                                                  | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTagsInfo |                                                  | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTagsInfo')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusTagsInfo%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    And user enters the search text "TestEDITag" and clicks on search
    And user performs "facet selection" in "InfoDBSystem≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "TestEDITag" attribute under "Tags" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Database |
      | Column   |
      | Table    |
      | Schema   |
      | Service  |
    And user enters the search text "EDIDeleteTag" and clicks on search
    And user performs "facet selection" in "InfoDBSystem≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "EDIDeleteTag" attribute under "Tags" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Database |
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                       |
      | AP-DATA      | TAGSINFO    | 1.0                | (XNAME * *  ~= EDIDeleteTag ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TAG ) |
    And user update the json file "idc/EdiBusPayloads/MLP_26840_TagsInfoTrue.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | replicate  |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                 | body                                           | response code | response message | jsonPath                                            |
      |        |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP_26840_TagsInfoTrue.json | 204           |                  |                                                     |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTagsInfo |                                                | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTagsInfo')].status |
      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusTagsInfo  |                                                | 200           |                  |                                                     |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTagsInfo |                                                | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTagsInfo')].status |
    And user enters the search text "TestEDITag" and clicks on search
    And user performs "facet selection" in "InfoDBSystem≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "TestEDITag" attribute under "Tags" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Database |
      | Schema   |
      | Service  |
      | Table    |
      | Column   |
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type | name         | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | deletedID | Default | Tag  | EDIDeleteTag |             |            |          |

  Scenario:SC9#:Delete the analysis item
    And user update the json file "idc/EdiBusPayloads/MLP_26840_TagsInfoConfig.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                             | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP_26840_TagsInfoConfig.json | 204           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTagsInfo |                                                  | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTagsInfo')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusTagsInfo  |                                                  | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTagsInfo |                                                  | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTagsInfo')].status |
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                        | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/EDIBusTagsInfo% | Analysis |       |       |
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                       |
      | AP-DATA      | TAGSINFO    | 1.0                | (XNAME * *  ~= EDIDeleteTag ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TAG ) |


    #7197652#
  @edibus @mlp-26840 @webtest @positive @toIDP
  Scenario:SC10#MLP-26840 Verification of replication and removal of EDI tag assignments to DD with incremental false
    Given user connects Rochade Server and "add" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | itemType | itemName     |
      | AP-DATA      | TAGSINFO    | 1.0                | DWR_TAG  | EDIDeleteTag |
    And user connects Rochade Server and "linkItem" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | itemType       | itemName     | linkItemType | linkItemName | attributeName | operationName |
      | AP-DATA      | TAGSINFO    | 1.0                | RO_TAG_POINTER | ColumnOneTag | DWR_TAG      | EDIDeleteTag | RO_TAGGED     | SET           |
    And user update the json file "idc/EdiBusPayloads/MLP_26840_TagsInfoConfig.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | replicate  |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                             | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP_26840_TagsInfoConfig.json | 204           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTagsInfo |                                                  | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTagsInfo')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusTagsInfo  |                                                  | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTagsInfo |                                                  | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTagsInfo')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusTagsInfo%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    And user enters the search text "InfoColumnOne" and clicks on search
    And user performs "facet selection" in "EDIDeleteTag" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "InfoColumnOne" item from search results
    And User performs following actions in the Item view Page
      | Actiontype          | ActionItem       |
      | Verify Tag Presence | EDIDeleteTag,ROC |
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     |
      | Click      | Add Tag Button |
    And User performs following actions in the Item view Page
      | Actiontype    | ActionItem | Section   |
      | Tag Selection | TestEDITag | Available |
    And user "click" on "Assign" button in "Assign a Tag"
    And User performs following actions in the Item view Page
      | Actiontype          | ActionItem                  |
      | Verify Tag Presence | EDIDeleteTag,TestEDITag,ROC |
    And user update the json file "idc/EdiBusPayloads/MLP_26840_TagsInfoConfig.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | replicate  |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                             | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP_26840_TagsInfoConfig.json | 204           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTagsInfo |                                                  | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTagsInfo')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusTagsInfo  |                                                  | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTagsInfo |                                                  | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTagsInfo')].status |
    And user enters the search text "InfoColumnOne" and clicks on search
    And user performs "facet selection" in "ROC" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "InfoColumnOne" item from search results
    And User performs following actions in the Item view Page
      | Actiontype          | ActionItem                  |
      | Verify Tag Presence | EDIDeleteTag,TestEDITag,ROC |

  Scenario:SC10#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                        | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/EDIBusTagsInfo% | Analysis |       |       |


  @edibus @mlp-26840 @webtest @positive @toIDP
  Scenario:SC10#:Cleanup of replicated data
    Given user update the json file "idc/EdiBusPayloads/MLP_26840_TagsInfoConfig.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                             | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP_26840_TagsInfoConfig.json | 204           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTagsInfo |                                                  | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTagsInfo')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusTagsInfo  |                                                  | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTagsInfo |                                                  | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTagsInfo')].status |
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                       |
      | AP-DATA      | TAGSINFO    | 1.0                | (XNAME * *  ~= EDIDeleteTag ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TAG ) |


  @edibus @mlp-24779 @positive @release10.0
  Scenario:MLP-24779 Deleting EDIBus configuration
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                      | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/EDIBus                                |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/EDIBusDataSource/EDIBusTagsDataSource |      | 204           |                  |          |









