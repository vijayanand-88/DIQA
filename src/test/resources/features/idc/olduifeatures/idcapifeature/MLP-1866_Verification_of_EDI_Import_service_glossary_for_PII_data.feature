@MLP-1866
Feature: MLP-1866: Enhance the import/glossary service to work with PII information items

  Description:
  To verify the Enhance the import/glossary service to work with PII information items

  @MLP-1866 @importglossary @sanity @regression @positive
  Scenario: Deleting the upload catalog if exists
    Given A query param with "deleteData" and "true" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for DELETE request with url "settings/catalogs/ExportTag"
    Then verify created schema "ExportTag" doesn't exists in database


  @sanity @regression @importglossary @positive
  Scenario:MLP-1866: To verify catalog is created with supplied payload
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-1866_CreateTagTemplateCatalog.json"
    When user makes a REST Call for POST request with url "settings/catalogs"
    Then Status code 204 must be returned
    And verify created schema "ExportTag" exists in database

  @sanity @regression @importglossary @positive
  Scenario:MLP-1866: Verification of allowedRootType default
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/xml                    |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When supply payload with file name "idc/MLP-1866_Verification_of_allowedRootTagDefault.xml"
    And user makes a REST Call for POST request with url "import/tagtemplates" with the following query param
      | allowedTypes1 | RBG/GLOSSARY             |
      | allowedTypes2 | RBG/BUSINESS-TERM        |
      | allowedTypes3 | GDP_PERSONAL_INFORMATION |
      | allowedTypes4 | GDP_PI_STRUCTURE         |
      | catalogs      | ExportTag                |
      | prependType   | true                     |
    Then Status code 200 must be returned
    And root tags "structures.Federal.rootTags[0]['asg.originType']" should be "RBG/GLOSSARY"
    And BigData catalog should be having a root tag template "structures.Federal.rootTags[0].name" as "Federal"
    And Subtags "structures.Federal.rootTags[0].subTags.name" should be available and tag count should be 37

  @sanity @regression @importglossary @positive
  Scenario:MLP-1866: Verification of allowedRootType with type GDP_PI_STRUCTURE
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/xml                    |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When supply payload with file name "idc/MLP-1866_Verification_of_RootTag_GDP_PI_STRUCTURE.xml"
    And user makes a REST Call for POST request with url "import/tagtemplates" with the following query param
      | allowedTypes     | GDP_PERSONAL_INFORMATION |
      | allowedRootTypes | GDP_PI_STRUCTURE         |
      | catalogs         | ExportTag                |
      | prependType      | true                     |
    Then Status code 200 must be returned
    And root tags "structures.Account.rootTags[0]['asg.originType']" should be "GDP_PI_STRUCTURE"
    And BigData catalog should be having a root tag template "structures.Account.rootTags[0].name" as "Account"
    And Subtags "structures.Account.rootTags[0].subTags.name" should be available and tag count should be 5

  @sanity @regression @importglossary @positive
  Scenario:MLP-1866: Verification of allowedRootType with type RBG_BUSINESS_TERM
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/xml                    |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When supply payload with file name "idc/MLP-1866_Verification_of_RootTag_RBG_BUSINESSS_TERM.xml"
    And user makes a REST Call for POST request with url "import/tagtemplates" with the following query param
      | allowedTypes     | RBG/GLOSSARY      |
      | allowedRootTypes | RBG/BUSINESS-TERM |
      | catalogs         | ExportTag         |
      | prependType      | true              |
    Then Status code 200 must be returned
    And root tags "structures.Health.rootTags[0]['asg.originType']" should be "RBG/BUSINESS-TERM"
    And BigData catalog should be having a root tag template "structures.Health.rootTags[0].name" as "Health"
    And Subtags "structures.Health.rootTags[0].subTags.name" should be available and tag count should be 4


  @sanity @regression @importglossary @positive
  Scenario:MLP-1866: Verification of allowedRootType with type GDP_PERSONAL_INFORMATION
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/xml                    |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When supply payload with file name "idc/MLP-1866_Verification_of_RootTag_GDP_PERSONAL_INFORMATION.xml"
    And user makes a REST Call for POST request with url "import/tagtemplates" with the following query param
      | allowedTypes     | RBG/BUSINESS-TERM        |
      | allowedRootTypes | GDP_PERSONAL_INFORMATION |
      | catalogs         | ExportTag                |
      | prependType      | true                     |
    Then Status code 200 must be returned
    And root tags "structures.PII.rootTags[0]['asg.originType']" should be "GDP_PERSONAL_INFORMATION"
    And BigData catalog should be having a root tag template "structures.PII.rootTags[0].name" as "PII"
    And Subtags "structures.PII.rootTags[0].subTags.name" should be available and tag count should be 17

  @sanity @regression @importglossary @positive
  Scenario: MLP-1866: Verification of default allowedTypes
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/xml                    |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When supply payload with file name "idc/MLP-1866_Verification_of_Default_allowed_types.xml"
    And user makes a REST Call for POST request with url "import/tagtemplates" with the following query param
      | allowedRootTypes | RBG/GLOSSARY |
      | catalogs         | ExportTag    |
      | prependType      | true         |
    Then Status code 200 must be returned
    And root tags "structures.Savings.rootTags[0]['asg.originType']" should be "RBG/GLOSSARY"
    And BigData catalog should be having a root tag template "structures.Savings.rootTags[0].name" as "Savings"
    And Subtags "structures.Savings.rootTags[0].subTags.length" should be available and tag count should be 6
    And Subtags "structures.Savings.rootTags[0].subTags.[0].['asg.originType']" should be "RBG/BUSINESS-TERM"

  @regression @importglossary @positive
  Scenario: MLP-1866: Verification of import with allowedTypes not present on xml file
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/xml                    |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When supply payload with file name "idc/MLP-1866_Verification_of_RootTag_GDP_PI_STRUCTURE.xml"
    And user makes a REST Call for POST request with url "import/tagtemplates" with the following query param
      | allowedRootTypes | GDP_PI_STRUCTURE |
      | catalogs         | ExportTag        |
      | prependType      | true             |
    Then Status code 200 must be returned
    And root tags "structures.Account.rootTags[0]['asg.originType']" should be "GDP_PI_STRUCTURE"
    And BigData catalog should be having a root tag template "structures.Account.rootTags[0].name" as "Account"
    And Subtags "structures.Account.rootTags[0].subTags.name" should be available and tag count should be 0

  @regression @importglossary @positive
  Scenario: MLP-1866: Verification of importing a tags directly under root tags
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/xml                    |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When supply payload with file name "idc/MLP-1866_Verification_of_Adding_tags_under_root.xml"
    And user makes a REST Call for POST request with url "import/tagtemplates" with the following query param
      | allowedTypes     | GDP_PERSONAL_INFORMATION |
      | allowedRootTypes | RBG/GLOSSARY             |
      | catalogs         | ExportTag                |
      | prependType      | true                     |
    Then Status code 200 must be returned
    And root tags "structures.PersonalInformation.rootTags[0]['asg.originType']" should be "RBG/GLOSSARY"
    And BigData catalog should be having a root tag template "structures.PersonalInformation.rootTags[0].name" as "PersonalInformation"
    And Subtags "structures.PersonalInformation.rootTags[0].subTags.name" should be available and tag count should be 8

  @regression @importglossary @positive
  Scenario: MLP-1866: Verification of importing a tags directly under root tags
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/xml                    |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When supply payload with file name "idc/MLP-1866_Verification_of_Adding_tags_under_root.xml"
    And user makes a REST Call for POST request with url "import/tagtemplates" with the following query param
      | allowedTypes     | GDP_PERSONAL_INFORMATION |
      | allowedRootTypes | RBG/GLOSSARY             |
      | catalogs         | ExportTag                |
      | prependType      | true                     |
    Then Status code 200 must be returned
    And root tags "structures.PersonalInformation.rootTags[0]['asg.originType']" should be "RBG/GLOSSARY"
    And BigData catalog should be having a root tag template "structures.PersonalInformation.rootTags[0].name" as "PersonalInformation"
    And Subtags "structures.PersonalInformation.rootTags[0].subTags.name" should be available and tag count should be 8

  @regression @importglossary @positive
  Scenario: MLP-1866: Verification of importing a tags directly under root tags
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/xml                    |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When supply payload with file name "idc/MLP-1866_Verification_of_Adding_tags_under_root.xml"
    And user makes a REST Call for POST request with url "import/tagtemplates" with the following query param
      | allowedTypes     | GDP_PERSONAL_INFORMATION |
      | allowedRootTypes | RBG/GLOSSARY             |
      | catalogs         | ExportTag                |
      | prependType      | true                     |
    Then Status code 200 must be returned
    And root tags "structures.PersonalInformation.rootTags[0]['asg.originType']" should be "RBG/GLOSSARY"
    And BigData catalog should be having a root tag template "structures.PersonalInformation.rootTags[0].name" as "PersonalInformation"
    And Subtags "structures.PersonalInformation.rootTags[0].subTags.name" should be available and tag count should be 8

  @regression @importglossary @negative
  Scenario: MLP-1866: Verification of importing a duplicate tags
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/xml                    |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When supply payload with file name "idc/MLP-1866_Verification_of_Adding_Duplicate_tags.xml"
    And user makes a REST Call for POST request with url "import/tagtemplates" with the following query param
      | catalogs    | ExportTag |
      | prependType | true      |
    Then Status code 400 must be returned
    And response body should have "Tag template cannot contain duplicated tags" message
    




