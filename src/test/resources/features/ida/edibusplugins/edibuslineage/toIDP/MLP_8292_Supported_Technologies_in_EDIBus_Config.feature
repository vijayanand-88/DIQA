Feature: MLP_8292_Supported_Technologies_in_EDIBus_Config

    ##6449712##bug id:28430#
  @webtest @mlp-8292 @positive @toIDP
  Scenario:SC1#_MLP-8292_Verification of Info icon update regarding available technologies for EDI
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem            |
      | mouse hover | Settings Icon         |
      | click       | Settings Icon         |
      | click       | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem   |
      | Open Deployment | InternalNode |
    And user "click" on "Add Configuration" button under "InternalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute |
      | Type      | Bulk      |
      | Plugin    | EDIBus    |
    Then user mouse hovers the help icon in plugin configuration fields
      | pluginConfigFieldName | mouseHoverText                                            |
      | EDI technologies      | The names of the EDI technologies to be replicated to DD. |
      | EDI types             | The names of the EDI types to be replicated to DD.        |

     #Descoped since IDA Technologies is disabled
#   ##6624594##6449713##
#  @webtest @mlp-8292 @positive @toIDP
#  Scenario:SC2#_MLP-8292_MLP-9916_Verification of Info icon update regarding available technologies for IDP
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the sidebar
#      | actionType  | actionItem            |
#      | mouse hover | Settings Icon         |
#      | click       | Settings Icon         |
#      | click       | Manage Configurations |
#    And user performs "click" operation in Manage Configurations panel
#      | button          | actionItem   |
#      | Open Deployment | InternalNode |
#    And user "click" on "Add Configuration" button under "InternalNode" in Manage Configurations
#    And user "select dropdown" in Add Configuration Page in Manage Configurations
#      | fieldName | attribute |
#      | Type      | Bulk      |
#      | Plugin    | EDIBus    |
#    And user "click" on "Add attribute" button under "IDA technologies" in Manage Configurations
#    Then user mouse hovers the help icon in plugin configuration fields
#      | pluginConfigFieldName | mouseHoverText                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
#      | IDA technologies      | The following technology names are supported (only to be applied for the functions toEDI and toEDICleanup): Amazon S3, Amazon Glue, Avro, Azure Cosmos, Azure SQL DB, Azure SQL DW, BigData, Cassandra, CDAP, Cloudera Navigator, DB2, Gemfire, Git, HBase, Hadoop Files, Hive, JSON, Local Files, Mobius, MongoDB, Oracle, Parquet, PostgreSQL, Python, Redshift, Redshift Spectrum, Snowflake, TeraData. You can also specify further technologies added dynamically by new Analysers or Catalogers, consult you administrator about that. |

    #6450007#
  @edibus @mlp-8292 @webtest @positive @toIDP
  Scenario:SC3#_MLP-8292_Verification of replicating  items of non supported technology to IDPCleanup
    Given user update the json file "idc/EdiBusPayloads/toIDPNonSupportedTechnology.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
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

  Scenario:SC3#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/toIDPNotSupported% | Analysis |       |       |