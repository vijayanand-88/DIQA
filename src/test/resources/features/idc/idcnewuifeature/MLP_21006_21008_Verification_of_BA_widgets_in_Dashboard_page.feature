@MLP-21006 @MLP-21008 @MLP-21009 @MLP-21010 @MLP-21499 @MLP-21299 @30050
Feature:MLP-21006 MLP-21008: This feature is to verify the Add Widget Business Appications with Trust Score, AWS Inventry and Redshift widgets in Dashboard

  ##7047944##7047946##7057062##
  @MLP-21006 @webtest @regression @positive
  Scenario: SC#1:MLP-21006: Verify the user is able to add the Business Applications Trust Score widget in create and Edit dashboard
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "Create Item" in Create new item page
      | fieldName           | attribute | option        |
      | BusinessApplication | SampleBA  | Save and Open |
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And user "click" on "Dashboard page Icons" for "Add Dashboard" in "Landing page"
    And user "enter text" in "Landing Page"
      | fieldName      | actionItem   |
      | Dashboard Name | BA Dashboard |
    And user "click" in "Landing Page"
      | fieldName                   | actionItem    | itemName                               |
      | Select preconfigured Widget | Table Widgets | Business Applications with Trust Score |
    And user "click" on "Dashboard toolbar Icon" for "Save Dashboard" in "Landing page"
    And user "verifies presence" of following "BA Trust score widget Columns" in "Dashboard" page
      | Name        |
      | Trust Score |
    And user "click" on "Dashboard page Icons" for "Configure" in "Landing page"
    And user "click" on "Widget Remove Icon" for "Business Applications with Trust Score" in "Dashboard page"
    And user verifies the "Delete Widget" pop up is "displayed"
    And user "click" on "DELETE" button in "Unsaved changes pop up"
    And user "click" on "Dashboard toolbar Icon" for "Save Dashboard" in "Landing page"
    And user "verifies widgets absence" in "Dashboard Page"
      | fieldName                              |
      | Business Applications with Trust Score |

    ##7042553##
  @MLP-21008 @webtest @regression @positive
  Scenario: SC#2: MLP-21008: Verify the user is able is configure a Application by Business Criticality widget while creating dashboard
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And user "click" on "Dashboard page Icons" for "Add Dashboard" in "Landing page"
    And user "enter text" in "Landing Page"
      | fieldName      | actionItem       |
      | Dashboard Name | TestBA Dashboard |
    And user "click" in "Landing Page"
      | fieldName                   | actionItem    | itemName                            |
      | Select preconfigured Widget | Chart Widgets | Application by Business Criticality |
    And user "click" on "Dashboard toolbar Icon" for "Save Dashboard" in "Landing page"
    And user "verifies widgets" in "Dashboard Page"
      | fieldName                           |
      | Application by Business Criticality |
    And user "click" on "Dashboard page Icons" for "Configure" in "Landing page"
    And user "click" on "Widget Remove Icon" for "Application by Business Criticality" in "Dashboard page"
    And user verifies the "Delete Widget" pop up is "displayed"
    And user "click" on "DELETE" button in "Unsaved changes pop up"
    And user "click" on "Dashboard toolbar Icon" for "Save Dashboard" in "Landing page"
    And user "verifies widgets absence" in "Dashboard Page"
      | fieldName                           |
      | Application by Business Criticality |

    ##7042555##7042556##7042559##
  @MLP-21008 @webtest @regression @positive
  Scenario: SC#3: MLP-21008: Verify the user is able is configure a Application by Business Criticality widget while editing dashboard
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And user "click" on "Dashboard dropdown" button in "Dashboard page"
    And user "click" on "Dashboard list" for "TestBA Dashboard" in "Dashboard page"
    And user "click" on "Dashboard page Icons" for "Configure" in "Landing page"
    And user "click" in "Landing Page"
      | fieldName                   | actionItem    | itemName                            |
      | Select preconfigured Widget | Chart Widgets | Application by Business Criticality |
    And user "click" on "Dashboard toolbar Icon" for "Save Dashboard" in "Landing page"
    And user "verifies widgets" in "Dashboard Page"
      | fieldName                           |
      | Application by Business Criticality |
    And user "verify Widget type" in "Landing Page"
      | fieldName                           | actionItem |
      | Application by Business Criticality | pie-chart  |
    And user "click" on "Dashboard page Icons" for "Configure" in "Landing page"
    And user "click" on "Widget Remove Icon" for "Application by Business Criticality" in "Dashboard page"
    And user verifies the "Delete Widget" pop up is "displayed"
    And user "click" on "DELETE" button in "Unsaved changes pop up"
    And user "click" on "Dashboard toolbar Icon" for "Save Dashboard" in "Landing page"
    And user "verifies widgets absence" in "Dashboard Page"
      | fieldName                           |
      | Application by Business Criticality |

    ##7047947##
  @MLP-21008 @webtest @regression @positive
  Scenario: SC#4: MLP-21008: verify the Trust score is updated when there is a change in the trust sore
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And user "verify trust score" in "Dashboard Page"
      | fieldName                              | actionItem | itemName |
      | Business Applications with Trust Score | SampleBA   | .00      |
    And user enters the search text "SampleBA" and clicks on search
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem            |
      | Click      | Item view Edit Button |
    And user "select BA Attributes dropdown" in "Item View page"
      | fieldName            | actionItem |
      | Business Criticality | High       |
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem            |
      | Click      | Item view Save Button |
    And user refreshes the application
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And user "verify trust score" in "Landing Page"
      | fieldName                              | actionItem | itemName |
      | Business Applications with Trust Score | SampleBA   | 8.57     |

  ##7047684##7047685##7047686##
  @MLP-21299 @webtest @regression @positive
  Scenario: SC#5: MLP-21299: Verify the user is able to view the BA as link in BA Trust Score widget of Dashboard page
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And user "click" on "Dashboard page Icons" for "Add Dashboard" in "Landing page"
    And user "enter text" in "Landing Page"
      | fieldName      | actionItem   |
      | Dashboard Name | BA Dashboard |
    And user "click" in "Landing Page"
      | fieldName                   | actionItem    | itemName                               |
      | Select preconfigured Widget | Table Widgets | Business Applications with Trust Score |
    And user "verify trust score" in "Landing Page"
      | fieldName                              | actionItem | itemName |
      | Business Applications with Trust Score | SampleBA   | 8.57     |
    And user "click" on "Business Applications with Trust Score BA Item" for "SampleBA" in "Dashboard Page"
    And user verifies "New tab opened" for "Business Applications with Trust Score BA Item is clicked" in Item view page

  ##7050529##7050530##
  @MLP-21499 @webtest @regression @positive
  Scenario: SC#6: MLP-21499: Verify the user is able to sort the columns in Table widgets by clicking the table column header name
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And user "click" on "Dashboard page Icons" for "Add Dashboard" in "Landing page"
    And user "enter text" in "Landing Page"
      | fieldName      | actionItem   |
      | Dashboard Name | BA Dashboard |
    And user "click" in "Landing Page"
      | fieldName                   | actionItem    | itemName                               |
      | Select preconfigured Widget | Table Widgets | Business Applications with Trust Score |
    And user "click" on "Table Widget Sort Icon" button in "Business Applications with Trust Score widget column"
    And user "verifies sorting order" of following "BA with Trust Score widget are in ascending order" in "Dashboard" page
      |  |
    And user "click" on "Table Widget Sort Icon" button in "Business Applications with Trust Score widget column"
    And user "verifies sorting order" of following "BA with Trust Score widget are in desending order" in "Dashboard" page
      |  |

   ##7050531##7050534##7050535##
  @MLP-21499 @webtest @regression @positive
  Scenario: SC#7: MLP-21499: Verify the user is able to sort the "Most Used Tags" columns in the widgets
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And user "click" on "Dashboard page Icons" for "Add Dashboard" in "Landing page"
    And user "enter text" in "Landing Page"
      | fieldName      | actionItem   |
      | Dashboard Name | BA Dashboard |
    And user "click" in "Landing Page"
      | fieldName                   | actionItem    | itemName       |
      | Select preconfigured Widget | Table Widgets | Most Used Tags |
    And user "click" on "Table Widget Sort Icon" button in "Most Used Tags widget column"
    And user "verifies sorting order" of following "Most Used Tags widget are in ascending order" in "Dashboard" page
      |  |
    And user "click" on "Table Widget Sort Icon" button in "Most Used Tags widget column"
    And user "verifies sorting order" of following "Most Used Tags widget are in desending order" in "Dashboard" page
      |  |

    ##7050532##
  @MLP-21499 @webtest @regression @positive
  Scenario: SC#8: MLP-21499: Verify the user is able to sort the "Least Used Tags" columns in the widgets
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And user "click" on "Dashboard page Icons" for "Add Dashboard" in "Landing page"
    And user "enter text" in "Landing Page"
      | fieldName      | actionItem   |
      | Dashboard Name | BA Dashboard |
    And user "click" in "Landing Page"
      | fieldName                   | actionItem    | itemName        |
      | Select preconfigured Widget | Table Widgets | Least Used Tags |
    And user "click" on "Table Widget Sort Icon" button in "Least Used Tags widget column"
    And user "verifies sorting order" of following "Least Used Tags widget are in ascending order" in "Dashboard" page
      |  |
    And user "click" on "Table Widget Sort Icon" button in "Least Used Tags widget column"
    And user "verifies sorting order" of following "Least Used Tags widget are in desending order" in "Dashboard" page
      |  |

    ##7050533##
  @MLP-21499 @webtest @regression @positive
  Scenario: SC#9: MLP-21499: Verify the user is able to sort the "Number of Tags for each Category" columns in the widgets
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And user "click" on "Dashboard page Icons" for "Add Dashboard" in "Landing page"
    And user "enter text" in "Landing Page"
      | fieldName      | actionItem   |
      | Dashboard Name | BA Dashboard |
    And user "click" in "Landing Page"
      | fieldName                   | actionItem    | itemName                         |
      | Select preconfigured Widget | Table Widgets | Number of Tags for each Category |
    And user "click" on "Table Widget Sort Icon" button in "Number of Tags for each Category widget column"
    And user "verifies sorting order" of following "Number of Tags for each Category widget are in ascending order" in "Dashboard" page
      |  |
    And user "click" on "Table Widget Sort Icon" button in "Number of Tags for each Category widget column"
    And user "verifies sorting order" of following "Number of Tags for each Category widget are in desending order" in "Dashboard" page
      |  |

        ##7047687##
  @MLP-21009 @webtest @regression @positive
  Scenario: SC#10: MLP-21009: Verify the user is able to configure the AWS S3 Inventory widget in edit and create dashboard page
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And user "click" on "Dashboard page Icons" for "Add Dashboard" in "Landing page"
    And user "enter text" in "Landing Page"
      | fieldName      | actionItem     |
      | Dashboard Name | Test Dashboard |
    And user "click" in "Landing Page"
      | fieldName                   | actionItem    | itemName         |
      | Select preconfigured Widget | Chart Widgets | AWS S3 Inventory |
    And user "click" on "Dashboard toolbar Icon" for "Save Dashboard" in "Landing page"

  @MLP-20549 @aws
  Scenario: Update AWS secret key and access from config file
    Given User update the below "aws credentials" in following files using json path
      | filePath                                                       | accessKeyPath                    | secretKeyPath                    |
      | idc/IDx_DataSource_Credentials_Payloads/amazonCredentials.json | $.awsValidCredentials..accessKey | $.awsValidCredentials..secretKey |

  @MLP-20549 @aws
  Scenario: Update AWS username and password from config file
    Given User update the below "redshift credentials" in following files using json path
      | filePath                                                       | username                             | password                             |
      | idc/IDx_DataSource_Credentials_Payloads/amazonCredentials.json | $.redshiftValidCredentials..userName | $.redshiftValidCredentials..password |

  Scenario: MLP-21009: Create a bucket and folder with various file formats in S3 Amazon storage
    Given user "Create" a bucket "asgtestautomationbucket" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName              | keyPrefix                | dirPath                                 | recursive |
      | asgtestautomationbucket | AutoTestData/TestFolder1 | ida/amazonPayloads/TestData/TestFolder1 | true      |

  @aws
  Scenario: MLP-21009:Delete the Credentials
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                       | body | response code | response message | jsonPath | endpointType | itemName |
      | application/json | raw   | false | Delete | settings/credentials/AWS_S3Credentials    |      |               |                  |          |              |          |
      |                  |       |       | Delete | settings/credentials/Redshift_Credentials |      |               |                  |          |              |          |

  @aws
  Scenario Outline: Set the Credentials for Redshift and amazons3 Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                         | bodyFile                                                                     | path                       | response code | response message   | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/AWS_S3Credentials      | payloads/idc/IDx_DataSource_Credentials_Payloads/amazonCredentials.json      | $.awsValidCredentials      | 200           |                    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/Redshift_Credentials   | payloads/idc/IDx_DataSource_Credentials_Payloads/amazonCredentials.json      | $.redshiftValidCredentials | 200           |                    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/AmazonS3DataSource       | payloads/idc/IDx_DataSource_Credentials_Payloads/AmazonDataSourceConfig.json | $.AmazonS3DataSource       | 204           |                    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/AmazonS3DataSource       |                                                                              |                            | 200           | AmazonS3DataSource |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/AmazonRedshiftDataSource | payloads/idc/IDx_DataSource_Credentials_Payloads/AmazonDataSourceConfig.json | $.RedshiftDataSource       | 204           |                    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/AmazonRedshiftDataSource |                                                                              |                            | 200           | RedshiftDataSource |          |

  @MLp-21009 @sanity @positive @regression
  Scenario Outline: Run AmazonS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | bodyFile                                                | path                | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                | payloads/idc/IDX_PluginPayloads/AmazonPluginConfig.json | $.AmazonS3Cataloger | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AmazonS3Cataloger                                |                                                         |                     | 200           | AmazonS3Catalog  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                         |                     | 200           | IDLE             | $.[?(@.configurationName=='AmazonS3Catalog')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*  |                                                         |                     | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                         |                     | 200           | IDLE             | $.[?(@.configurationName=='AmazonS3Catalog')].status |

  ##7047688##
  @MLP-21009 @webtest @regression @positive
  Scenario: SC#11: MLP-21009: Verify the AWS S3 Inventory widget is displayed with horizontal Bar chart
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And user "click" on "Dashboard dropdown" button in "Dashboard page"
    And user "click" on "Dashboard list" for "Test Dashboard" in "Dashboard page"
    And user "verifies widgets" in "Dashboard Page"
      | fieldName        |
      | AWS S3 Inventory |
    And user "verify Widget chart type" in "Landing Page"
      | fieldName        | actionItem |
      | AWS S3 Inventory | bar        |

  ##7064242##7064243##7064244##7047689##
  @MLP-22136 @webtest @regression @positive
  Scenario: SC#12: MLP-22136: Verify the Vertical Bar chart for AWS S3 Inventory widget
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And user "click" on "Dashboard dropdown" button in "Dashboard page"
    And user "click" on "Dashboard list" for "Test Dashboard" in "Dashboard page"
    And user "verifies widgets" in "Dashboard Page"
      | fieldName        |
      | AWS S3 Inventory |
    And user "click" on "Dashboard page Icons" for "Configure" in "Dashboard page"
    And user "click" on "Widget settings Icon" for "AWS S3 Inventory" in "Dashboard page"
    And user "Select dropdown in Dashboard Config" in "Dashboard Page"
      | fieldName       | actionItem         |
      | Widget Sub Type | Vertical Bar Chart |
    And user "click" on "SAVE" button in "Widget edit page"
    And user "verify Widget chart type" in "Landing Page"
      | fieldName        | actionItem |
      | AWS S3 Inventory | bar        |
    And user "click" on "Widget settings Icon" for "AWS S3 Inventory" in "Dashboard page"
    And user "Select dropdown in Dashboard Config" in "Dashboard Page"
      | fieldName       | actionItem     |
      | Widget Sub Type | Pie Chart Grid |
    And user "click" on "SAVE" button in "Widget edit page"
    And user "verify Widget chart type" in "Landing Page"
      | fieldName        | actionItem     |
      | AWS S3 Inventory | pie-grid chart |
    And user "click" on "Widget settings Icon" for "AWS S3 Inventory" in "Dashboard page"
    And user "Select dropdown in Dashboard Config" in "Dashboard Page"
      | fieldName       | actionItem         |
      | Widget Sub Type | Pie Chart Advanced |
    And user "click" on "SAVE" button in "Widget edit page"
    And user "verify Widget chart type" in "Landing Page"
      | fieldName        | actionItem         |
      | AWS S3 Inventory | advanced-pie chart |
    And user "click" on "Widget Remove Icon" for "AWS S3 Inventory" in "Dashboard page"
    And user verifies the "Delete Widget" pop up is "displayed"
    And user "click" on "DELETE" button in "Delete Widget"
    And user "click" on "Dashboard toolbar Icon" for "Save Dashboard" in "Landing page"
    And user "verifies widgets absence" in "Dashboard Page"
      | fieldName        |
      | AWS S3 Inventory |

  @aws
  Scenario:SC1#Delete the version bucket in Amazon S3 storage
    Given user "Delete" objects in amazon directory "AutoTestData" in bucket "asgtestautomationbucket"
    Then user "Delete" a bucket "asgtestautomationbucket" in amazon storage service

  ##7047690##
  @MLP-21009 @webtest @regression @positive
  Scenario: SC#13: MLP-21009: Verify the user is able to configure the AWS S3 Inventory widget in edit and create dashboard page
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And user "click" on "Dashboard page Icons" for "Add Dashboard" in "Landing page"
    And user "enter text" in "Landing Page"
      | fieldName      | actionItem         |
      | Dashboard Name | TestAuto Dashboard |
    And user "click" in "Landing Page"
      | fieldName                   | actionItem    | itemName               |
      | Select preconfigured Widget | Chart Widgets | AWS Redshift Inventory |
    And user "click" on "Dashboard toolbar Icon" for "Save Dashboard" in "Landing page"

  @MLP-21009 @sanity @positive @regression
  Scenario Outline: Run AmazonRedshift
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                       | bodyFile                                                | path                      | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger                                | payloads/idc/IDX_PluginPayloads/AmazonPluginConfig.json | $.AmazonRedshiftCataloger | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AmazonRedshiftCataloger                                |                                                         |                           | 200           | RedShiftCataloger |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/* |                                                         |                           | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/*  |                                                         |                           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/* |                                                         |                           | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |

  ##7047691##
  @MLP-21009 @webtest @regression @positive
  Scenario: SC#14: MLP-21009: Verify the AWS Redshift Inventory widget is displayed with horizontal Bar chart
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And user "click" on "Dashboard dropdown" button in "Dashboard page"
    And user "click" on "Dashboard list" for "TestAuto Dashboard" in "Dashboard page"
    And user "verifies widgets" in "Dashboard Page"
      | fieldName              |
      | AWS Redshift Inventory |
    And user "verify Widget chart type" in "Landing Page"
      | fieldName              | actionItem |
      | AWS Redshift Inventory | bar        |

    ##7064245##7064246##7064247##7047692##
  @MLP-22136 @webtest @regression @positive
  Scenario: SC#15: MLP-22136: Verify the Vertical Bar chart for AWS Redshift Inventory widget
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And user "click" on "Dashboard dropdown" button in "Dashboard page"
    And user "click" on "Dashboard list" for "TestAuto Dashboard" in "Dashboard page"
    And user "verifies widgets" in "Dashboard Page"
      | fieldName              |
      | AWS Redshift Inventory |
    And user "click" on "Dashboard page Icons" for "Configure" in "Dashboard page"
    And user "click" on "Widget settings Icon" for "AWS Redshift Inventory" in "Dashboard page"
    And user "Select dropdown in Dashboard Config" in "Dashboard Page"
      | fieldName       | actionItem         |
      | Widget Sub Type | Vertical Bar Chart |
    And user "click" on "SAVE" button in "Widget edit page"
    And user "verify Widget chart type" in "Landing Page"
      | fieldName              | actionItem |
      | AWS Redshift Inventory | bar        |
    And user "click" on "Widget settings Icon" for "AWS Redshift Inventory" in "Dashboard page"
    And user "Select dropdown in Dashboard Config" in "Dashboard Page"
      | fieldName       | actionItem     |
      | Widget Sub Type | Pie Chart Grid |
    And user "click" on "SAVE" button in "Widget edit page"
    And user "verify Widget chart type" in "Landing Page"
      | fieldName              | actionItem     |
      | AWS Redshift Inventory | pie-grid chart |
    And user "click" on "Widget settings Icon" for "AWS Redshift Inventory" in "Dashboard page"
    And user "Select dropdown in Dashboard Config" in "Dashboard Page"
      | fieldName       | actionItem         |
      | Widget Sub Type | Pie Chart Advanced |
    And user "click" on "SAVE" button in "Widget edit page"
    And user "verify Widget chart type" in "Landing Page"
      | fieldName              | actionItem         |
      | AWS Redshift Inventory | advanced-pie chart |
    And user "click" on "Widget Remove Icon" for "AWS Redshift Inventory" in "Dashboard page"
    And user verifies the "Delete Widget" pop up is "displayed"
    And user "click" on "DELETE" button in "Delete Widget"
    And user "click" on "Dashboard toolbar Icon" for "Save Dashboard" in "Landing page"
    And user "verifies widgets absence" in "Dashboard Page"
      | fieldName              |
      | AWS Redshift Inventory |
    And user "click" on "Dashboard page Icons" for "Configure" in "Landing page"
    And user "click" on "Dashboard toolbar Icon" for "Remove Dashboard" in "Landing page"
    And user "click" on "DELETE" button in "Delete dashboard popup"
    And user "click" on "Dashboard dropdown" button in "Dashboard page"
    And user "verifies dashboard absence in dropdown" in "Dashboard Page"
      | fieldName          |
      | TestAuto Dashboard |

  ##7058461##7073647##
  @MLP-21614 @webtest @regression @positive
  Scenario: SC#16: MLP-21614: Verify the Default Dashboard has following widgets as default 1. Count of Business Application 2. count of Data Elements 3. Application by Business Criticality 4. Business Application with Trust Score 5.Category of tags and their count (Table)
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And user "verifies widgets" in "Dashboard Page"
      | fieldName                              |
      | Business Applications                  |
      | Application by Business Criticality    |
      | Business Applications with Trust Score |
      | Number of Tags for each Category       |

    ##7046159##7046162##7046164##
  @MLP-21614 @webtest @regression @positive
  Scenario: SC#17: MLP-21614: Verify the user is able to view the BA as link in BA Trust Score widget of Dashboard page
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And user "click" on "Dashboard page Icons" for "Add Dashboard" in "Landing page"
    And user "enter text" in "Landing Page"
      | fieldName      | actionItem        |
      | Dashboard Name | BA Test Dashboard |
    And user "click" in "Landing Page"
      | fieldName                   | actionItem    | itemName                               |
      | Select preconfigured Widget | Table Widgets | Business Applications with Trust Score |
    And user "click" on "Dashboard toolbar Icon" for "Save Dashboard" in "Landing page"
    And user "verify trust score" in "Landing Page"
      | fieldName                              | actionItem | itemName |
      | Business Applications with Trust Score | SampleBA   | 8.57     |
    And user "click" on "Business Applications with Trust Score BA Item" for "SampleBA" in "Dashboard Page"
    And user verifies "New tab opened" is "displayed"

  ##7073646####7073648##7073649##7073650##7073651##7073652##
  @MLP-22428 @webtest @regression @positive
  Scenario: SC#18: MLP-22428: Verify the Application by Business Criticality is changed to Business Criticality widget
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And user "click" on "Dashboard page Icons" for "Add Dashboard" in "Landing page"
    And user "click" on "Dashboard page Icons" for "Add Widget" in "Dashboard page"
    And user "click" on "Dashboard widget type" for "Chart Widgets" in "Dashboard page"
    And user "verifies absence" of following "preconfigured widget" in "Dashboard" page
      | Business application status |
    And user "click" on "Select widget panel close" button in "Dashboard page"
    And user "click" in "Landing Page"
      | fieldName                   | actionItem    | itemName                            |
      | Select preconfigured Widget | Chart Widgets | Application by Business Criticality |
    And user "click" on "Widget settings Icon" for "Application by Business Criticality" in "Dashboard page"
    And user "Select dropdown in Dashboard Config" in "Dashboard Page"
      | fieldName       | actionItem           |
      | Widget Sub Type | Horizontal Bar Chart |
    And user "click" on "SAVE" button in "Widget edit page"
    And user "verify Widget chart type" in "Landing Page"
      | fieldName                           | actionItem |
      | Application by Business Criticality | bar        |
    And user "click" on "Widget settings Icon" for "Application by Business Criticality" in "Dashboard page"
    And user "Select dropdown in Dashboard Config" in "Dashboard Page"
      | fieldName       | actionItem         |
      | Widget Sub Type | Vertical Bar Chart |
    And user "click" on "SAVE" button in "Widget edit page"
    And user "verify Widget chart type" in "Landing Page"
      | fieldName                           | actionItem |
      | Application by Business Criticality | bar        |
    And user "click" on "Widget settings Icon" for "Application by Business Criticality" in "Dashboard page"
    And user "Select dropdown in Dashboard Config" in "Dashboard Page"
      | fieldName       | actionItem |
      | Widget Sub Type | Pie Chart  |
    And user "click" on "SAVE" button in "Widget edit page"
    And user "verify Widget chart type" in "Landing Page"
      | fieldName                           | actionItem |
      | Application by Business Criticality | arc        |
    And user "click" on "Widget settings Icon" for "Application by Business Criticality" in "Dashboard page"
    And user "Select dropdown in Dashboard Config" in "Dashboard Page"
      | fieldName       | actionItem     |
      | Widget Sub Type | Pie Chart Grid |
    And user "click" on "SAVE" button in "Widget edit page"
    And user "verify Widget chart type" in "Landing Page"
      | fieldName                           | actionItem     |
      | Application by Business Criticality | pie-grid chart |
    And user "click" on "Widget settings Icon" for "Application by Business Criticality" in "Dashboard page"
    And user "Select dropdown in Dashboard Config" in "Dashboard Page"
      | fieldName       | actionItem         |
      | Widget Sub Type | Pie Chart Advanced |
    And user "click" on "SAVE" button in "Widget edit page"
    And user "verify Widget chart type" in "Landing Page"
      | fieldName                           | actionItem         |
      | Application by Business Criticality | advanced-pie chart |

  @jdbc
  Scenario: Delete Plugin Configuration
    Given  Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                         | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/AmazonRedshiftCataloger  |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/AmazonS3Cataloger        |      | 204           |                  |          |
      |                  |       |       | Delete | settings/credentials/AWS_S3Credentials      |      | 204           |                  |          |
      |                  |       |       | Delete | settings/credentials/Redshift_Credentials   |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/AmazonS3DataSource       |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/AmazonRedshiftDataSource |      | 204           |                  |          |

    ##7266613##7266614##7266615##7266616##7266617##7266618##7266619##7266620##
  @MLP-30050 @webtest @regression @positive
  Scenario: SC#1: MLP-30050: Verify clicking on tab button or skipping the Name field should display the validation message ' Please enter the dashboard name' in the Add Dashboard page
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Dashboard" in "Dashboard page"
    And user "click" on "Dashboard page Icons" for "Add Dashboard" in "Landing page"
    And user verifies "Save Dashboard" is "disabled"
    And user "Verify Dashboard Validation text" in "Landing Page"
      | fieldName      | actionItem                      |
      | Dashboard Name | Please enter the dashboard name |
    And user "enter text" in "Landing Page"
      | fieldName      | actionItem         |
      | Dashboard Name | TestDemo Dashboard |
    And user "click" on "Dashboard toolbar Icon" for "Save Dashboard" in "Landing page"
    And user "click" on "Dashboard page Icons" for "Configure" in "Dashboard page"
    And user verifies "Save Dashboard" is "enabled"
    And user "Verify Dashboard Validation text" in "Landing Page"
      | fieldName      | actionItem                      | itemName |
      | Dashboard Name | Please enter the dashboard name |          |
    And user "Forbidden validation message" in "Landing Page"
      | fieldName      | actionItem                                                                   | itemName       |
      | Dashboard Name | Invalid name. Leading/trailing blanks, '/' and '\' characters are forbidden. | Leading Space  |
      | Dashboard Name | Invalid name. Leading/trailing blanks, '/' and '\' characters are forbidden. | Trailing Space |
      | Dashboard Name | Invalid name. Leading/trailing blanks, '/' and '\' characters are forbidden. | Forward Slash  |
      | Dashboard Name | Invalid name. Leading/trailing blanks, '/' and '\' characters are forbidden. | Backward Slash |
    And user "enter text" in "Landing Page"
      | fieldName      | actionItem                                                                                                                                                               |
      | Dashboard Name | TestDashboardWithLenghtyNameTestDashboardWithLenghtyNameTestDashboardWithLenghtyNameTestDashboardWithLenghtyNameTestDashboardWithLenghtyNameTestDashboardWithLenghtyName |
    And user "click" on "Dashboard toolbar Icon" for "Save Dashboard" in "Landing page"
    And user verifies "Dashboard Ellipsis" is "displayed"

  @regression @positive
  Scenario: Delete Dashboards
    Given  Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                                                                                                                                                 | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | dashboards/BA%20Dashboard                                                                                                                                                           |      |               |                  |          |
      |                  |       |       | Delete | dashboards/TestBA%20Dashboard                                                                                                                                                       |      |               |                  |          |
      |                  |       |       | Delete | dashboards/Test%20Dashboard                                                                                                                                                         |      |               |                  |          |
      |                  |       |       | Delete | dashboards/TestDemo%20Dashboard                                                                                                                                                     |      |               |                  |          |
      |                  |       |       | Delete | dashboards/TestDashboardWithLenghtyNameTestDashboardWithLenghtyNameTestDashboardWithLenghtyNameTestDashboardWithLenghtyNameTestDashboardWithLenghtyNameTestDashboardWithLenghtyName |      |               |                  |          |

