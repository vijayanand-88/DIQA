@MLP-15180
Feature: MLP-15180: SAVE - As an IDA Admin, I was to be able save search to appear for all users

  ##6868845##
  @MLP-15180 @sanity @regression @recentsearch @positive
  Scenario: Verification of adding a new serach via API
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/IDxPayloads/MLP-15180_recentsearch.json"
    When user makes a REST Call for PUT request with url "recentsearches"
    Then Status code 200 must be returned
    And user stores the values in list from response using jsonpath "$..keywords"
    And response query definition for "com/asg/dis/platform/recentsearches_user.json/TestSystem" in database should match with the response
      | description | schemaName | tableName | attributeName                         | typeName | columnName | criteriaName |
      | SELECT      | public     | items     | #>>'{data,recentSearches,0,keywords}' | Setting  |            | name         |

   ##6868611##
  @MLP-15180 @sanity @regression @recentsearch @positive
  Scenario: Verification of getting list of recent searches of the current user via API
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for Get request with url "recentsearches"
    Then Status code 200 must be returned

   ##6868611##
  @MLP-15180 @sanity @regression @recentsearch @positive
  Scenario: Verification of Deleting all the recent seraches for the current user via API
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for DELETE request with url "recentsearches"
    Then Status code 204 must be returned
