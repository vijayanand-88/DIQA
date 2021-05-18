@MLP-16632
Feature:MLP-16632: This feature is to verify tooltip to JSON data in Metadata widget

  @aws @precondition
  Scenario: Update Avro Cataloger with
    Given User update the below "Postgres Credentials" in following files using json path
      | filePath                                                              | username    | password    |
      | idc/IDX_PluginPayloads/MLP-14102_AvroCataloger_Credential_Config.json | $..userName | $..password |

  @MLP-16632
  Scenario: Verify Avro cataloger scans and collects data
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                   | body                                                                  | response code | response message | jsonPath                                                  | endpointType | itemName |
      | application/json |       |       | Delete       | settings/credentials/AvroCred                                                         |                                                                       |               |                  |                                                           |              |          |
      |                  |       |       | Put          | settings/credentials/AvroCred?allowUpdate=false                                       | idc/IDX_PluginPayloads/MLP-14102_AvroCataloger_Credential_Config.json | 200           |                  |                                                           |              |          |
      |                  |       |       | Get          | settings/credentials/AvroCred                                                         |                                                                       | 200           |                  |                                                           |              |          |
      |                  |       |       | Put          | settings/analyzers/AvroS3DataSource/AvroS3DemoDS                                      | idc/IDX_PluginPayloads/MLP-16632_AvroS3DataSource_Config.json         | 204           |                  |                                                           |              |          |
      |                  |       |       | Get          | settings/analyzers/AvroS3DataSource/AvroS3DemoDS                                      |                                                                       | 200           |                  |                                                           |              |          |
      |                  |       |       | Put          | settings/analyzers/AvroS3Cataloger/AvroS3DemoCataloger1                               | idc/IDX_PluginPayloads/MLP-16632_Avro_Cataloger_Config.json           | 204           |                  |                                                           |              |          |
      |                  |       |       | Get          | settings/analyzers/AvroS3Cataloger/AvroS3DemoCataloger1                               |                                                                       | 200           |                  |                                                           |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/AvroS3DemoCataloger1 |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='AvroS3DemoCataloger1')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/AvroS3DemoCataloger1  |                                                                       | 200           |                  |                                                           |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/AvroS3DemoCataloger1 |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='AvroS3DemoCataloger1')].status |              |          |

  ##6902316##6902322##6902326##6902330##6902337##6902342##
  @webtest @MLP-16632
  Scenario: SC#1:MLP-16632 Verification of "View" Text with link displayed next to Technical data in metadata of item view
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AvroS3DemoCataloger1" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "dynamic item click" on "AvroS3DemoCataloger1" item from search results
    And user verifies whether "View Link for metadata field" is "displayed" for "Definition" Item view page
    And user "click" on "View Link" for "Definition" in "Item view page"
    And user verifies whether "Valid json in tooltip" is "displayed" for "Definition" Item view page
    And user "click" on "Item View Title" button in "Item full View page"
    And user verifies whether "Valid json in tooltip" is "not displayed" for "Definition" Item view page
    And user "click" in "Item Full view page"
      | fieldName | actionItem  |
      | Collapse  | Description |
    And user "click" in "Item Full view page"
      | fieldName  | actionItem  |
      | Uncollapse | Description |
    And user "widget presence" on "Description" for "Overview" in "Item View" page
    And user "click" in "Item Full view page"
      | fieldName | actionItem  |
      | Collapse  | Description |

  @git
  Scenario: Delete Plugin Configuration
    Given  Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                     | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/AvroS3Cataloger/AvroS3DemoCataloger1 |      |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/AvroS3DataSource/AvroS3DemoDS        |      |               |                  |          |
      |                  |       |       | Delete | settings/credentials/AvroCred                           |      |               |                  |          |

