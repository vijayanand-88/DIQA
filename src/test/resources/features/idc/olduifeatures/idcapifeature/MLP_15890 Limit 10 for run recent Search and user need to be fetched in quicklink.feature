@MLP-15890
Feature: MLP-15890: Limit 10 for run recent Search and user need to be fetched in quicklink

   ##6873830##
  @MLP-15890 @regression @positive @quicklinks @savedsearch
  Scenario: SC#1: MLP-15890_Verify if GET quicklinks with id returns 200 with username in json response
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for Get request with url "/quicklinks"
    Then Status code 200 must be returned
    And user verifies whether the value is present in response using json path "$..['username']"
      | jsonValues                 |
      | Test System Administrator  |

   ##6873829##
  @MLP-15890 @regression @positive @quicklinks @savedsearch
  Scenario: SC#2: MLP-15890_Verify if the POST action for quicklink throws 200 status
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/IDxPayloads/MLP_15890 Save_UserName_Quicklinks.json"
    When user makes a REST Call for POST request with url "/quicklinks"
    And Status code 200 must be returned
    And user verifies whether the value is present in response using json path "$..['username']"
      | jsonValues                 |
      | Test System Administrator  |
    And user makes a REST Call for Get request with url "/quicklinks"
    Then Status code 200 must be returned
    And user verifies whether the value is present in response using json path "$..['name']"
      | jsonValues  |
      | PII Search  |
    And user verifies whether the value is present in response using json path "$..['username']"
      | jsonValues                 |
      | Test System Administrator  |
    And verify created "recentsearch" is available for "TestSystem" User
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | public     | V_Setting | data       | path         |

    ##6873831##
  @MLP-15890 @regression @positive @quicklinks @savedsearch
  Scenario: SC#3: MLP-15890_Verify if the PUT action by ID and Get action by ID for quicklink throws correct status
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes REST call for Get "/quicklinks" and retrieves value from using jsonpath "$.[-1:].id"
    And supply payload with file name "idc/IDxPayloads/MLP_15890 Update_Name_Quicklinks.json"
    When user makes a REST Call for "PUT" request with url "/quicklinks/storedText" and path ""
    And Status code 204 must be returned
    When user makes a REST Call for "GET" request with url "/quicklinks/storedText" and path ""
    And Status code 200 must be returned
    And user verifies whether the value is present in response using json path "$..['name']"
      | jsonValues         |
      | PII Search Updated |
    And user verifies whether the value is present in response using json path "$..['username']"
       | jsonValues                 |
       | Test System Administrator  |
    And verify created "recentsearch" is available for "TestSystem" User
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | public     | V_Setting | data       | path         |

     ##6874994##
  @MLP-15890 @regression @positive @quicklinks @savedsearch
  Scenario: SC#4: MLP-15890_Verify if the DELETE action by ID for quicklink throws 204 status
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "DELETE" request with url "/quicklinks/storedText" and path ""
    Then Status code 204 must be returned

      ##6873828##
  @MLP-15890 @regression @positive @quicklinks @savedsearch
  Scenario: SC#5: MLP-15890_Verify if GET quicklinks with Limit and Offset returns 200 response
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for Get request with url "recentsearches?limit=10&offset=0"
    Then Status code 200 must be returned
    And response message contains value "date"
    And response message contains value "keywords"
    And response message contains value "catalog"




