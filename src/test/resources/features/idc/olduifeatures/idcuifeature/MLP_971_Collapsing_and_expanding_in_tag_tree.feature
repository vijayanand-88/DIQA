@MLP-971
Feature: MLP-971: Add arrows on the tag tree to understand that you can collapse/extend the tree. Currently this feature is hidden behinde the name of the tag.

  @MLP-971 @webtest @tagTree @sanity @positive
  Scenario:MLP-971: Verify whether the arrow in the tag tree
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user selects "BigData" catalog from catalog list
    Then tag expanding and collapsing triangle buttons should display
    And user should be able logoff the IDC

  @MLP-971 @webtest @tagTree @sanity
  Scenario:MLP-971: Verify whether the tag structure is getting collapsed when the user clicks on tagCollapsingTriangleButton
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user selects "BigData" catalog from catalog list
    And user clicks on "Cluster Demo" tagCollapsingTriangleButton
    Then subtags of the "Cluster Demo" tag should not get displayed
    And user should be able logoff the IDC

  @MLP-971 @webtest @tagTree @sanity @positive
  Scenario:MLP-971: Verify whether the tag structure is getting expanded when the user clicks on tagExpandingTriangleButton
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user selects "BigData" catalog from catalog list
    And user clicks on "Cluster Demo" tagCollapsingTriangleButton
    And user clicks on "Cluster Demo" tagExpandingTriangleButton
    Then subtags of the "Cluster Demo" tag should get displayed
    And user should be able logoff the IDC

