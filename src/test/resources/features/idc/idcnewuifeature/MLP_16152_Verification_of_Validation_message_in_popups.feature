@MLP-16152
Feature:MLP-16152: This feature is to verify As a IDA Admin, I need an option to validate and hint text for the form field elements in configuration popups and save search popup so that those information can assist to fill the data.

  ##6883175##6883176##6883177##6883194##
  @MLP-16152 @webtest @regression @positive
  Scenario:SC#1:MLP-16152 : Verify that the validation messages is displayed below the form elements of Username/password type in the Add Credentail pop over.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Credentials" in "Landing page"
    And user "click" on "Add Credentials Button in Manage Credentials Page" button in "Manage Credentials page"
    And user "select dropdown" in Add Credentials Page
      | fieldName | attribute         |
      | Type      | Username/Password |
    And user verifies "Save Button" is "disabled" in "Add Credential pop up"
    And user verifies "validation message" is displayed under the fields in "Add Credential" Popup
      | fieldName | validationMessage                   |
      | Name      | Name field should not be empty      |
      | User Name | User Name field should not be empty |
      | Password  | Password field should not be empty  |
    And user verifies "Save Button" is "disabled" in "Add Credential pop up"
    And user "click" on "Add Credentials Button in Manage Credentials Page" button in "Manage Credentials page"
    And user "select dropdown" in Add Credentials Page
      | fieldName | attribute |
      | Type      | AWS       |
    And user verifies "validation message" is displayed under the fields in "Add Credential" Popup
      | fieldName  | validationMessage                    |
      | Name       | Name field should not be empty       |
      | Access Key | Access Key field should not be empty |
      | Secret Key | Secret Key field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Credential pop up"
    And user "click" on "Add Credentials Button in Manage Credentials Page" button in "Manage Credentials page"
    And user "select dropdown" in Add Credentials Page
      | fieldName | attribute |
      | Type      | token     |
    And user verifies "validation message" is displayed under the fields in "Add Credential" Popup
      | fieldName | validationMessage               |
      | Name      | Name field should not be empty  |
      | Token     | Token field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Credential pop up"

  ##6883178##6883193##
  @MLP-16152 @webtest @regression @positive
  Scenario:SC#2:MLP-16152 : Verify that the validation message is displayed below the form elements when you add a DataSource
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Data Sources" in "Landing page"
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute              |
      | Data Source Type | GitCollectorDataSource |
    And user verifies "Save Button" is "disabled" in "Add Credential pop up"
    And user verifies "validation message" is displayed under the fields in "Add Data Source" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |
      | URL       | URL field should not be empty  |
    And user verifies "Save Button" is "disabled" in "Add Credential pop up"

  ##6883179##6883181##6883182##6883184##
  @MLP-16152 @webtest @regression @positive
  Scenario:SC#3:MLP-16152 : Verify that the validation message is displayed below the form elements when a configuration is added for DynamoDBCataloger for Cataloger type.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName  | attribute         |
      | Type       | Cataloger         |
      | Plugin     | DynamoDBCataloger |
      | Credential | Add credential    |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName  | validationMessage                    |
      | Name       | Name field should not be empty       |
      | Access Key | Access Key field should not be empty |
      | Secret Key | Secret Key field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute          |
      | Type      | Collector          |
      | Plugin    | LocalFileCollector |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |
      | root      | root field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute              |
      | Type      | Dataanalyzer           |
      | Plugin    | AmazonRedshiftAnalyzer |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName     | validationMessage                       |
      | Name          | Name field should not be empty          |
      | Host name     | Host name field should not be empty     |
      | Database Name | Database Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute        |
      | Type      | Linker           |
      | Plugin    | SimilarityLinker |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

    ##6883186##6883190##6883195##
  @MLP-16152 @webtest @regression @positive
  Scenario:SC#4:MLP-16152 : Verify that the validation message is displayed below the form elements when you add a Save Search.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user "click" on "Search Results Show more options" for "Save Search" in "Search Results page"
    And user waits for the final status to be reflected after "2000" milliseconds
    And user verifies "Save Search Save Button" is "disabled" in "Save Search pop up"
    And user verifies "validation message" is displayed under the fields in "Save Search" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |
    And user verifies "Hint text" is displayed under the fields in "Save Search" Popup
      | fieldName | validationMessage                                                          |
      | Name      | Provide a name for your search. You can use this name to run saved search. |


    #commented this case - Not a priority for this release
