@MLP-3351
Feature:MLP-3351: This feature is to verify the icon functionality of Diagramming

  @MLP-3351 @webtest @regression @positive @Diagramming
  Scenario:MLP-3351: Verification of icon for column,table and end to end lineage
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "max_asian" in the Search Data Intelligence Suite area
    And user clicks on search icon
    When user clicks on first item on the item list page
    And user clicks on "Lineage" tab displayed
    Then user verifies whether the following image is present
      | Method           | Action         | Path                    |
      | initializeImage  | ColumnIcon.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2              |                         |
      | initializeImage  | TableIcon.png  | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2              |                         |
    And user verifies icon for end to end lineage is displayed
    And user should be able logoff the IDC

  @MLP-3351 @webtest @regression @positive @Diagramming
  Scenario:MLP-3351: Verification of icon for DataType and DataDomain
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "Denmark" in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user checks the checkbox for "DataDomain" in Type
    When user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    Then user verifies whether the following image is present
      | Method           | Action                  | Path                    |
      | initializeImage  | Domain_DataTypeIcon.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                       |                         |
    And user should be able logoff the IDC

  @MLP-3351 @webtest @regression @positive @Diagramming
  Scenario:MLP-3351: Verification of icon for Field
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "_c17" in the Search Data Intelligence Suite area
    And user clicks on search icon
    When user clicks on first item on the item list page
    And user clicks on "Lineage" tab displayed
    Then user verifies whether the following image is present
      | Method           | Action        | Path                    |
      | initializeImage  | FieldIcon.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2             |                         |
    And user should be able logoff the IDC

  @MLP-3351 @webtest @regression @positive @Diagramming
  Scenario:MLP-3351: Verification of icon for Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "northwind" in the Search Data Intelligence Suite area
    And user clicks on search icon
    When user checks the checkbox for "Database" in Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    Then user verifies whether the following image is present
      | Method           | Action           | Path                    |
      | initializeImage  | DatabaseIcon.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                |                         |
    And user should be able logoff the IDC

  @MLP-3351 @webtest @regression @positive @Diagramming
  Scenario:MLP-3351: Verification of icon for Directory
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user selects "BigData" catalog from catalog list
#    And user enters the search text "/user/history" in the Search Data Intelligence Suite area
#    And user clicks on search icon
    And user checks the checkbox for "Directory" in Type
    And user clicks on "/user/history" in the items listed
