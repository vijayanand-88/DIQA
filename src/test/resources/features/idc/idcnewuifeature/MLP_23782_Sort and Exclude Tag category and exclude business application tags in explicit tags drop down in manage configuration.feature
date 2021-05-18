Feature:MLP_23782_Sort and Exclude Tag category and exclude business application tags in explicit tags drop down in manage configuration

      # 7116645
  @MLP-22098@regression @positive
  Scenario Outline:SC_Create BusinessApplication
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                     | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | idc\MLP_22098\NEWBA.json | 200           |                  |          |


  @MLP-23782 @webtest @regression @positive
  Scenario:MLP-23782:SC:Remove  Business Application And Technology protected icon
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And User performs following actions in the Manage Tags Page
      | Actiontype | ActionItem            | ItemName            | Attribute |
      | Click      | Category Menu buttons | BusinessApplication | Protected |
    And user "verifies displayed" on "ProtectedTagPopup" button in "ProtectedTag"
    And user "click" on "Yes" button in "Unsaved changes pop up"
    And User performs following actions in the Manage Tags Page
      | Actiontype | ActionItem            | ItemName   | Attribute |
      | Click      | Category Menu buttons | Technology | Protected |
    And user "verifies displayed" on "ProtectedTagPopup" button in "ProtectedTag"
    And user "click" on "Yes" button in "Unsaved changes pop up"

# 7116495
  @MLP-23782 @webtest @regression @positive
  Scenario:MLP-23782:SC#2_Create Subtag of General Tag
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    Then User performs following actions in the Manage Tags Page
      | Actiontype                     | ActionItem                | ItemName   | Attribute |
      | Verifies Category Menu buttons | General                   | Add,Edit   |           |
      | Click                          | Category Menu buttons     | General    | Add       |
      | Enter Text                     | Category Name             | AWSTag     |           |
      | Click                          | Edit category Save Button |            |           |
      | Verifies Category Menu buttons | General                   | Add,Edit   |           |
      | Click                          | Category Menu buttons     | General    | Add       |
      | Enter Text                     | Category Name             | BecubicTag |           |
      | Click                          | Edit category Save Button |            |           |

 # 7116627
  @MLP-23782 @webtest @regression @positive
  Scenario:MLP-23782:SC#3_Create Subtag of PII Tag
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    Then User performs following actions in the Manage Tags Page
      | Actiontype                     | ActionItem                | ItemName        | Attribute |
      | Verifies Category Menu buttons | PII                       | Add,Edit,Delete |           |
      | Click                          | Category Menu buttons     | PII             | Add       |
      | Enter Text                     | Category Name             | sampletest      |           |
      | Click                          | Edit category Save Button |                 |           |
      | Verifies Category Menu buttons | PII                       | Add             |           |

# 7116629# 7105752
  @MLP-23782 @webtest @regression @positive
  Scenario:MLP-23782:SC#4_Create Subtag of Technology Tag
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And User performs following actions in the Manage Tags Page
      | Actiontype                     | ActionItem                | ItemName   | Attribute |
      | Click                          | Category Menu buttons     | Technology | Add       |
      | Enter Text                     | Category Name             | testTags   |           |
      | Click                          | Edit category Save Button |            |           |
      | Verifies Category Menu buttons | Technology                | Add        |           |

# 7105755
  @MLP-21981 @regression @positive
  Scenario Outline: SC#5_Create TagSort and subTags "A" and "B"
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                     | body                                               | response code | response message | filePath | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Put  | tags/Default/structures | payloads\idc\MLP-23782\BusinessApplicationTag.json | 200           |                  |          |          |

# 7116496# 7116491
  @MLP-23782 @webtest @regression @positive
  Scenario:MLP-21981:SC#6_Verify Tag "A" is Available in Tag Dropdown Values in Add Configuration of Manage Configuration
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute    |
      | Type      | Collector    |
      | Plugin    | GitCollector |
    And user "verify displayed" on "AdvanceSettingsExpand" button under "LocalNode" in Manage Configurations
    And user "click" on "Show Advanced Settings" button under "LocalNode" in Manage Configurations
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName  | attribute |
      | Enter tags | A         |
    Then user "verifies presence" of following "AddConfigurationTags" in "Manage Tags" page
      | A      |
      | AWSTag |

