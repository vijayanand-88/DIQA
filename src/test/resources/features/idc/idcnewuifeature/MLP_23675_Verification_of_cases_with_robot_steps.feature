@MLP-23675
Feature: MLP-23675-This feature is to verify the cases which involve robot step definitions

 ##MLP-23675 - Verification of discard popup in manage bundles

    ##7108493##7108494##7108499##7108500##7108501##
  @MLP-23675 @webtest @regression @positive
  Scenario:SC#9: MLP-23675: Verify the discard popup works as expected in manage Bundles
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Bundles" in "Landing page"
    And user "click" on "Add Button in Manage Bundles Page" button in "Manage Bundles page"
    And user "Verifies popup" is "displayed" for "Add Bundle"
    And user clicks on "Escape" key
    And user "Verifies popup" is "not displayed" for "Unsaved changes"
    And user "click" on "Add Button in Manage Bundles Page" button in "Manage Bundles page"
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method         | Action                           |
      | setAutoDelay   | 1000                             |
      | selectOSGIFile | Git-9.5.0-20171023.122812-15.jar |
      | setAutoDelay   | 1000                             |
      | keyPress       | CONTROL                          |
      | keyPress       | V                                |
      | keyRelease     | CONTROL                          |
      | keyRelease     | V                                |
      | setAutoDelay   | 1000                             |
      | keyPress       | ENTER                            |
      | keyRelease     | ENTER                            |
    And user clicks on "Escape" key
    And user "Verifies popup" is "displayed" for "Unsaved changes"
    And user clicks on "No" link in the "Edit Data Source popup"
    And user "click" on "Popup Cancel" button in "Edit Data Source popup"
    And user "Verifies popup" is "displayed" for "Unsaved changes"
    And user clicks on "No" link in the "Edit Data Source popup"
    And user "click" on "Popup Close" button in "Edit Data Source popup"
    And user "Verifies popup" is "displayed" for "Unsaved changes"