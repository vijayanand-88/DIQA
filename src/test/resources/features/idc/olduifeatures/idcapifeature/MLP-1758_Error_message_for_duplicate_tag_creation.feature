@MLP-1758
Feature: MLP-1758: No error message if user try to create a duplicate cataloger/duplicate tag

  Description:
  No error message if user try to create a duplicate cataloger/duplicate tag

  @sanity @tag @negative
  Scenario: MLP-1758: To verify error message gets displayed when duplicate tag is created
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-1758_create_tag.json"
    When user makes a REST Call for POST request with url "tags/BigData/tags"
    And Status code 200 must be returned
    And supply payload with file name "idc/MLP-1758_create_tag.json"
    And user makes a REST Call for POST request with url "tags/BigData/tags"
    Then Status code 400 must be returned
    And user passes the jsonquery "$.errorMessage" response message contains value "TAG-0002: Tag BigDataAutTag already exists"
    And user makes a REST Call for DELETE request with url "tags/BigData/tags/BigDataAutTag"
    And Status code 204 must be returned
    And user makes a REST Call for Get request with url "tags/BigData/tags/BigDataAutTag"
    And Status code 404 must be returned
