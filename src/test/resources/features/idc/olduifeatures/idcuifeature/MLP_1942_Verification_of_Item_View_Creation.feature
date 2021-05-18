@MLP-1942
Feature:MLP-1942: This feature is to verify the creation of New item view

  @MLP-1942 @webtest @regression @itemview @positive
  Scenario:MLP-1719: To Verify that the System Administrator can create an Item View
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name and definition for the item view
    And user chooses catalog "BigData" in CATALOGS
    And user enters the Supported Type as "Database" for Item View and click add button
    Then user clicks on Save button in the Create New Item View panel
    And user verifies that the newly added item view is displayed in the Item View Management panel
    And user clicks on logout button
    And user verifies that a JSON file is created for a new Item View
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | public     | V_Setting | *          | path         |


  @MLP-1942 @webtest @regression @itemview @negative
  Scenario:MLP-1942: Verification of error message handling while creating a duplicate Item View
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    When user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name and definition for the item view
    Then Error message should be displayed as "This name already exists. Please enter a different one."
    And user clicks on logout button


  @MLP-1942 @webtest @regression @itemview @positive
  Scenario:MLP-1942: Verification of pop up notification for unsaved changes no during the creation of New Item View
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name and definition for the item view
    Then user clicks on close icon in edit item view panel
    And user clicks on No button in alert message
    And user verifies create item view panel is displayed
    And user should be able logoff the IDC

  @MLP-1942 @webtest @regression @itemview @positive
  Scenario:MLP-1942: Verification of pop up notification for unsaved changes for an existing Item View
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on newly added item view is displayed in the Item View Management panel
    Then user edits the name in the item view
    And user clicks on close icon in edit item view panel
    And user verifies the popup alert content
    And user clicks on Yes button in alert message
    And user verifies that edited item view is not displayed in the Item View Management panel
    And user should be able logoff the IDC

  @MLP-1942 @webtest @regression @itemview @positive
  Scenario:MLP-1942: Verification of pop up notification for unsaved changes as NO for an existing Item View
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on newly added item view is displayed in the Item View Management panel
    Then user edits the name in the item view
    And user clicks on close icon in edit item view panel
    And user clicks on No button in alert message
    And user verifies create item view panel is displayed
    And user should be able logoff the IDC


  @MLP-1944 @webtest @regression @itemview @positive
  Scenario:MLP-1944: To Verify that the System Administrator can edit an Item View
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on newly added item view is displayed in the Item View Management panel
    And user enters name as "New Item View Edit" and definition as "New Item View Edit desc" for the item view
    And user chooses catalog "BigData" in CATALOGS
    And user clicks on Save button in the Create New Item View panel
    And user verifies that edited item view is displayed in the Item View Management panel
    And user clicks on logout button
    Then user verifies that a JSON file is created for edited Item View
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | public     | V_Setting | data       | path         |


  @MLP-1942 @webtest @itemview @regression @positive
  Scenario Outline:MLP-1942: Verify the deletion of Subject Area page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on mentioned itemview to be deleted "<ItemView>" in json config file
    And user clicks on Delete button in the  Edit Item View panel
    And user clicks on Yes button in alert message
    Then deleted Item View should not be listed under the Item Views
    And user clicks on logout button

    Examples:
      | ItemView           |
      | New Item View Edit |


  @MLP-1942 @webtest @regression @itemview @negative
  Scenario:MLP-1942: Verification of error message handling while creating an ItemView with leading blanks
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    When user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters leading space in the name field of new item view panel
    Then Error message should be displayed as "Invalid name. Leading/trailing blanks and slash/backslash are forbidden."
    And user clicks on logout button

  @MLP-1942 @webtest @regression @itemview @negative
  Scenario:MLP-1942: Verification of error message handling while creating an ItemView with Trailing blanks
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    When user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters trailing space in the name field of new item view panel
    Then Error message should be displayed as "Invalid name. Leading/trailing blanks and slash/backslash are forbidden."
    And user clicks on logout button

  @MLP-1942 @webtest @regression @itemview @negative
  Scenario:MLP-1942: Verification of error message handling while creating an Item View with Forward Slash
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    When user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And User enters Slash in the name field in the New Item View panel
    Then Error message should be displayed as "Invalid name. Leading/trailing blanks and slash/backslash are forbidden."
    And user clicks on logout button

  @MLP-1942 @webtest @regression @itemview @negative
  Scenario:MLP-1942: Verification of error message handling while creating an Item View with Backslash
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    When user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters Backslash in the name field in the New Item View panel
    Then Error message should be displayed as "Invalid name. Leading/trailing blanks and slash/backslash are forbidden."
    And user clicks on logout button


  @MLP-1942 @webtest @regression @itemview @negative
  Scenario:MLP-1942: Verification of pop up notification for unsaved changes yes during the creation of New Item View
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name as "Test Item View" and definition as "Test View" for the item view
    And user chooses catalog "BigData" in CATALOGS
    And user enters the Supported Type as "Database" for Item View and click add button
    Then user clicks on close icon in edit item view panel
    And user verifies the popup alert content
    And user clicks on Yes button in alert message
    And user verifies that the newly added item view should not be displayed
    And user clicks on logout button

  @MLP-1942 @webtest @regression @itemview @negative
  Scenario:MLP-1942: Delete the New Item View
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on mentioned itemview to be deleted "New Item View" in json config file
    And user clicks on Delete button in the  Edit Item View panel
    And user clicks on Yes button in warning message

  @MLP-1942 @webtest @regression @itemview @negative
  Scenario:MLP-1942_Verification of creating an empty Tab during the new item view creation
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters " " and perform key action
    Then Error message should be displayed as "This field is required"


  @MLP-1942 @webtest @regression @itemview @negative
  Scenario:MLP-1942_Verification of creating an empty widget during the new item view creation
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name as "MultipleText WIDGET" and definition as "MultipleText desc" for the item view
    And user chooses catalog "BigData" in CATALOGS
    And user enters the Supported Type as "Database" for Item View and click add button
    And user clicks on visual composer button
    And Error message "Please add at least one tab." should be displayed in Visual Composer page

  @MLP-2352 @webtest @regression @itemview @positive
  Scenario Outline:MLP-2352: Verification of selection box shows the list of existing catalogs
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name and definition for the item view
    #And user selects the BigData from catalog list
    And user chooses catalog "BigData" in CATALOGS
    And user enters the Supported Type as "Database" for Item View and click add button
    And user clicks on Save button in the Create New Item View panel
    And user clicks on home button
    Then user clicks on Catalog manager
    And user clicks on BigData catalog and checks for the view
    And user should see the created Item In The Selected Type "Database"
    And user clicks on save button in the subject area item view page
    And user clicks on save button in the Edit Catalog page
    And user clicks on home button
    And user clicks on Item View Management
    And user clicks on mentioned itemview to be deleted "<NewItemView>" in json config file
    And user clicks on Delete button in the  Edit Item View panel
    And user clicks on Yes button in warning message
    And user clicks on logout button

    Examples:
      | NewItemView   |
      | New Item View |

  @MLP-2352 @webtest @regression @itemview @positive
  Scenario Outline:MLP-2352: Verification of assigning more than one catalog to an Item View
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user clicks on Administration widget
    And User click on Subject Area Manager link on the Dashboard page
    And user clicks on Create Button in Subject Area Management page
    And user enters Name "SampleTestCatalog" and Description of New Subject Area
    And user clicks on save button in New Subject Area page
    And user clicks on home button
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name and definition for the item view
    And user chooses catalog "BigData" in CATALOGS
    And user chooses catalog "SampleTestCatalog" in CATALOGS
    And user enters the Supported Type as "Database" for Item View and click add button
    And user clicks on Save button in the Create New Item View panel
    And user clicks on home button
    Then user clicks on Catalog manager
    And user clicks on BigData catalog and checks for the view
    And user should see the created Item In The Selected Type "Database"
    And user clicks on save button in the subject area item view page
    And user clicks on save button in the Edit Catalog page
    And user clicks on "SampleTestCatalog" catalog and checks for the view
    And user should see the created Item In The Selected Type "Database"
    And user clicks on save button in the subject area item view page
    And user clicks on save button in the Edit Catalog page
    And user clicks on mentioned catalog "SampleTestCatalog" to be deleted
    And user clicks on Delete button in the New Subject Area page
    And deleted subject area mentioned in json config file should not get listed
    And user clicks on home button
    And user clicks on Item View Management
    And user clicks on mentioned itemview to be deleted "<NewItemView>" in json config file
    And user clicks on Delete button in the  Edit Item View panel
    And user clicks on Yes button in warning message
    And user clicks on logout button

    Examples:
      | NewItemView   |
      | New Item View |






