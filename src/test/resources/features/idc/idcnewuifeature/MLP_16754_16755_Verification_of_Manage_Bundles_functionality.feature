@MLP-16754 @MLP-16758 @MLP-16755
Feature: MLP-16754: This feature is to verify whether as an IDA Admin, I want to Manage Uploaded Bundles
  MLP-16758: This feature is to verify whether as an IDA Admin, I want to be able to delete a bundle from available list
  MLP-16755: This feature is to verify As a IDA Admin, I need to validate the ManageBundles.

  ##6909371##6909372##6909373##6909374##6909376##6909380##6909381##6909383##6909384##7248352
  @MLP-16754 @webtest @regression @positive @e2e
  Scenario:SC#1:MLP-16754: Verify that the Database view shows list of Tables belonging to db with a link.
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for Get request with url "/health" and store value of json path"$.version"
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Bundles" in "Landing page"
    And user "verifies presence" of following "Admin page Title" in "" page
      | Manage Bundles |
    And user "verifies presence" of following "Landed page Title is Bold" in "" page
      | Manage Bundles |
    And user "verifies presence" of following "Page Subtitle" in "Manage Tags" page
      | Add and delete bundles. |
    And user verifies "Add Bundles Button" is "displayed"
    And user "click" on "Filter Icon" button in "Manage Data Sources Page"
    And user "select Bundles dropdown" in "Manage Bundles page"
      | fieldName | actionItem      |
      | Bundle    | com.asg.dis.Git |
    And user "verifies presence" of following "Bundles list" in "Manage Bundles" page
      | com.asg.dis.Git |
    Then "Bundles Header Count" should be "displayed" as "Bundles (1)" in "Manage Bundles page"
