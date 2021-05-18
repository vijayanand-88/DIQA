@MLP-3228
Feature:MLP-3228: This feature is to verify the file uploading and accessing tag information

  @MLP-3228 @webtest @subjectAreaManagement @regression @positive
  Scenario: MLP-3228: Verification of same tag can appear in different root tag
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "settings/tagtemplates/Personal%20EDI"
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/xml                    |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And supply payload with file name "idc/MLP_3288_TagTemplate.xml"
    When user makes a REST Call for POST request with url "import/tagtemplates" with the following query param
      | allowedTypes | GDP_PERSONAL_INFORMATION&allowedRootTypes=RBG%2FGLOSSARY&catalogs=BigData&prependType=true |
    Then Status code 200 must be returned
    And response message contains value "Personal EDI"
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And User click on Subject Area Manager link on the Dashboard page
    And user clicks on mentioned Subject Area in json config file "BigData"
    And user clicks on view tags in edit subject area
    And user clicks on add tag template button
    And user selects "Personal EDI" template in the list of tag templates
    And user clicks on close button in the Edit Tags page
    Then the "Personal EDI" template should get displayed in the Add Tags page
    And user clicks on view tags in edit subject area
    And user verifies whether the child tag is present under the root tag
      | parentTag    | childTag   |
      | PII          | IP Address |
      | Personal EDI | IP Address |
    And user should be able logoff the IDC

  @MLP-3228 @webtest @regression @positive @subjectAreaManagement
  Scenario:MLP-3228: Verification of moving a tag already present under another root tag
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    When User click on Subject Area Manager link on the Dashboard page
    And user clicks on mentioned Subject Area in json config file "BigData"
    And user clicks on view tags in edit subject area
    And user drag and drops "IP Address" child tag from the parent tag "Personal EDI" to the parent tag "PII"
    And user verifies whether the child tag is present under the root tag
      | parentTag    | childTag   |
      | Personal EDI | IP Address |
    And user should be able logoff the IDC

  @MLP-3228 @webtest @subjectAreaManagement @regression
  Scenario:MLP-3228: Verification of hierarchical facets for a tag under multiple root tag
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user "click" on "add tag button" in Item view page
    And user assign the following tags to item
      | tagName    |
      | IP Address |
    And user clicks on save button
    And user clicks on close button in the item full view page
    And user clicks on home button
    And user clicks on search icon
    Then user validate whether the "IP Address" tag is listed in Tag facet
    And user clicks on logout button

  @MLP-3228 @webtest @subjectAreaManagement @regression
  Scenario:MLP-3228: Verification of hierarchical facets for multiple tags
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user selects the "Column" from the Type
    And user clicks on first item on the item list page
    And user "click" on "add tag button" in Item view page
    And user assign the following tags to item
      | tagName    |
      | IP Address |
    And user clicks on save button
    And user clicks on close button in the item full view page
    And user clicks on home button
    And user clicks on search icon
    Then user validate whether the child tag is listed under root tag in Tag facet
      | parentTag              | childTag   |
      | PII - BusinessGlossary | IP Address |
      | Personal EDI           | IP Address |
    And user clicks on logout button

  @MLP-3228 @webtest @subjectAreaManagement @regression
  Scenario:MLP-3228: Verification of deleting a tag present under multiple root tag
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And User click on Subject Area Manager link on the Dashboard page
    And user clicks on mentioned Subject Area in json config file "BigData"
    And user clicks on view tags in edit subject area
    And user verifies whether the child tag is present under the root tag
      | parentTag    | childTag   |
      | PII          | IP Address |
      | Personal EDI | IP Address |
    And user deletes the child tag from the root tag
      | parentTag    | childTag   |
      | Personal EDI | IP Address |
    And user clicks on active panel save button
    And user clicks on active panel save button
    And user clicks on mentioned Subject Area in json config file "BigData"
    And user clicks on view tags in edit subject area
    And user verifies whether the child tag is not present under the root tag
      | parentTag    | childTag   |
      | Personal EDI | IP Address |
    And user verifies whether the child tag is present under the root tag
      | parentTag | childTag   |
      | PII       | IP Address |
    And user clicks on logout button

  @MLP-3228 @webtest @regression @positive @subjectAreaManagement
  Scenario:MLP-3228: Verification of Editing a tag with the name which is present in another tag hierarchy
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    When User click on Subject Area Manager link on the Dashboard page
    And user clicks on mentioned Subject Area in json config file "BigData"
    And user clicks on view tags in edit subject area
    And user clicks on edit button near the child tag "Private"
    And user enters the tag name as "State"
    And user clicks on save button in the edit properties page
    And user clicks on active panel save button
    And user clicks on active panel save button
    And user clicks on mentioned Subject Area in json config file "BigData"
    And user clicks on view tags in edit subject area
    And user verifies whether the child tag is present under the root tag
      | parentTag     | childTag |
      | Data Analysis | State    |
    And user should be able logoff the IDC

  @MLP-3228 @webtest @regression @positive @subjectAreaManagement
  Scenario:MLP-3228: Verification of Editing a parent tag with another parent tag name
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    When User click on Subject Area Manager link on the Dashboard page
    And user clicks on mentioned Subject Area in json config file "BigData"
    And user clicks on view tags in edit subject area
    And user clicks on edit button near the parent tag "Technology"
    And user enters the tag name as "Data Analysis"
    Then user verifies the alert message is displayed under the fields in Edit properties panel
      | fieldName | validationMessage                                                                   |
      | Name      | A tag with this name already exists in this catalog. Please enter a different name. |
    And user verifies save button is diabled in the edit properties page
    And user should be able logoff the IDC

  @MLP-3228 @webtest @regression @positive @subjectAreaManagement
  Scenario:MLP-3228: Verification of adding a duplicate tag template
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    When User click on Subject Area Manager link on the Dashboard page
    And user clicks on mentioned Subject Area in json config file "BigData"
    And user clicks on view tags in edit subject area
    And user clicks on add tag template button
    And user selects "Personal EDI" template in the list of tag templates
    Then user verifies current add tag template panel is not closed
    And user should be able logoff the IDC

  @MLP-3159 @webtest @regression @positive @dashboard
  Scenario:MLP-3159: Verification of option to fullsize iframe widget
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name as "itemview_TestAttributes" and definition as "Test Attribute View" for the item view
    And user chooses catalog "BigData" in CATALOGS
    And user enters the Supported Type as "Column" for Item View and click add button
    And user clicks on visual composer button
    And user clicks on add button in the Create New Item View panel
    And User drag and drop a "IFRAME WIDGET" widget to the page from the displayed widget sets
    And the user clicks on edit button on the widget
    And user enters the values in the fields under the widget panel
      | fieldName  | fieldValue                                     |
      | LABEL      | IDC                                            |
      | IFRAME URL | https://dechedocker02v.asg.com/IDC/swagger-ui/ |
    And user clicks on the apply buuton in the edit widget panel
    And user enters "TestIFrame" name field of new item view panel dashboad
    And user clicks on set as preview button in Visual composer
    And user clicks on apply button on visual composer
    And user clicks on Save button in the Create New Item View panel
    And user clicks on home button
    And user clicks on Quickstart Dashoboard
    And user selects the BigData catalog from catalog list
    And user clicks on search icon
    And user selects the "Column" from the Type
    And user clicks on first item on the item list page
    And user verifies "TestIFrame" tab is displayed and active in the item full view
    And user clicks on full size icon in the item full view
    And user verifies the full screen view
    And user clicks on compress icon in the item full view
    And user verifies "TestIFrame" tab is displayed and active in the item full view
    And user should be able logoff the IDC

  @MLP-3159 @webtest @regression @positive @dashboard
  Scenario:MLP-3159: Verification of exit of fullsize iframe widget
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects the BigData catalog from catalog list
    And user clicks on search icon
    And user selects the "Column" from the Type
    And user clicks on first item on the item list page
    And user clicks on full size icon in the item full view
    And user verifies the full screen view
