@MLP-6361
Feature: MLP-6361: Services for supporting Glossary and PII based tags

  Description:
  Services for supporting Glossary and PII based Tags

  @webtest @MLP-6361
  Scenario Outline: MLP-6361: Verification of updating name of existing PII Entity
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user selects the "Column" from the Type
    And user clicks on first item on the item list page
    And user "click" on "add tag button" in Item view page
    And user click on create new tag in the Add tags panel
    And user enters the new tag name as "Customer"
    And user clicks on save button in the edit properties page
    And user clicks on save button
    And user get the column "Customer" id from the following query
      | description | schemaName       | tableName   | columnName | criteriaName |
      | SELECT      | BusinessGlossary | V_PIIEntity | ID         | name         |
    When user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestServiceUser" user
    Then Status code 200 must be returned
    And user stores the value from response using jsonpath"$..['id']"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-6361_Verification of updating name of existing PII Entity tags.json"
    When user makes a REST Call for "PUT" request with url "items/BusinessGlossary/BusinessGlossary.PIIEntity%3A%3A%3AstoredID" and path ""
    Then Status code 204 must be returned
    And User launch browser and traverse to login page
    And user enters the search text "CustomerUpdated" and clicks on search
    And user should be seeing the quick link "CustomerUpdated" in My Search panel
    And user refreshes the application
    And user selects "BigData" catalog from catalog list
#    And user validate whether the "PII" tag is listed in Tag facet - Open issue MLP-7376
#    And user validate whether the "CustomerUpdated" tag is listed in Tag facet - Open issue MLP-7376


    Examples:
      | contentType      | acceptType       | type | url                                                        | endpoint | body |
      | application/json | application/json | Get  | items/BusinessGlossary/BusinessGlossary.PIIEntity%3A%3A%3A |          |      |


  @webtest @MLP-6361
  Scenario Outline: MLP-6361: Verification of updating name of existing PII Attribute
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user selects the "Column" from the Type
    And user clicks on first item on the item list page
    And user "click" on "add tag button" in Item view page
    And user click on create new tag in the Add tags panel
    And user enters the new tag name as "Address"
    And user clicks on save button in the edit properties page
    And user clicks on save button
    And user get the column "Address" id from the following query
      | description | schemaName       | tableName      | columnName | criteriaName |
      | SELECT      | BusinessGlossary | V_PIIAttribute | ID         | name         |
    When user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestServiceUser" user
    Then Status code 200 must be returned
    And user stores the value from response using jsonpath"$..['id']"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-6361_Verification of updating name of existing PII Attribute tags.json"
    When user makes a REST Call for "PUT" request with url "items/BusinessGlossary/BusinessGlossary.PIIAttribute%3A%3A%3AstoredID" and path ""
    Then Status code 204 must be returned
    And User launch browser and traverse to login page
    And user enters the search text "AddressUpdated" and clicks on search
    And user should be seeing the quick link "AddressUpdated" in My Search panel
    And user refreshes the application
    And user selects "BigData" catalog from catalog list
#    And user validate whether the "PII" tag is listed in Tag facet - Open issue MLP-7376
#    And user validate whether the "AddressUpdated" tag is listed in Tag facet - Open issue MLP-7376

    Examples:
      | contentType      | acceptType       | type | url                                                           | endpoint | body |
      | application/json | application/json | Get  | items/BusinessGlossary/BusinessGlossary.PIIAttribute%3A%3A%3A |          |      |


  @webtest @MLP-6361
  Scenario Outline: MLP-6361: Verification of updating name of existing Business Term
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-6361_Creating a Business Term tag.json"
    When user makes a REST Call for POST request with url "/items/BusinessGlossary/root"
    And Status code 200 must be returned
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user selects the "Column" from the Type
        And user clicks on first item on the item list page
    And user "click" on "add tag button" in Item view page
    And user click on create new tag in the Add tags panel
    And user enters the new tag name as "BT"
    And user clicks on save button in the edit properties page
    And user clicks on save button
    And user get the column "BT" id from the following query
      | description | schemaName       | tableName      | columnName | criteriaName |
      | SELECT      | BusinessGlossary | V_BusinessTerm | ID         | name         |
    And configure a new REST API for the service "IDC"
    And user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestServiceUser" user
    And user stores the value from response using jsonpath"$..['id']"
    And user update dataset id in "idc/MLP-6361_Verification of updating name of existing Business Term tags.json" file with json path "$..id"
    And supply payload with file name "idc/MLP-6361_Verification of updating name of existing Business Term tags.json"
    When user makes a REST Call for "PUT" request with url "items/BusinessGlossary/BusinessGlossary.BusinessTerm%3A%3A%3AstoredID" and path ""
    Then Status code 204 must be returned
    And user enters the search text "BTUpdated" and clicks on search
    And user should be seeing the quick link "BTUpdated" in My Search panel
    And user refreshes the application
    And user selects "BigData" catalog from catalog list
#    And user validate whether the "Glossary" tag is listed in Tag facet - Open issue MLP-7376
#    And user validate whether the "BTUpdated" tag is listed in Tag facet - Open issue MLP-7376

    Examples:
      | contentType      | acceptType       | type | url                                                           | endpoint | body |
      | application/json | application/json | Get  | items/BusinessGlossary/BusinessGlossary.BusinessTerm%3A%3A%3A |          |      |


  @webtest @MLP-6361
  Scenario: MLP-6361: Deleting Business Term created
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user get the column "BTUpdated" id from the following query
      | description | schemaName       | tableName      | columnName | criteriaName |
      | SELECT      | BusinessGlossary | V_BusinessTerm | ID         | name         |
    And user makes a REST Call to DELETE dataset "items/BusinessGlossary/BusinessGlossary.BusinessTerm:::"
    Then Status code 204 must be returned
