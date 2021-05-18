@MLP-3363
Feature: A feature  to verify the color codes for different types

  @MLP-3363 @webtest @regression @positive @Diagramming
  Scenario:MLP-3363: Verification of border color for all items types
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user selects the "Column" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    And user clicks on "Column" node in the diagramming page
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode       | Node   |
      | stroke    | rgb(26, 52, 64) | Column |
    And user clicks on close button in the diagramming page
    And user selects the "Column" from the Type
    And user selects the "Directory" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    And user clicks on "Directory" node in the diagramming page
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode       | Node      |
      | stroke    | rgb(26, 52, 64) | Directory |
    And user clicks on close button in the diagramming page
    And user selects the "Directory" from the Type
    And user enters the search text "shippers" in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    And user clicks on "Table" node in the diagramming page
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode       | Node  |
      | stroke    | rgb(26, 52, 64) | Table |
    And user clicks on close button in the diagramming page
    And user clicks on logout button

  @MLP-3363 @webtest @regression @positive @Diagramming
  Scenario:MLP-3363: Verification of color codes for Analysis Type
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user selects the "Analysis" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node     |
      | fill      | rgb(247, 255, 250) | Analysis |
    And user mouse hovers on "Analysis" node in the diagramming page
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node     |
      | fill      | rgb(230, 255, 239) | Analysis |
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode         | Node     |
      | stroke    | rgb(70, 214, 131) | Analysis |
    And user clicks on close button in the diagramming page
    And user clicks on logout button

  @MLP-3363 @webtest @regression @positive @Diagramming
  Scenario:MLP-3363: Verification of color codes for Namespace Type
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on "Schema" tab displayed
    And user "click" full view icon in the Diagramming page
    And user "zoomOut" the Lineage diagram for "2" times using + icon
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node      |
      | fill      | rgb(247, 255, 250) | Namespace |
    And user mouse hovers on "Namespace" node in the diagramming page
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node      |
      | fill      | rgb(230, 255, 239) | Namespace |
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node      |
      | stroke    | rgb(140, 227, 177) | Namespace |

  @MLP-3363 @webtest @regression @positive @Diagramming
  Scenario:MLP-3363: Verification of color codes for Project Type
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects the BigData catalog from catalog list
    And user enters the search text "Project" in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user selects the "Project" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node    |
      | fill      | rgb(251, 246, 255) | Project |
    And user mouse hovers on "Project" node in the diagramming page
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node    |
      | fill      | rgb(244, 232, 255) | Project |
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode         | Node    |
      | stroke    | rgb(138, 58, 213) | Project |

  @MLP-3363 @webtest @regression @positive @Diagramming
  Scenario:MLP-3363: Verification of color codes for Source Tree Type
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user selects the "SourceTree" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node       |
      | fill      | rgb(251, 246, 255) | SourceTree |
    And user mouse hovers on "SourceTree" node in the diagramming page
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node       |
      | fill      | rgb(244, 232, 255) | SourceTree |
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node       |
      | stroke    | rgb(220, 196, 242) | SourceTree |
    And user clicks on close button in the diagramming page
    And user should be able logoff the IDC

  @MLP-3363 @webtest @regression @positive @Diagramming
  Scenario:MLP-3363: Verification of color codes for ExternalPackage Type
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on "Schema" tab displayed
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node            |
      | fill      | rgb(251, 246, 255) | ExternalPackage |
    And user mouse hovers on "ExternalPackage" node in the diagramming page
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node            |
      | fill      | rgb(244, 232, 255) | ExternalPackage |
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node            |
      | stroke    | rgb(185, 137, 230) | ExternalPackage |
    And user clicks on logout button

  @MLP-3363 @webtest @regression @positive @Diagramming
  Scenario:MLP-3363: Verification of color codes for Class Type
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on "Schema" tab displayed
    And user "click" full view icon in the Diagramming page
    And user "zoomOut" the Lineage diagram for "3" times using + icon
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node  |
      | fill      | rgb(251, 246, 255) | Class |
    And user mouse hovers on "Class" node in the diagramming page
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node  |
      | fill      | rgb(251, 246, 255) | Class |
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node  |
      | stroke    | rgb(238, 226, 249) | Class |

  @MLP-3363 @webtest @regression @positive @Diagramming
  Scenario:MLP-3363: Verification of color codes for Function Type
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user selects the "Function" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node     |
      | fill      | rgb(251, 246, 255) | Function |
    And user mouse hovers on "Function" node in the diagramming page
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node     |
      | fill      | rgb(244, 232, 255) | Function |
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node     |
      | stroke    | rgb(238, 226, 249) | Function |
    And user clicks on close button in the diagramming page
    And user should be able logoff the IDC

  @MLP-3363 @webtest @regression @positive @Diagramming
  Scenario:MLP-3363: Verification of color codes for Operation Type
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user selects the "Operation" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node      |
      | fill      | rgb(255, 242, 236) | Operation |
    And user mouse hovers on "Operation" node in the diagramming page
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node      |
      | fill      | rgb(255, 224, 210) | Operation |
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode         | Node      |
      | stroke    | rgb(250, 130, 73) | Operation |
    And user clicks on close button in the diagramming page
    And user should be able logoff the IDC

  @MLP-3363 @webtest @regression @positive @Diagramming
  Scenario:MLP-3363: Verification of color codes for Execution Type
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user selects the "Execution" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node      |
      | fill      | rgb(255, 242, 236) | Execution |
    And user mouse hovers on "Execution" node in the diagramming page
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node      |
      | fill      | rgb(255, 224, 210) | Execution |
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node      |
      | stroke    | rgb(252, 180, 146) | Execution |
    And user clicks on close button in the diagramming page
    And user should be able logoff the IDC

  @MLP-3363 @webtest @regression @positive @Diagramming
  Scenario:MLP-3363: Verification of color codes for LineageHop Type
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on "Schema" tab displayed
    And user "click" full view icon in the Diagramming page
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node       |
      | fill      | rgb(255, 242, 236) | LineageHop |
    And user clicks on "zoom out" icon in diagram
    And user clicks on "zoom out" icon in diagram
    And user clicks on "zoom out" icon in diagram
    And user mouse hovers on "LineageHop" node in the diagramming page
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node       |
      | fill      | rgb(255, 224, 210) | LineageHop |
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node       |
      | stroke    | rgb(253, 217, 200) | LineageHop |

  @MLP-3363 @webtest @regression @positive @Diagramming
  Scenario:MLP-3363: Verification of color codes for Cluster Type
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user selects the "Cluster" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node    |
      | fill      | rgb(255, 243, 248) | Cluster |
    And user mouse hovers on "Cluster" node in the diagramming page
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node    |
      | fill      | rgb(255, 236, 244) | Cluster |
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode         | Node    |
      | stroke    | rgb(240, 90, 150) | Cluster |
    And user clicks on close button in the diagramming page
    And user should be able logoff the IDC

  @MLP-3363 @webtest @regression @positive @Diagramming
  Scenario:MLP-3363: Verification of color codes for ClusterService Type
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user selects the "Cluster" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node    |
      | fill      | rgb(255, 243, 248) | Service |
    And user mouse hovers on "Service" node in the diagramming page
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node    |
      | fill      | rgb(255, 236, 244) | Service |
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node    |
      | stroke    | rgb(246, 156, 192) | Service |
    And user clicks on close button in the diagramming page
    And user should be able logoff the IDC

  @MLP-3363 @webtest @regression @positive @Diagramming
  Scenario:MLP-3363: Verification of color codes for Host Type
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user selects the "Host" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node |
      | fill      | rgb(255, 243, 248) | Host |
    And user mouse hovers on "Host" node in the diagramming page
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node |
      | fill      | rgb(255, 236, 244) | Host |
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node |
      | stroke    | rgb(246, 156, 192) | Host |
    And user clicks on close button in the diagramming page
    And user should be able logoff the IDC

  @MLP-3363 @webtest @regression @positive @Diagramming
  Scenario:MLP-3363: Verification of color codes for Directory Type
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user selects the "Directory" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node      |
      | fill      | rgb(255, 246, 234) | Directory |
    And user mouse hovers on "Directory" node in the diagramming page
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node      |
      | fill      | rgb(255, 241, 222) | Directory |
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode         | Node      |
      | stroke    | rgb(210, 156, 78) | Directory |
    And user clicks on close button in the diagramming page
    And user should be able logoff the IDC

  @MLP-3363 @webtest @regression @positive @Diagramming
  Scenario:MLP-3363: Verification of color codes for File Type
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user selects the "File" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node |
      | fill      | rgb(255, 246, 234) | File |
    And user mouse hovers on "File" node in the diagramming page
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node |
      | fill      | rgb(255, 241, 222) | File |
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node |
      | stroke    | rgb(228, 196, 149) | File |
    And user clicks on close button in the diagramming page
    And user should be able logoff the IDC

  @MLP-3363 @webtest @regression @positive @Diagramming
  Scenario:MLP-3363: Verification of color codes for Field Type
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user selects the "Field" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node  |
      | fill      | rgb(255, 246, 234) | Field |
    And user mouse hovers on "Field" node in the diagramming page
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node  |
      | fill      | rgb(255, 241, 222) | Field |
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node  |
      | stroke    | rgb(241, 225, 202) | Field |
    And user clicks on close button in the diagramming page
    And user should be able logoff the IDC

  @MLP-3363 @webtest @regression @positive @Diagramming
  Scenario:MLP-3363: Verification of color codes for Database Type
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user selects the "Database" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node     |
      | fill      | rgb(233, 248, 255) | Database |
    And user mouse hovers on "Database" node in the diagramming page
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node     |
      | fill      | rgb(212, 242, 255) | Database |
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node     |
      | stroke    | rgb(111, 178, 235) | Database |
    And user clicks on close button in the diagramming page
    And user should be able logoff the IDC

  @MLP-3363 @webtest @regression @positive @Diagramming
  Scenario:MLP-3363: Verification of color codes for Table Type
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "employeeterritories" in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node  |
      | fill      | rgb(233, 248, 255) | Table |
    And user mouse hovers on "Table" node in the diagramming page
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node  |
      | fill      | rgb(212, 242, 255) | Table |
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node  |
      | stroke    | rgb(183, 216, 245) | Table |
    And user clicks on close button in the diagramming page
    And user clicks on logout button

  @MLP-3363 @webtest @regression @positive @Diagramming
  Scenario:MLP-3363: Verification of color codes for Column Type
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user selects the "Column" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node   |
      | fill      | rgb(255, 255, 255) | Column |
    And user mouse hovers on "Column" node in the diagramming page
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node   |
      | fill      | rgb(212, 242, 255) | Column |
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node   |
      | stroke    | rgb(183, 216, 245) | Column |
    And user clicks on close button in the diagramming page
    And user should be able logoff the IDC

  @MLP-3363 @webtest @regression @positive @Diagramming
  Scenario:MLP-3363: Verification of color codes for Schema Type
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on "Schema" tab displayed
    And user "click" full view icon in the Diagramming page
    And user "zoomOut" the Lineage diagram for "2" times using + icon
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node   |
      | fill      | rgb(233, 248, 255) | Schema |
    And user mouse hovers on "Schema" node in the diagramming page
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node   |
      | fill      | rgb(212, 242, 255) | Schema |
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node   |
      | stroke    | rgb(183, 216, 245) | Schema |

  @MLP-3363 @webtest @regression @positive @Diagramming
  Scenario:MLP-3363: Verification of color codes for DataPackage
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user selects the "DataPackage" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node        |
      | fill      | rgb(254, 255, 238) | DataPackage |
    And user mouse hovers on "DataPackage" node in the diagramming page
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node        |
      | fill      | rgb(242, 244, 212) | DataPackage |
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node        |
      | stroke    | rgb(197, 201, 121) | DataPackage |
    And user clicks on close button in the diagramming page
    And user should be able logoff the IDC

  @MLP-3363 @webtest @regression @positive @Diagramming
  Scenario:MLP-3363: Verification of color codes for DataType
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user selects the "DataType" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node     |
      | fill      | rgb(254, 255, 238) | DataType |
    And user mouse hovers on "DataType" node in the diagramming page
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node     |
      | fill      | rgb(242, 244, 212) | DataType |
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node     |
      | stroke    | rgb(212, 215, 157) | DataType |
    And user clicks on close button in the diagramming page
    And user clicks on logout button

  @MLP-3363 @webtest @regression @positive @Diagramming
  Scenario:MLP-3363: Verification of color codes for DataDomain Type
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user selects the "DataDomain" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node       |
      | fill      | rgb(254, 255, 238) | DataDomain |
    And user mouse hovers on "DataDomain" node in the diagramming page
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node       |
      | fill      | rgb(242, 244, 212) | DataDomain |
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node       |
      | stroke    | rgb(231, 233, 201) | DataDomain |
    And user clicks on close button in the diagramming page
    And user should be able logoff the IDC

  @MLP-3363 @webtest @regression @positive @Diagramming
  Scenario:MLP-3363: Verification of color codes for DataField Type
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on "Schema" tab displayed
    And user "click" full view icon in the Diagramming page
    And user "zoomOut" the Lineage diagram for "3" times using + icon
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node      |
      | fill      | rgb(254, 255, 238) | DataField |
    And user mouse hovers on "DataField" node in the diagramming page
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node      |
      | fill      | rgb(254, 255, 238) | DataField |
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode          | Node      |
      | stroke    | rgb(231, 233, 201) | DataField |