# 7116493
  @MLP-23782 @webtest @regression @positive
  Scenario:MLP-21981:SC#7_Verify Tag "B" is Available in Tag Dropdown Values in Add Configuration of Manage Configuration
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute    |
      | Type      | Collector    |
      | Plugin    | GitCollector |
    And user "verify displayed" on "AdvanceSettingsExpand" button under "LocalNode" in Manage Configurations
    And user "click" on "Show Advanced Settings" button under "LocalNode" in Manage Configurations
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName  | attribute |
      | Enter tags | B         |
    Then user "verifies presence" of following "AddConfigurationTags" in "Manage Tags" page
      | B          |
      | BecubicTag |

# 7105753
  @MLP-23782 @webtest @regression @positive
  Scenario:MLP-23782:SC#8_Verify Tags dropdown values are sorted in alphabetical order
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute    |
      | Type      | Collector    |
      | Plugin    | GitCollector |
    And user "verify displayed" on "AdvanceSettingsExpand" button under "LocalNode" in Manage Configurations
    And user "click" on "Show Advanced Settings" button under "LocalNode" in Manage Configurations
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName  | attribute |
      | Enter tags | A         |
    Then user "verifies sorting order" of following "Tags Are in Ascending Order" in "Add Configuration" page
      |  |

    # 7116497
  @MLP-23782 @webtest @regression @positive
  Scenario:MLP-21981:SC#9_ Verify nonPresene of "TechnologyTag" in Enter Tags of Advance Settings in Add Configuration
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute    |
      | Type      | Collector    |
      | Plugin    | GitCollector |
    And user "verify displayed" on "AdvanceSettingsExpand" button under "LocalNode" in Manage Configurations
    And user "click" on "Show Advanced Settings" button under "LocalNode" in Manage Configurations
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName  | attribute |
      | Enter tags | testTags  |
    Then user "verify non presence" of following "EnterTagsAddConfigurations" in "Add Configuration" Page
      | testTags |


  @MLP-23782 @webtest @regression @positive
  Scenario:MLP-21981:SC#10_Verify nonPresene of "PIITag" in Enter Tags of Advance Settings in Add Configuration
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute    |
      | Type      | Collector    |
      | Plugin    | GitCollector |
    And user "verify displayed" on "AdvanceSettingsExpand" button under "LocalNode" in Manage Configurations
    And user "click" on "Show Advanced Settings" button under "LocalNode" in Manage Configurations
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName  | attribute  |
      | Enter tags | sampletest |
    Then user "verify non presence" of following "EnterTagsAddConfigurations" in "Add Configuration" Page
      | sampletest |

# 7116524
  @MLP-23782 @webtest @regression @positive
  Scenario:MLP-21981:SC#11_Verify nonPresene of "BusinessApplicationTag" in Enter Tags of Advance Settings in Add Configuration
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute    |
      | Type      | Collector    |
      | Plugin    | GitCollector |
    And user "verify displayed" on "AdvanceSettingsExpand" button under "LocalNode" in Manage Configurations
    And user "click" on "Show Advanced Settings" button under "LocalNode" in Manage Configurations
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName  | attribute     |
      | Enter tags | BA_ManageTags |
    Then user "verify non presence" of following "EnterTagsAddConfigurations" in "Add Configuration" Page
      | BA_ManageTags |