#    And user clicks on "Escape" key
    And user clicks on compress icon in the item full view
    And user verifies "TestIFrame" tab is displayed and active in the item full view
    And user clicks on home button
    And user clicks Yes on the alert window
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on "itemview_TestAttributes" from item view list
    And user clicks on Delete button in the  Edit Item View panel
    And user clicks on Yes button in alert message
    And user should be able logoff the IDC

  @MLP-3231 @webtest @dashboard @regression
  Scenario:MLP-3231: Verification of redesign of Meta data panel, Rating panel, Tag panel and tags section when no tags are present
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user enters the search text "customer" in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user verifies "METADATA" label and its property container
    And user verifies "RATING" label and its property container
    And user verifies "TAG" label and its property container
    And user verifies the text "Looks like no tags are available. To add your own, click +Add above." inside the Tag section
    And user should be able logoff the IDC

  @webtest @MLP-3445 @regression @positive @dashboard
  Scenario: MLP-3445 Verification of Plugin Management icon in Bundle Details panel
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Bundle Manager link in administration tab
    And user clicks on bundle name "Analysis"
    And user clicks on first bundle under Analysis
    And user clicks on Plugin_management in the Bundle details panel
    Then user verifies Plugin Management panel is Displayed
#    And user should be able logoff the IDC

