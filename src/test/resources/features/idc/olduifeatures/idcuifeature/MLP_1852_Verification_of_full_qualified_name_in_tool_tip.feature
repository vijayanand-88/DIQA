@MLP-1852
Feature:MLP-1852: Show full qualified name in tooltip in result item list
  Description: The item name tooltip in itemlist should show the whole qualified item name instead of the local name. This should be work for all tables presenting items (also inside itemview pages).

  @MLP-1852 @webtest @sanity @positive
  Scenario:MLP-1852: Verification of fully qualified tool tip in the item lists results
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user selects "BigData" catalog from catalog list
    And user clicks on search icon
    And user checks the checkbox for "customer [Table]" in Parent hierarchy
    And user clicks on first item on the item list page
    Then user "verify presence" of following "breadcrumb" in item view page
      | foodmart |

  @MLP-1852 @webtest @sanity @positive
  Scenario:MLP-1852: Verification of fully qualified tool tip for SIMILAR values
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user selects the "Table" from the Type
    And user checks the checkbox for "northwind [Database]" in Parent hierarchy
    And user clicks on randon item name link on the item list page
    And user verifies if similiar section is available
    Then title of the items displayed under SIMILAR section contain "northwind [Database]" and corresponding table name

  @MLP-1852 @webtest @sanity @positive
  Scenario:MLP-1852: Verification of fully qualified tool tip for HAS_COLUMN values
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user selects "BigData" catalog from catalog list
    And user selects the "Table" from the Type
    And user checks the checkbox for "northwind [Database]" in Parent hierarchy
    And user stores the title attribute of first item in temporary text
    And user clicks on first item on the item list page
    Then title of the items displayed under Has Column section should be their full qualified name

  @MLP-1852 @webtest @sanity @positive
  Scenario:MLP-1852: Verification of fully qualified tool tip for Filed items
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user click Show All button in type facets
    And user checks the checkbox for "Field" in Type
    And user checks the checkbox for "store_sample.csv [File]" in Parent hierarchy
    Then title of the items displayed should contain the title "Cluster 1 [Cluster] => %2fuser%2ftest [Directory] => store_sample.csv [File] => _c17 [Field]"

  @MLP-1852 @webtest @sanity @positive
  Scenario:MLP-1852: Verification of fully qualified tool tip for File items
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user click Show All button in type facets
    And user checks the checkbox for "Directory" in Type
    And user checks the checkbox for "Cluster Demo [Cluster]" in Parent hierarchy
    Then title of the items displayed should contain the title "Cluster Demo [Cluster] => /user/history [Directory]"


