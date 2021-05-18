@MLP-1716 @test
Feature: MLP-1716: Tag Templates creation and adding a tag template to catalogs

  @MLP-1716 @tagtemplate @sanity @regression  @positive
  Scenario: Verification of Creating a new Global tag template
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "settings/tagtemplates/TestTagTemplate"
    And user makes a REST Call for DELETE request with url "settings/catalogs/Newcatalog"
    And supply payload with file name "idc/MLP-1716_CreateCatalog.json"
    When user makes a REST Call for POST request with url "/settings/catalogs"
    Then Status code 204 must be returned
    And supply payload with file name "idc/MLP-1716_GlobalTagTemplate.json"
    When user makes a REST Call for POST request with url "settings/tagtemplates"
    Then Status code 204 must be returned
    And user makes a REST Call for Get request with url "settings/tagtemplates"
    And newly added Tag template "TestTagTemplate" should be found in the response body

  @MLP-1716 @tagtemplate @sanity @regression  @positive
  Scenario: Verification of Creating a new Global Sample tag template
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "settings/tagtemplates/Sample"
    And supply payload with file name "idc/MLP-1716_GlobalSampleTagTemplate.json"
    When user makes a REST Call for POST request with url "settings/tagtemplates"
    Then Status code 204 must be returned
    And user makes a REST Call for Get request with url "settings/tagtemplates"
    And newly added Tag template "Test Tag Template" should be found in the response body


  @MLP-1716 @tagtemplate @sanity @regression @webtest @positive
  Scenario: Verification of adding a global tag template to catalog
    Given A query param with "keepOld" and "true" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for POST request with url "tags/Newcatalog/structures/TestTagTemplate"
    Then Status code 204 must be returned
    When user makes a REST Call for POST request with url "/tags/Newcatalog/structures/Data%20Analysis"
    Then Status code 204 must be returned
    When user makes a REST Call for POST request with url "/tags/Newcatalog/structures/PII%20-%20BusinessGlossary"
    Then Status code 204 must be returned
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user clicks on Administration widget
    And User click on Subject Area Manager link on the Dashboard page
    And user clicks on "Newcatalog" catalog in catalog management
    And user clicks on view tags in edit subject area
#    And user clicks on BigData catalog and checks for the tag
    And user should find "Test Tag Template" tag template and other templates like "Data Analysis" and "PII - BusinessGlossary"

  @MLP-1716 @tagtemplate @regression @webtest @positive
  Scenario: Verification of updating a tag structure of catalog by keeping param as true
    Given A query param with "keepOld" and "true" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-1716_DataAnalysisTagTemplateUpdate.json"
    When user makes a REST Call for POST request with url "tags/Newcatalog/structures"
    Then Status code 204 must be returned
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user clicks on Administration widget
    And User click on Subject Area Manager link on the Dashboard page
    And user clicks on "Newcatalog" catalog in catalog management
    And user clicks on view tags in edit subject area
    And user should find "Data Analysis" tag template and other template "Test Tag Template"
    And user should be able to find newly added sub tag "Newly added Test Tag" and its subtag "Test Sub Tag"

  @MLP-1716 @tagtemplate @sanity @regression @webtest @positive
  Scenario: Verification of adding a global tag template to catalog with KeepOld param as false
    Given A query param with "keepOld" and "false" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for POST request with url "tags/Newcatalog/structures/Sample"
    Then Status code 204 must be returned
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user clicks on Administration widget
    And User click on Subject Area Manager link on the Dashboard page
    And user clicks on "Newcatalog" catalog in catalog management
    And user clicks on view tags in edit subject area
    And user should find "Sample" tag template and other templates like "Data Analysis" and "PII - BusinessGlossary" should not be there

  @MLP-1716 @tagtemplate @regression @webtest @positive
  Scenario: Verification of updating a tag structure of catalog by keeping param as false
    Given A query param with "keepOld" and "false" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-1716_Tag_Update_False.json"
    When user makes a REST Call for POST request with url "tags/Newcatalog/structures"
    Then Status code 204 must be returned
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user clicks on Administration widget
    And User click on Subject Area Manager link on the Dashboard page
    And user clicks on "Newcatalog" catalog in catalog management
    And user clicks on view tags in edit subject area
    And user should find "Database" tag template and other templates like "Data Analysis" and "PII - BusinessGlossary" should not be there
    And user should be able to find newly added sub tag "northwind" and its subtag "inventory_fact"
    And user makes a REST Call for DELETE request with url "settings/tagtemplates/TestTagTemplate"

  @MLP-1716 @tagtemplate @sanity @regression @positive
  Scenario: Verification of adding a default tag template to catalog
    Given A query param with "keepOld" and "true" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for POST request with url "/tags/Newcatalog/structures/Data%20Analysis"
    Then Status code 204 must be returned
    When user makes a REST Call for POST request with url "/tags/Newcatalog/structures/PII%20-%20BusinessGlossary"
    Then Status code 204 must be returned