#    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    Then user verifies whether the following image is present
      | Method           | Action            | Path                    |
      | initializeImage  | DirectoryIcon.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                 |                         |
    And user should be able logoff the IDC

  @MLP-3351 @webtest @regression @positive @Diagramming
  Scenario:MLP-3351: Verification of icon for SourceTree and Function
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user selects "BigData" catalog from catalog list
    When user enters the search text "Marketplace" in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user checks the checkbox for "Function" in Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    Then user verifies whether the following image is present
      | Method           | Action           | Path                    |
      | initializeImage  | FunctionIcon.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                |                         |
      | initializeImage  | LineageHop.png   | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                |                         |
    And user should be able logoff the IDC

  @MLP-3351 @webtest @regression @positive @Diagramming
  Scenario:MLP-3351: Verification of icon for Cluster,Cluster Service,Data Package and Host
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user selects "BigData" catalog from catalog list
#    And user enters the search text "Cluster Demo" in the Search Data Intelligence Suite area
#    And user clicks on search icon
    When user click Show All button in type facets
    And user checks the checkbox for "Cluster" in Type
    And user clicks on "Cluster Demo" in the items listed
    And user clicks on "Relationships" tab displayed
    Then user verifies whether the following image is present
      | Method           | Action              | Path                    |
      | initializeImage  | ClusterIcon.png     | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                   |                         |
      | initializeImage  | ServiceIcon.png     | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                   |                         |
      | initializeImage  | DataPackageIcon.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                   |                         |
      | initializeImage  | HostIcon.png        | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                   |                         |
    And user should be able logoff the IDC

  @MLP-3351 @webtest @regression @positive @Diagramming
  Scenario:MLP-3351: Verification of icon for Operation and Execution
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "test_user" in the Search Data Intelligence Suite area
    And user clicks on search icon
    When user checks the checkbox for "Execution" in Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    Then user verifies whether the following image is present
      | Method           | Action            | Path                    |
      | initializeImage  | OperationIcon.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                 |                         |
      | initializeImage  | ExecutionIcon.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                 |                         |
    And user should be able logoff the IDC

  @MLP-3351 @webtest @regression @positive @Diagramming
  Scenario:MLP-3351: Verification of icon for Project and Source
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user selects "BigData" catalog from catalog list
    When user enters the search text "LineageDemo" in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user click Show All button in type facets
    And user checks the checkbox for "Project" in Type
    Then user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    Then user verifies whether the following image is present
      | Method           | Action          | Path                    |
      | initializeImage  | ProjectIcon.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2               |                         |
      | initializeImage  | SourceIcon.png  | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2               |                         |
    And user should be able logoff the IDC

  @MLP-3351 @webtest @regression @positive @Diagramming
  Scenario:MLP-3351: Verification of icon for File
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user selects "BigData" catalog from catalog list
    When user enters the search text "testdata.csv" in the Search Data Intelligence Suite area
    And user clicks on search icon
    Then user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    Then user verifies whether the following image is present
      | Method           | Action       | Path                    |
      | initializeImage  | FileIcon.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2            |                         |
    And user should be able logoff the IDC

  @MLP-3351 @webtest @regression @positive @Diagramming
  Scenario:MLP-3351: Verification of icon for Analysis
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user selects "All" catalog from catalog list
#    When user enters the search text "linker/HiveDirectoryLinker/HiveDirectoryLinkerOnImport" in the Search Data Intelligence Suite area
#    And user clicks on search icon
#    And user checks the checkbox for "Analysis" in Type
#    Then user clicks on first item on the item list page
#    And user enters the search text "linker/HiveDirectoryLinker/HiveDirectoryLinkerOnImport" in the Search Data Intelligence Suite area
#    And user clicks on search icon
    And user selects the "Analysis" from the Type
    And user clicks on "linker/HiveDirectoryLinker/HiveDirectoryLinkerOnImport" in the items listed
#    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    Then user verifies whether the following image is present
      | Method           | Action           | Path                    |
      | initializeImage  | AnalysisIcon.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                |                         |
    And user should be able logoff the IDC

  @MLP-3351 @webtest @regression @positive @Diagramming
  Scenario:MLP-3351: Verification of icon for SourceTree
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user selects "BigData" catalog from catalog list
    When user enters the search text "LineageTest.sql" in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user checks the checkbox for "SourceTree" in Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    Then user verifies whether the following image is present
      | Method           | Action             | Path                    |
      | initializeImage  | SourceTreeIcon.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                  |                         |
    And user should be able logoff the IDC


  @MLP-3351 @webtest @regression @positive @Diagramming
  Scenario:MLP-3351: Verification of icon  for Namespace,External Package,Class and Schema
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And supply payload with file name "idc/MLP-3351_SchemaView.json"
    And user makes a REST Call for PUT request with url "settings" with the following query param
      | path | com%2Fasg%2Fdis%2Fplatform%2Ftheme%2Fschemaview.json |
    And Status code 204 must be returned
    And configure a new REST API for the service "IDC"
    And  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-3351_Schema.json"
    And user makes a REST Call for PUT request with url "settings" with the following query param
      | path | com%2Fasg%2Fdis%2Fplatform%2Fdiagram%2Fschema_h.json |
    And Status code 204 must be returned
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user clicks on "Schema" tab displayed
    And user clicks on "zoom out" icon in diagram
    Then user verifies whether the following image is present
      | Method           | Action                  | Path                    |
      | initializeImage  | Namespace.png           | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                       |                         |
      | initializeImage  | ExternalPackageIcon.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                       |                         |
      | initializeImage  | ClassIcon.png           | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                       |                         |
      | initializeImage  | SchemaIcon.png          | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                       |                         |
    And user should be able logoff the IDC
