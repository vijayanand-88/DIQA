#@MLP-5337
#Feature: MLP-5337_Verification of creating an item type which belongs to Business catalog
#
#  @webtest @MLP-5337 @positive @regression @report
#  Scenario: MLP-5337 Verification of creating an item type Business Term which belongs to Business catalog
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And user selects catalog "Business Catalog" and type "BusinessTerm" in create item panel
#    And user enters the following values in create item panel fields
#      | createItemFieldName   | createItemFieldValue      |
#      | NAME                  | Payments                  |
#      | DESCRIPTION           | This is part of testing   |
#    And user "click" on "Save" in create item panel
#    And user selects "Business Catalog" catalog from catalog list
#    And user selects the "BusinessTerm" from the Type
#    When user clicks on "Payments" item from search results
#    Then user get the ID for data set "Payments" from below query
#      | description | schemaName      | tableName      | columnName | criteriaName |
#      | SELECT      | BusinessCatalog | V_BusinessTerm | name       | name         |
#
#  @webtest @MLP-5337 @positive @regression @report
#  Scenario: MLP-5337 Verification of creating an item type PII Category which belongs to Business catalog
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And user selects catalog "Business Catalog" and type "PIICategory" in create item panel
#    And user enters the following values in create item panel fields
#      | createItemFieldName   | createItemFieldValue      |
#      | NAME                  | PrivateSector             |
#      | DESCRIPTION           | This is part of testing   |
#    And user "click" on "Save" in create item panel
#    And user selects "Business Catalog" catalog from catalog list
#    And user selects the "PIICategory" from the Type
#    When user clicks on "PrivateSector" item from search results
#    Then user get the ID for data set "PrivateSector" from below query
#      | description | schemaName      | tableName      | columnName | criteriaName |
#      | SELECT      | BusinessCatalog | V_PIICategory  | name       | name         |
#
#  @webtest @MLP-5337 @positive @regression @report
#  Scenario: MLP-5337 Verification of creating an item type PII Entity which belongs to Business catalog
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And user selects catalog "Business Catalog" and type "PIIEntity" in create item panel
#    And user enters the following values in create item panel fields
#      | createItemFieldName   | createItemFieldValue      |
#      | NAME                  | IT Industry               |
#      | DESCRIPTION           | This is part of testing   |
#    And user "click" on "Save" in create item panel
#    And user selects "Business Catalog" catalog from catalog list
#    And user selects the "PIIEntity" from the Type
#    When user clicks on "IT Industry" item from search results
#    Then user get the ID for data set "IT Industry" from below query
#      | description | schemaName      | tableName      | columnName | criteriaName |
#      | SELECT      | BusinessCatalog | V_PIIEntity  | name       | name         |
#
#  @webtest @MLP-5337 @positive @regression @report
#  Scenario: MLP-5337 Verification of creating an item type PII Attribute which belongs to Business catalog
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And user selects catalog "Business Catalog" and type "PIIAttribute" in create item panel
#    And user selects root type "PIIEntity" and name "It Industry" in create item panel
#    And user enters the following values in create item panel fields
#      | createItemFieldName   | createItemFieldValue      |
#      | NAME                  | Pan                       |
#      | DESCRIPTION           | This is part of testing   |
#      | SENSITIVE?            | True                      |
#    And user "click" on "Save" in create item panel
#    And user selects "Business Catalog" catalog from catalog list
#    And user selects the "PIIAttribute" from the Type
#    When user clicks on "Pan" item from search results
#    Then user get the ID for data set "Pan" from below query
#      | description | schemaName      | tableName      | columnName | criteriaName |
#      | SELECT      | BusinessCatalog | V_PIIAttribute | name       | name         |
#
#  @webtest @MLP-5337 @positive @regression @report
#  Scenario: MLP-5337 Verification of creating an item type PII Property which belongs to Business catalog
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And user selects catalog "Business Catalog" and type "PIIProperty" in create item panel
#    And user selects root type "PIIAttribute" and name "Pan" in create item panel
#    And user enters the following values in create item panel fields
#      | createItemFieldName   | createItemFieldValue        |
#      | NAME                  | Pan Number                  |
#      | DESCRIPTION           | This is part of testing     |
#      | DATA PATTERN          | [A-Za-z]{5}\d{4}[A-Za-z]{1} |
#    And user "click" on "matchFull" in create item panel
#    And user "click" on "Save" in create item panel
#    And user selects "Business Catalog" catalog from catalog list
#    And user selects the "PIIProperty" from the Type
#    When user clicks on "Pan Number" item from search results
#    Then user get the ID for data set "Pan Number" from below query
#      | description | schemaName      | tableName      | columnName | criteriaName |
#      | SELECT      | BusinessCatalog | V_PIIProperty | name       | name         |