#    And user "select Bundles dropdown" in "Manage Bundles page"
#      | fieldName | actionItem                                    |
#      | Bundle    | All                                           |
#      | Name      | com.asg.dis.analysis.AmazonS3-10.3.0.SNAPSHOT |
#    And user "verifies presence" of following "Bundles list" in "Manage Bundles" page
#      | com.asg.dis.analysis.AmazonS3 |
    And user "select Bundles dropdown" in "Manage Bundles page"
      | fieldName | actionItem |
      | Bundle    | All        |
      | Version   |            |
    And user "verifies presence" of following "Bundles Version all are same" in "Manage Bundles" page
      |  |
    And user "click" on "Manage Bundles Search" button in "Manage Bundles Page"
    And user "enter text" in "Manage DataSource popup"
      | fieldName           | actionItem |
      | Bundles Search Area | Git        |
    And user "verifies presence" of following "Bundles list" in "Manage Bundles" page
      | com.asg.dis.Git |
    And user "click" on "Bundle Search exit" button in "Manage Bundles Page"
    And user "Expand Bundle" in "Manage Bundles page"
      | fieldName       | actionItem |
      | com.asg.dis.Git |            |
    And user "verifies presence" of following "Plugins list for expanded Bundle" in "Manage Bundles" page
      | GitCollector           |
      | GitCollectorDataSource |
    And user "Collapse Bundle" in "Manage Bundles page"
      | fieldName       | actionItem |
      | com.asg.dis.Git |            |
    And user "verifies presence" of following "Empty Plugin list when Bundle Collapsed" in "Manage Bundles" page
      |  |
    And user "click" on "Manage Bundles Search" button in "Manage Bundles Page"
    And user "enter text" in "Manage DataSource popup"
      | fieldName           | actionItem |
      | Bundles Search Area | AzBBus     |
    And user "verifies presence" of following "Empty Bundle list" in "Manage Bundles" page
      |  |

  ##6909375##
  @MLP-16754 @webtest @regression @positive
  Scenario:SC#2:MLP-16754: Verification of Sort functionality Bundle, Name, Version and updated
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Bundles" in "Landing page"
    And user "click" on "Filter Icon" button in "Manage Data Sources Page"
    And user "click" on "Bundle Sort Icon" for "Bundle" in "Manage Bundles Page"
    And user "verifies sorting order" of following "Bundle Column is in desending order" in "Manage Bundles" page
      |  |
    And user "click" on "Bundle Sort Icon" for "Bundle" in "Manage Bundles Page"
    And user "verifies sorting order" of following "Bundle Column is in ascending order" in "Item View" page
      |  |
    And user "click" on "Bundle Sort Icon" for "Name" in "Manage Bundles Page"
    And user "verifies sorting order" of following "Name Column is in desending order" in "Manage Bundles" page
      |  |
    And user "click" on "Bundle Sort Icon" for "Name" in "Manage Bundles Page"
    And user "verifies sorting order" of following "Name Column is in ascending order" in "Item View" page
      |  |

  ##6922503##6922504##6922513##6922514##6922515##7248351
  @MLP-16758 @webtest @regression @positive @e2e
  Scenario:SC#3:MLP-16758: Verify that the Mouse hover on bundle displays Delete button.
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data            |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    When user makes a REST Call for DELETE request with url "extensions/bundles/Osgi1-0.0.1-SNAPSHOT.jar"
    And user attaches/upload file "osgibundle/Osgi1-0.0.1-SNAPSHOT.jar" to request
    When user makes a REST Call for POST request with url "extensions/bundles"
    And Status code 200 must be returned
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Bundles" in "Landing page"
    And user "mouse hover" on "Bundles" for "com.asg.idc.Osgi1" in "Manage Bundles Page"
    And user "verify presence" in "Manage Bundles Page"
      | fieldName            | actionItem        |
      | Bundle Delete Button | com.asg.idc.Osgi1 |
    And user "click" in "Manage Bundles Page"
      | fieldName            | actionItem        |
      | Bundle Delete Button | com.asg.idc.Osgi1 |
    And user verifies the "Delete Bundles" pop up is "displayed"
    And user "click" on "Bundles Cancel button" button in "Manage Bundles popup"
    And user "verifies presence" of following "Bundles list" in "Manage Bundles" page
      | com.asg.idc.Osgi1 |
    And user "mouse hover" on "Bundles" for "com.asg.idc.Osgi1" in "Manage Bundles Page"
    And user "click" in "Manage Bundles Page"
      | fieldName            | actionItem        |
      | Bundle Delete Button | com.asg.idc.Osgi1 |
    And user "click" on "PopUp X" button in "Manage Bundles popup"
    And user "verifies presence" of following "Bundles list" in "Manage Bundles" page
      | com.asg.idc.Osgi1 |
    And user "mouse hover" on "Bundles" for "com.asg.idc.Osgi1" in "Manage Bundles Page"
    And user "click" in "Manage Bundles Page"
      | fieldName            | actionItem        |
      | Bundle Delete Button | com.asg.idc.Osgi1 |
    And user "click" on "Bundles DELETE button in Popup" button in "Manage Bundles popup"
    And user "verifies absence" of following "Bundles list" in "Manage Bundles" page
      | com.asg.idc.Osgi1 |


  ##6909767##6909768##6909770##6909772##6909774##
  @MLP-16755 @webtest @regression @positive
  Scenario:SC#1:MLP-16755 : Verify the Upload bundles by clicking ManageBundles
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data            |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And user makes a REST Call for DELETE request with url "extensions/bundles/Analysis/com.asg.dis.analysis.Git"
    And user attaches/upload file "osgibundle/Git-10.3.0-20200101.235332-109-jar-with-dependencies.jar" to request
    When user makes a REST Call for POST request with url "extensions/bundles"
    Then Status code 200 must be returned
    And response returns with the following items
      | description                    | searchItems | expectedResults |
      | ResponseBody_ReturnSingleValue | type        | Analysis        |
    And user makes a REST Call for DELETE request with url "extensions/bundles/Analysis/com.asg.dis.analysis.Git"


#    ##6909775##6909777##6909778###descoped
#  @MLP-16755 @webtest @regression @positive
#  Scenario:SC#2:MLP-16755 : Verify the Discard changes pop up
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the sidebar
#      | actionType  | actionItem        |
#      | click | Settings Icon     |
#      | click       | Manage Bundles    |
#      | click | Data Intelligence |
#    And user "click" on "Add Button in Manage Bundles Page" button in "Manage Bundles page"
#    And user "click" on "BROWSE FILES" button in "Manage Bundles page"
#    And user "click" on "Cancel button" button in "Manage Bundles popup"
#    And user verifies the "Unsaved changes" pop up is "displayed"
#    And user "click" on "No" button in "popup"
#    And user "click" on "Close button" button in "Manage Bundles popup"
#    And user verifies the "Unsaved changes" pop up is "displayed"
#    And user "click" on "Yes" button in "popup"

     ##6916792##6916788##
  @MLP-16755 @webtest @regression @positive
  Scenario:SC#3:MLP-16755 : Verify the contextual message in Manage Bundles
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Bundles" in "Landing page"
    And user "verify displayed" the following "Add and delete bundles." in Manage Bundle Page
    And user "click" on "Add Button in Manage Bundles Page" button in "Manage Bundles page"
    And user "verify displayed" the following "Drag and drop anywhere to upload." in Manage Bundle Page
    And user "verify displayed" the following "Select a bundle to upload." in Manage Bundle Page