#  ##6883180##
#  @MLP-16152 @webtest @regression @positive
#  Scenario:SC#6:MLP-16152 : Verify that the validation message is displayed below the form elements when a configuration is added for EDIBus for Bulk type.
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the sidebar
#      | actionType | actionItem            |
#      | click      | Settings Icon         |
#      | click      | Manage Configurations |
#    And user performs "click" operation in Manage Configurations panel
#      | button          | actionItem |
#      | Open Deployment | LocalNode  |
#    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
#    And user "select dropdown" in Add Configuration Page in Manage Configurations
#      | fieldName | attribute |
#      | Type      | Bulk      |
#      | Plugin    | EDIBus    |
#    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
#      | fieldName                | validationMessage                                  |
#      | Name                     | Name field should not be empty                     |
#      | Edi Host                 | EDI host field should not be empty                 |
#      | Edi Port                 | EDI port field should not be empty                 |
#      | Edi User                 | EDI user field should not be empty                 |
#      | Edi Subject Area Name    | EDI subject area name field should not be empty    |
#      | Edi Subject Area Version | EDI subject area version field should not be empty |
#    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

#  ##6883183###descoped
#  @MLP-16152 @webtest @regression @positive
#  Scenario:SC#9:MLP-16152 : Verify that the validation message is displayed below the form elements when a configuration is added for CommomLineage for Lineage type.
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the sidebar
#      | actionType  | actionItem            |
#      | click | Settings Icon         |
#      | click       | Manage Configurations |
#    And user performs "click" operation in Manage Configurations panel
#      | button          | actionItem |
#      | Open Deployment | LocalNode  |
#    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
#    And user "select dropdown" in Add Configuration Page in Manage Configurations
#      | fieldName | attribute     |
#      | Type      | Lineage       |
#      | Plugin    | CommonLineage |
#    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
#      | fieldName        | validationMessage                          |
#      | Name             | Name field should not be empty             |
#      | Candidates Query | Candidates query field should not be empty |
#    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

#  ##6883185###descoped
#  @MLP-16152 @webtest @regression @positive
#  Scenario:SC#11:MLP-16152 : Verify that the validation message is displayed below the form elements when a configuration is added for PythonParser for Parser type.
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the sidebar
#      | actionType  | actionItem            |
#      | click | Settings Icon         |
#      | click       | Manage Configurations |
#    And user performs "click" operation in Manage Configurations panel
#      | button          | actionItem |
#      | Open Deployment | LocalNode  |
#    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
#    And user "select dropdown" in Add Configuration Page in Manage Configurations
#      | fieldName | attribute    |
#      | Type      | Parser       |
#      | Plugin    | PythonParser |
#    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
#      | fieldName | validationMessage              |
#      | Name      | Name field should not be empty |
#    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

    #############################################################################

  ##6874883##
  @MLP-15828 @webtest @regression @positive
  Scenario:SC#1:MLP-15828 : Verify that the Mouse Hover shows a background color (#E5E5E5)to highlight the item in the DD in the Add data Source pop over.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Data Sources" in "Landing page"
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
    And user "Uncollapse dropdown" in "Add Data Source popup"
      | fieldName        | actionItem               |
      | Data Source Type | AmazonRedshiftDataSource |
    And user verifies "background color" is displayed under the fields in "Add Data Source" Popup
      | fieldName                | validationMessage |
      | AmazonRedshiftDataSource | #e5e5e5           |

  ##6874920##6874922##
  @MLP-15828 @webtest @regression @positive
  Scenario:SC#2:MLP-15828 : Verify that the Mouse Hover shows a background color (#E5E5E5) to highlight the item for type DD in the Add Configuration pop over.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "Uncollapse dropdown" in "Add Configuration popup"
      | fieldName | actionItem |
      | Type      | Cataloger  |
    And user verifies "background color" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage |
      | Cataloger | #e5e5e5           |
    And user "click" on "PopUp X" button in "Add Configuration page"
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute |
      | Type      | Cataloger |
    And user "Uncollapse dropdown" in "Add Configuration popup"
      | fieldName | actionItem              |
      | Plugin    | AmazonRedshiftCataloger |
    And user verifies "background color" is displayed under the fields in "Add Configuration" Popup
      | fieldName               | validationMessage |
      | AmazonRedshiftCataloger | #e5e5e5           |

  ##6874954##6878422##
  @MLP-15828 @webtest @regression @positive
  Scenario:SC#3:MLP-15828 : Verify that the Mouse Hover shows a background color (#E5E5E5)to highlight the type DD item in the Add Credential pop over.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Credentials" in "Landing page"
    And user "click" on "Add Credentials Button in Manage Credentials Page" button in "Manage Data Sources page"
    And user "Uncollapse dropdown" in "Add Credential popup"
      | fieldName | actionItem        |
      | Type      | Username/Password |
    And user verifies "background color" is displayed under the fields in "Add Credential" Popup
      | fieldName         | validationMessage |
      | Username/Password | #e5e5e5           |
    And user "click" on "PopUp X" button in "Add Configuration page"
    And user "click" on "Filter Icon" button in "Manage Credentials Page"
    And user "click" on "Type Dropdown" button in "Manage Credentials Page"
    And user verifies "background color" is displayed under the fields in "Manage Credentials" Popup
      | fieldName         | validationMessage |
      | Username/Password | #e5e5e5           |
#