#@MLP-13767
#Feature:MLP-13767: This feature is to verify whether as an IDA Admin I want to navigate from objects that are linked together in their hierarchy
#
#  ##6917378##6917379###descoped
#  @MLP-13767 @webtest @regression @positive
#  Scenario:SC#1:MLP-13767: Verify that the Database view shows list of Tables belonging to db with a link.
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#    And user "enter text" in "Manage DataSource popup"
#      | fieldName   | actionItem |
#      | Search Area | Reporting  |
#    And user performs following actions in the header
#      | actionType | actionItem    |
#      | click      | Search Button |
#    And user performs "facet selection" in "BigData" attribute under "Catalog" facets in Item Search results page
#    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "item click" on "Reporting" item from search results
#    And user verifies "widget presense" for "Tables" in Item view page
#    Then user performs click and verify in new window
#      | Table           | value                    | Action                 | RetainPrevwindow | indexSwitch |
#      | Tables          | AccountReports           | click and switch tab   | Yes              |             |
#
#  ##6917380##6917381###descoped
#  @MLP-13767 @webtest @regression @positive
#  Scenario:SC#2:MLP-13767: Verify that the table view shows list of columns belonging to table with a link.
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#    And user "enter text" in "Manage DataSource popup"
#      | fieldName   | actionItem |
#      | Search Area | regions    |
#    And user performs following actions in the header
#      | actionType | actionItem    |
#      | click      | Search Button |
#    And user performs "facet selection" in "BigData" attribute under "Catalog" facets in Item Search results page
#    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "item click" on "regions" item from search results
#    And user verifies "widget presense" for "Columns" in Item view page
#    And user click on "widget belongining" in Item View page
#      | widgetName | widgetBelonging   |
#      | Columns    | regiondescription |
#    And user verifies "New tab opened" for "Table Metatype when belonging is clicked" in Item view page
#
#  ##6917385##6921672###descoped
#  @MLP-13767 @webtest @regression @positive
#  Scenario:SC#3:MLP-13767: Verify that the table view shows list of Similar tables belonging to table with a link.
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#    And user "enter text" in "Manage DataSource popup"
#      | fieldName   | actionItem     |
#      | Search Area | employees_full |
#    And user performs following actions in the header
#      | actionType | actionItem    |
#      | click      | Search Button |
#    And user performs "facet selection" in "BigData" attribute under "Catalog" facets in Item Search results page
#    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "item click" on "employees_full" item from search results
#    And user verifies "widget presense" for "similar" in Item view page
#    And user click on "widget belongining" in Item View page
#      | widgetName | widgetBelonging |
#      | similar    | address         |
#    And user verifies "New tab opened" for "Table Metatype when belonging is clicked" in Item view page
#    And user "click" on "Sort Icon for Name Column in Widgets" for "Columns" in "Item View Page"
#    And user "verifies sorting order" of following "Widget belongings are in desending order" in "Item View" page
#      | Columns |
#    And user "click" on "Sort Icon for Name Column in Widgets" for "Columns" in "Item View Page"
#    And user "verifies sorting order" of following "Widget belongings are in ascending order" in "Item View" page
#      | Columns |
#    And user "click" on "Sort Icon for Name Column in Widgets" for "similar" in "Item View Page"
#    And user "verifies sorting order" of following "Widget belongings are in desending order" in "Item View" page
#      | similar |
#    And user "click" on "Sort Icon for Name Column in Widgets" for "similar" in "Item View Page"
#    And user "verifies sorting order" of following "Widget belongings are in ascending order" in "Item View" page
#      | similar |
#
#  ##6917765##6917767###descoped
#  @MLP-13767 @webtest @regression @positive
#  Scenario:SC#4:MLP-13767: Verify that the Analysis view shows the child item as a link.
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#      | click      | Search Button      |
#    And user performs "facet selection" in "BigData" attribute under "Catalog" facets in Item Search results page
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user clicks on first item on the item list page
#    And user verifies "widget presense" for "Data" in Item view page
#    And user click on "widget belongining" in Item View page
#      | widgetName | widgetBelonging |
#      | Data       | log             |
#    And user verifies "New tab opened" for "Data widget when log is clicked" in Item view page
#
#  ##6917769##6917770###descoped
#  @MLP-13767 @webtest @regression @positive
#  Scenario:SC#5:MLP-13767: Verify that the user can navigate to the child item of Column.
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#      | click      | Search Button      |
#    And user performs "facet selection" in "BigData" attribute under "Catalog" facets in Item Search results page
#    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
#    And user clicks on first item on the item list page
#    And user verifies "widget presense" for "Type" in Item view page
#    And user click on "widget belongining" in Item View page
#      | widgetName | widgetBelonging |
#      | Type       | int             |
#    And user verifies "New tab opened" for "Type widget when its belonging is clicked" in Item view page
#
#   ##6917786####6917788##6921693###descoped
#  @MLP-13767 @webtest @regression @positive
#  Scenario:SC#6:MLP-13767: Verify that the SourceTree itemview shows the child item as a link
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#      | click      | Search Button      |
#    And user performs "facet selection" in "BigData" attribute under "Catalog" facets in Item Search results page
#    And user performs "facet selection" in "SourceTree" attribute under "Metadata Type" facets in Item Search results page
#    And user clicks on first item on the item list page
#    And user verifies "widget presense" for "Functions" in Item view page
#    And user click on "first widget belongining" in Item View page
#      | widgetName | widgetBelonging |
#      | Functions  |                 |
#    And user verifies "New tab opened" for "Functions widget when its belonging is clicked" in Item view page
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#    And user "enter text" in "Manage DataSource popup"
#      | fieldName   | actionItem      |
#      | Search Area | LineageTestProc |
#    And user performs following actions in the header
#      | actionType | actionItem    |
#      | click      | Search Button |
#    And user performs "facet selection" in "BigData" attribute under "Catalog" facets in Item Search results page
#    And user performs "facet selection" in "SourceTree" attribute under "Metadata Type" facets in Item Search results page
#    And user clicks on first item on the item list page
#    And user "click" on "Sort Icon for Name Column in Widgets" for "Functions" in "Item View Page"
#    And user "verifies sorting order" of following "Widget belongings are in desending order" in "Item View" page
#      | Functions |
#    And user "click" on "Sort Icon for Name Column in Widgets" for "Functions" in "Item View Page"
#    And user "verifies sorting order" of following "Widget belongings are in ascending order" in "Item View" page
#      | Functions |
#
#  ##6917787##6921692###descoped
#  @MLP-13767 @webtest @regression @positive
#  Scenario:SC#7:MLP-13767: Verify that the user can navigate to the child item of Function.
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#    And user "enter text" in "Manage DataSource popup"
#      | fieldName   | actionItem |
#      | Search Area | accounting |
#    And user performs following actions in the header
#      | actionType | actionItem    |
#      | click      | Search Button |
#    And user performs "facet selection" in "BigData" attribute under "Catalog" facets in Item Search results page
#    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "item click" on "accounting" item from search results
#    And user verifies "widget presense" for "Lineage Hops" in Item view page
#    And user click on "first widget belongining" in Item View page
#      | widgetName   | widgetBelonging |
#      | Lineage Hops |                 |
#    And user verifies "New tab opened" for "Lineage Hops widget when its belonging is clicked" in Item view page
#    And user verifies "widget presense" for "uses" in Item view page
#    And user click on "first widget belongining" in Item View page
#      | widgetName | widgetBelonging |
#      | uses       |                 |
#    And user verifies "New tab opened" for "Uses widget when its belonging is clicked" in Item view page
#    And user "click" on "Sort Icon for Name Column in Widgets" for "Lineage Hops" in "Item View Page"
#    And user "verifies sorting order" of following "Widget belongings are in desending order" in "Item View" page
#      | Lineage Hops |
#    And user "click" on "Sort Icon for Name Column in Widgets" for "Lineage Hops" in "Item View Page"
#    And user "verifies sorting order" of following "Widget belongings are in ascending order" in "Item View" page
#      | Lineage Hops |
#    And user "click" on "Sort Icon for Name Column in Widgets" for "uses" in "Item View Page"
#    And user "verifies sorting order" of following "Widget belongings are in desending order" in "Item View" page
#      | uses |
#    And user "click" on "Sort Icon for Name Column in Widgets" for "uses" in "Item View Page"
#    And user "verifies sorting order" of following "Widget belongings are in ascending order" in "Item View" page
#      | uses |
#
#  ##6917792##6917793##6921694###descoped
#  @MLP-13767 @webtest @regression @positive
#  Scenario:SC#8:MLP-13767: Verify that the user can navigate to the child item of Operation.
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#      | click      | Search Button      |
#    And user performs "facet selection" in "BigData" attribute under "Catalog" facets in Item Search results page
#    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
#    And user clicks on first item on the item list page
#    And user verifies "widget presense" for "Runtime Executions" in Item view page
#    And user click on "first widget belongining" in Item View page
#      | widgetName         | widgetBelonging |
#      | Runtime Executions |                 |
#    And user verifies "New tab opened" for "Runtime Executions widget when its belonging is clicked" in Item view page
#    And user verifies "widget presense" for "Source Tree" in Item view page
#    And user click on "first widget belongining" in Item View page
#      | widgetName  | widgetBelonging |
#      | Source Tree |                 |
#    And user verifies "New tab opened" for "Source Tree widget when its belonging is clicked" in Item view page
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#    And user "enter text" in "Manage DataSource popup"
#      | fieldName   | actionItem               |
#      | Search Area | insertoverwritedirectory |
#    And user performs following actions in the header
#      | actionType | actionItem    |
#      | click      | Search Button |
#    And user performs "facet selection" in "BigData" attribute under "Catalog" facets in Item Search results page
#    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
#    And user clicks on first item on the item list page
#    And user "click" on "Sort Icon for Name Column in Widgets" for "Runtime Executions" in "Item View Page"
#    And user "verifies sorting order" of following "Widget belongings are in desending order" in "Item View" page
#      | Runtime Executions |
#    And user "click" on "Sort Icon for Name Column in Widgets" for "Runtime Executions" in "Item View Page"
#    And user "verifies sorting order" of following "Widget belongings are in ascending order" in "Item View" page
#      | Runtime Executions |
#
#  ##6917816##6917817##6921810###descoped
#  @MLP-13767 @webtest @regression @positive
#  Scenario:SC#9:MLP-13767: Verify that the user can navigate to the child item of Service.
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#    And user "enter text" in "Manage DataSource popup"
#      | fieldName   | actionItem |
#      | Search Area | HDFS       |
#    And user performs following actions in the header
#      | actionType | actionItem    |
#      | click      | Search Button |
#    And user performs "facet selection" in "BigData" attribute under "Catalog" facets in Item Search results page
#    And user performs "facet selection" in "Service" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "item click" on "HDFS" item from search results
#    And user verifies "widget presense" for "has_Directory" in Item view page
#    And user click on "first widget belongining" in Item View page
#      | widgetName    | widgetBelonging |
#      | has_Directory |                 |
#    And user verifies "New tab opened" for "Has_Directory widget when its belonging is clicked" in Item view page
#    And user "click" on "Sort Icon for Name Column in Widgets" for "has_Directory" in "Item View Page"
#    And user "verifies sorting order" of following "Widget belongings are in desending order" in "Item View" page
#      | has_Directory |
#    And user "click" on "Sort Icon for Name Column in Widgets" for "has_Directory" in "Item View Page"
#    And user "verifies sorting order" of following "Widget belongings are in ascending order" in "Item View" page
#      | has_Directory |
#
#  ##6917836##6917837##6921812###descoped
#  @MLP-13767 @webtest @regression @positive
#  Scenario:SC#10:MLP-13767: Verify that the Data Package itemview shows the child item as a link.
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#      | click      | Search Button      |
#    And user performs "facet selection" in "BigData" attribute under "Catalog" facets in Item Search results page
#    And user performs "facet selection" in "DataPackage" attribute under "Metadata Type" facets in Item Search results page
#    And user clicks on first item on the item list page
#    And user verifies "widget presense" for "Data Types" in Item view page
#    And user click on "first widget belongining" in Item View page
#      | widgetName | widgetBelonging |
#      | Data Types |                 |
#    And user verifies "New tab opened" for "Data Types widget when its belonging is clicked" in Item view page
#    And user "click" on "Sort Icon for Name Column in Widgets" for "Data Types" in "Item View Page"
#    And user "verifies sorting order" of following "Widget belongings are in desending order" in "Item View" page
#      | Data Types |
#    And user "click" on "Sort Icon for Name Column in Widgets" for "Data Types" in "Item View Page"
#    And user "verifies sorting order" of following "Widget belongings are in ascending order" in "Item View" page
#      | Data Types |
#
#  ##6917848##6917849##6921813###descoped
#  @MLP-13767 @webtest @regression @positive
#  Scenario:SC#11:MLP-13767: Verify that the Project itemview shows the child item as a link.
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#      | click      | Search Button      |
#    And user performs "facet selection" in "BigData" attribute under "Catalog" facets in Item Search results page
#    And user performs "facet selection" in "Project" attribute under "Metadata Type" facets in Item Search results page
#    And user clicks on first item on the item list page
#    And user verifies "widget presense" for "Files" in Item view page
#    And user click on "first widget belongining" in Item View page
#      | widgetName | widgetBelonging |
#      | Files      |                 |
#    And user verifies "New tab opened" for "Files widget when its belonging is clicked" in Item view page
#    And user "click" on "Sort Icon for Name Column in Widgets" for "Files" in "Item View Page"
#    And user "verifies sorting order" of following "Widget belongings are in desending order" in "Item View" page
#      | Files |
#    And user "click" on "Sort Icon for Name Column in Widgets" for "Files" in "Item View Page"
#    And user "verifies sorting order" of following "Widget belongings are in ascending order" in "Item View" page
#      | Files |
#
#  ##6921661##6921662##6921923###descoped
#  @MLP-13767 @webtest @regression @positive
#  Scenario:SC#12:MLP-13767: Verify that the Cluster itemview shows the child item as a link.
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#    And user "enter text" in "Manage DataSource popup"
#      | fieldName   | actionItem   |
#      | Search Area | Cluster Demo |
#    And user performs following actions in the header
#      | actionType | actionItem    |
#      | click      | Search Button |
#    And user performs "facet selection" in "BigData" attribute under "Catalog" facets in Item Search results page
#    And user performs "facet selection" in "Cluster" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "item click" on "Cluster Demo" item from search results
#    And user verifies "widget presense" for "Data Packages" in Item view page
#    And user click on "first widget belongining" in Item View page
#      | widgetName    | widgetBelonging |
#      | Data Packages |                 |
#    And user verifies "New tab opened" for "Data Packages widget when its belonging is clicked" in Item view page
#    And user verifies "widget presense" for "Hosts" in Item view page
#    And user click on "first widget belongining" in Item View page
#      | widgetName | widgetBelonging |
#      | Hosts      |                 |
#    And user verifies "New tab opened" for "Hosts widget when its belonging is clicked" in Item view page
#    And user verifies "widget presense" for "Services" in Item view page
#    And user click on "first widget belongining" in Item View page
#      | widgetName | widgetBelonging |
#      | Services   |                 |
#    And user verifies "New tab opened" for "Services widget when its belonging is clicked" in Item view page
#    And user "click" on "Sort Icon for Name Column in Widgets" for "Data Packages" in "Item View Page"
#    And user "verifies sorting order" of following "Widget belongings are in desending order" in "Item View" page
#      | Data Packages |
#    And user "click" on "Sort Icon for Name Column in Widgets" for "Data Packages" in "Item View Page"
#    And user "verifies sorting order" of following "Widget belongings are in ascending order" in "Item View" page
#      | Data Packages |
#    And user "click" on "Sort Icon for Name Column in Widgets" for "Hosts" in "Item View Page"
#    And user "verifies sorting order" of following "Widget belongings are in desending order" in "Item View" page
#      | Hosts |
#    And user "click" on "Sort Icon for Name Column in Widgets" for "Hosts" in "Item View Page"
#    And user "verifies sorting order" of following "Widget belongings are in ascending order" in "Item View" page
#      | Hosts |
#    And user "click" on "Sort Icon for Name Column in Widgets" for "Services" in "Item View Page"
#    And user "verifies sorting order" of following "Widget belongings are in desending order" in "Item View" page
#      | Services |
#    And user "click" on "Sort Icon for Name Column in Widgets" for "Services" in "Item View Page"
#    And user "verifies sorting order" of following "Widget belongings are in ascending order" in "Item View" page
#      | Services |