#  @webtest @MLP-3445 @regression @positive @pluginManager
#  Scenario: MLP-3445 Verify that the selected catalog is always shown in plugin management node panel
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And user clicks on Plugin Manager in Administration dashboard
#    And user clicks on Add new node Button in Plugin Management page
#    And user enters the node name "Test Node" in the name field
#    And user select "BigData" from Catalog list
#    And user click save button in Create New Node page
#    And user clicks on "Test Node" from nodes list
#    Then user verifies the catalog selection box is displayed with text "BigData"
#    And user clicks on close button in the panel
#    And user clicks on "Test Node" from nodes list
#    Then user verifies the catalog selection box is displayed with text "BigData"
#    And user clicks on close button in the panel
#    And user clicks on "Test Node" from nodes list
#    And user clicks on Delete button in the Edit Node panel
#    And user clicks on Yes button in alert message
#    And user should be able logoff the IDC

  @MLP-3378 @webtest @regression @dashboard
  Scenario:MLP-3378: Verification of mouse hover of tab should be grey color and height of tabs
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    Then user verifies "Overview" tab is displayed and active in the item full view
    And user mouseover to "Relationships" tab and verifies the underlined color
    And user verifies the tab height as "40"px
    And user should be able logoff the IDC

  @MLP-3475 @webtest @regression @positive @dashboard
  Scenario:MLP-3475: Verification of loading ifame url in via iframe widget
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name as "itemview_TestAttributes" and definition as "Test Attribute View" for the item view
    And user chooses catalog "BigData" in CATALOGS
    And user enters the Supported Type as "Table" for Item View and click add button
    And user clicks on visual composer button
    And user clicks on add button in the Create New Item View panel
    And User drag and drop a "IFRAME WIDGET" widget to the page from the displayed widget sets
    And the user clicks on edit button on the widget
    And user enters the values in the fields under the widget panel
      | fieldName  | fieldValue                                     |
      | LABEL      | IDC                                            |
      | IFRAME URL | https://dechedocker02v.asg.com/IDC/swagger-ui/ |
    And user clicks on the apply buuton in the edit widget panel
    And user enters "TestIFrame" name field of new item view panel dashboad
    And user clicks on set as preview button in Visual composer
    And user clicks on apply button on visual composer
    And user clicks on Save button in the Create New Item View panel
    And user clicks on home button
    And user clicks on Quickstart Dashoboard
    And user selects the BigData catalog from catalog list
    And user clicks on search icon
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user verifies "TestIFrame" tab is displayed and active in the item full view
    And user verifies whether the iframe widget is loaded with swagger login page and it is accessible
    And user clicks on home button
    And user clicks Yes on the alert window
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on "itemview_TestAttributes" from item view list
    And user clicks on Delete button in the  Edit Item View panel
    And user clicks on Yes button in alert message
    And user should be able logoff the IDC

  @webtest @regression @positive @dashboard
  Scenario: Verification of disabling Quality metrics for the item types
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name as "itemview_TestAttributes" and definition as "Test Attribute View" for the item view
    And user chooses catalog "BigData" in CATALOGS
    And user enters the Supported Type as "Table" for Item View and click add button
    And user enters the Supported Type as "Column" for Item View and click add button
    And user clicks on visual composer button
    And user clicks on add button in the Create New Item View panel
    And User drag and drop a "MULTIPLE LINKS WIDGET" widget to the page from the displayed widget sets
    And user clicks on the apply buuton in the edit widget panel
    And user clicks on Save button in the Create New Item View panel
    And user clicks on home button
    And user clicks on Quickstart Dashoboard
    And user selects "BigData" catalog from catalog list
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    Then user should be able to see quality label
    And user clicks on home button
    And user clicks Yes on the alert window
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on "itemview_TestAttributes" from item view list
    And user clicks on "SHOW ITEM QUALITY METRICS" checkbox under Item view header
    And user clicks on Save button in the Create New Item View panel
    And user clicks on home button
    And user clicks on Quickstart Dashoboard
    And user selects "BigData" catalog from catalog list
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user verifies quality label is not present
    And user should be able logoff the IDC

  @webtest @regression @positive @dashboard
  Scenario: Verification of disabling breadcrumbs for the item types
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user selects the "Column" from the Type
    And user clicks on first item on the item list page
    Then breadcrumb items ahould get displayed
    And user clicks on home button
    And user clicks Yes on the alert window
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on "itemview_TestAttributes" from item view list
    And user clicks on "SHOW BREAD CRUMBS" checkbox under Item view header
    And user clicks on Save button in the Create New Item View panel
    And user clicks on home button
    And user clicks on Quickstart Dashoboard
    And user selects "BigData" catalog from catalog list
    And user selects the "Column" from the Type
    And user clicks on first item on the item list page
    And User verifies breadcrumb items are not displayed
    And user clicks on home button
    And user clicks Yes on the alert window
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on "itemview_TestAttributes" from item view list
    And user clicks on Delete button in the  Edit Item View panel
    And user clicks on Yes button in alert message
    And user should be able logoff the IDC

  @webtest @regression @positive @itemview
  Scenario: Verification of fork icon for itemview
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user verifies fork icon displayed near to any existing item view
    And user should be able logoff the IDC

  @MLP-3288 @webtest @regression @positive @subjectAreaManagement
  Scenario: @MLP-3288 Verification of widget list updation
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And User click on Subject Area Manager link on the Dashboard page
    And user clicks on Create Button in Subject Area Management page
    And user enters Name "TestCatalog" and Description of New Subject Area
    And user clicks on save button in New Subject Area page
    And user clicks on home button from Catalog_Management
    And user clicks on Quickstart Dashoboard
    And user clicks on Quickstart Dashoboard
    And User clicks on Edit button
    And User drag and drop a "TestCatalog" widget to the second page from the displayed widget list
    And user clicks on save button on the dashboard
    And Dashboard "QuickStart" should be active TAB
    And user verifies whether the "TestCatalog" widget is displayed in the current tab
    And user clicks on Administration widget
    And User click on Subject Area Manager link on the Dashboard page
    And user clicks on mentioned catalog "TestCatalog" to be deleted
    And user clicks on Delete button in the New Subject Area page
    And user should be able logoff the IDC

  @MLP-3347 @webtest @regression @negative @login
  Scenario: @MLP-3347 Verification of welcome back user message if the user enters wrong credential
    Given User launch browser and traverse to login page
    When user enter credentials for "Invalid Administrator" role
    Then login must be failed and display error message
    And user verifies Welcome back message is not displayed


