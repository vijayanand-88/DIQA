Feature: MLP-5066 Visual Design for catalog

  @webtest @MLP-5066 @webtest @positive
  Scenario:Verification of search filter in the catalog icon panel during the creation of a new Catalog
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Administration" dashboard
    And User "click" on "CATALOG MANAGER" link on the Dashboard page
    And user creates a catalog with "Name" and "Description"  on catalog page
    Then user select "pdf" icon from list on catalog page
    And user "verifies displayed" icon is "pdf" with tooltip name as "file-pdf-o"

  @webtest @MLP-5066 @webtest @positive
  Scenario: Verification of search filter in the catalog icon panel for an existing catalog
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Administration" dashboard
    And User "click" on "CATALOG MANAGER" link on the Dashboard page
    And user clicks on "BigData" catalog in catalog management
    And user "click" on catalog "CatalogIcon" in Edit catalog page
    Then user select "pdf" icon from list on catalog page
    And user "verifies displayed" icon is "pdf" with tooltip name as "file-pdf-o"


  @webtest @MLP-5066 @positive
  Scenario: Verification of catalog dataseticon
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "customerid" and clicks on search
    And user enable first item checkbox from item search results
    And user click on Assign DataSet button
    And user click on Create New DataSet button in Assign Data Set panel
    And user "click" on "DataSetImageIcon" on DatasetPage
    Then user select "pdf" icon from list on catalog page
    And user "verifies displayed" icon is "pdf" with tooltip name as "file-pdf-o"