# 7116538
  @MLP-23782 @webtest @regression @positive
  Scenario:MLP-21981:SC#12_Verify nonPresene of "BusiessApplication" in Enter Tags of Advance Settings in Add Configuration
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute    |
      | Type      | Collector    |
      | Plugin    | GitCollector |
    And user "verify displayed" on "AdvanceSettingsExpand" button under "LocalNode" in Manage Configurations
    And user "click" on "Show Advanced Settings" button under "LocalNode" in Manage Configurations
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName  | attribute           |
      | Enter tags | BusinessApplication |
    Then user "verify non presence" of following "EnterTagsAddConfigurations" in "Add Configuration" Page
      | BusinessApplication |

    # 7116539
  @MLP-23782 @webtest @regression @positive
  Scenario:MLP-21981:SC#13_ Verify nonPresene of "PII" in Enter Tags of Advance Settings in Add Configuration
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute    |
      | Type      | Collector    |
      | Plugin    | GitCollector |
    And user "verify displayed" on "AdvanceSettingsExpand" button under "LocalNode" in Manage Configurations
    And user "click" on "Show Advanced Settings" button under "LocalNode" in Manage Configurations
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName  | attribute |
      | Enter tags | PII       |
    Then user "verify non presence" of following "EnterTagsAddConfigurations" in "Add Configuration" Page
      | PII |

    # 7116541
  @MLP-23782 @webtest @regression @positive
  Scenario:MLP-21981:SC#14_Verify nonPresene of "Technology" in Enter Tags of Advance Settings in Add Configuration
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute    |
      | Type      | Collector    |
      | Plugin    | GitCollector |
    And user "verify displayed" on "AdvanceSettingsExpand" button under "LocalNode" in Manage Configurations
    And user "click" on "Show Advanced Settings" button under "LocalNode" in Manage Configurations
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName  | attribute  |
      | Enter tags | Technology |
    Then user "verify non presence" of following "EnterTagsAddConfigurations" in "Add Configuration" Page
      | Technology |

    # 7105757
  @MLP-23782 @webtest @regression @positive
  Scenario:MLP-21981:SC#15_ Verify Tag "TagSort" is not Available in Tag Dropdown Values in Add Configuration of Manage Configuration
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute    |
      | Type      | Collector    |
      | Plugin    | GitCollector |
    And user "verify displayed" on "AdvanceSettingsExpand" button under "LocalNode" in Manage Configurations
    And user "click" on "Show Advanced Settings" button under "LocalNode" in Manage Configurations
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName  | attribute |
      | Enter tags | TagSort   |
    Then user "verify non presence" of following "EnterTagsAddConfigurations" in "Add Configuration" Page
      | TagSort |

  @MLP-23782 @webtest @regression @positive
  Scenario:MLP-23782:SC:Revert Technology Tags
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And User performs following actions in the Manage Tags Page
      | Actiontype | ActionItem            | ItemName            | Attribute |
      | Click      | Category Menu buttons | BusinessApplication | Edit      |
    And user "click" on "ProtectedCheckBox" for "Manage Tags" in "Landing page"
    And user "click" on "Save" for "Manage Tags" in "Landing page"
    And User performs following actions in the Manage Tags Page
      | Actiontype | ActionItem            | ItemName   | Attribute |
      | Click      | Category Menu buttons | Technology | Edit      |
    And user "click" on "ProtectedCheckBox" for "Manage Tags" in "Landing page"
    And user "click" on "Save" for "Manage Tags" in "Landing page"
    And user "verifies protected lock icon" of following "Tags" in "Manage Tags" Page
      | BusinessApplication |
      | Technology          |


  Scenario:Delete the Tag
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name          | type                | query | param |
      | SingleItemDelete | Default | TagSort       | Tag                 |       |       |
      | SingleItemDelete | Default | BA_ManageTags | BusinessApplication |       |       |
      | SingleItemDelete | Default | sampletest    | Tag                 |       |       |
      | SingleItemDelete | Default | testTags      | Tag                 |       |       |
      | SingleItemDelete | Default | A             | Tag                 |       |       |
      | SingleItemDelete | Default | B             | Tag                 |       |       |
      | SingleItemDelete | Default | BecubicTag    | Tag                 |       |       |
      | SingleItemDelete | Default | AWSTag        | Tag                 |       |       |


