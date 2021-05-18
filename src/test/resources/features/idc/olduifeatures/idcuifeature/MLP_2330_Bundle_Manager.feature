@MLP-2330
Feature:MLP-2330_Verification of versions and Name for the existing bundles in the bundle management

  @MLP-2330 @webtest @positive
  Scenario:MLP-2330_Verification of versions and Name for the existing bundles in the bundle management
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Bundle Manager link in administration tab
    And user clicks on bundle name "Analysis"
    And List of bundles with version should be displayed
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | public     | V_Bundle  | name       | path         |
    And user click on each bundle and validate the bundle size with below db values
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | public     | V_Bundle  | version    | name         |


  @MLP-2330 @webtest @positive
  Scenario Outline: MLP-2330_Verification of Default bundle types
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Bundle Manager link in administration tab
    Then user validates following "<BundleTypes>" are displayed by default
    Examples:
      | BundleTypes |
      | Analysis    |
      | BackOffice  |
      | WebService  |

  @MLP-2330 @webtest @positive
  Scenario Outline: MLP-2331_Verification of Uploading a Bundle other than the default type bundle
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Bundle Manager link in administration tab
    And user clicks on bundle upload button and click browse button
    #And user upload "Osgi1-0.0.1-SNAPSHOT.jar" bundle and click Submit
    And user upload file
      | Method         | Action                   |
      | setAutoDelay   | 1000                     |
      | selectOSGIFile | Osgi1-0.0.1-SNAPSHOT.jar |
      | setAutoDelay   | 1000                     |
      | keyPress       | CONTROL                  |
      | keyPress       | V                        |
      | keyRelease     | CONTROL                  |
      | keyRelease     | V                        |
      | setAutoDelay   | 1000                     |
      | keyPress       | ENTER                    |
      | keyRelease     | ENTER                    |
    And user clicks on submit button in the upload bundle page
    And user click on close button in bundle details page
    Then user validates following "<BundleTypes>" are displayed by default
    And user clicks on bundle name "TestPlugin"
    And user delete all the plugin inside bundle
    Examples:
      | BundleTypes |
      | TestPlugin  |

  @MLP-2330 @webtest @positive
  Scenario Outline:MLP-2332_Verification of deleting a non default type bundle
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When user makes a REST Call for DELETE request with url "extensions/bundles/Osgi1-0.0.1-SNAPSHOT.jar"
    And user attaches/upload file "osgibundle/Osgi1-0.0.1-SNAPSHOT.jar" to request
    When user makes a REST Call for POST request with url "extensions/bundles"
    And Status code 200 must be returned
    Then "com.asg.idc.Osgi1-0.0.1.SNAPSHOT" osgi bundle should be uploaded to bundle table
      | description | schemaName | tableName | columnName | criteriaName | firstColName | secColName |
      | SELECT      | public     | V_Bundle  | *          | name,version | version      | plugins    |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Bundle Manager link in administration tab
    Then user validates following "<BundleTypes>" are displayed by default
    And user clicks on bundle name "TestPlugin"
    And user delete all the plugins in "TestPlugin" bundle type
    Then deleted bundle type "TestPlugin" should not be displayed
    And user refreshes the application
    Then deleted bundle type "TestPlugin" should not be displayed

    Examples:
      | BundleTypes |
      | TestPlugin  |


  @MLP-2330 @webtest @positive
  Scenario: MLP-2331_Verification of Uploading Analysis Type bundle
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When user makes a REST Call for DELETE request with url "extensions/bundles/Git-9.5.0-20171023.122812-15.jar"
    And user attaches/upload file "osgibundle/Git-9.5.0-20171023.122812-15.jar" to request
    When user makes a REST Call for POST request with url "extensions/bundles"
    And Status code 200 must be returned
    Then "com.asg.idc.analysis.Git" osgi bundle should be uploaded to bundle table
      | description | schemaName | tableName | columnName | criteriaName | firstColName | secColName |
      | SELECT      | public     | V_Bundle  | *          | bundle       | version      | plugins    |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Bundle Manager link in administration tab
    And user clicks on bundle name "Analysis"
    Then upload plugin "com.asg.idc.analysis.Git" should be displayed in "Analysis" bundle
    And List of bundles with version should be displayed
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | public     | V_Bundle  | name       | path         |
    And user click on each bundle and validate the bundle size with below db values
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | public     | V_Bundle  | version    | name         |
    And user clicks on bundle name "Analysis"
    And user delete the plugin "com.asg.idc.analysis.Git" in "Analysis" bundle
    And user clicks on Yes button in alert message

  @MLP-2330 @webtest @positive
  Scenario: MLP-2331_Verification of Uploading BackOffice Type bundle
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When user makes a REST Call for DELETE request with url "extensions/bundles/Osgi1-0.0.1_BackOffice.jar"
    And user attaches/upload file "osgibundle/Osgi1-0.0.1_BackOffice.jar" to request
    When user makes a REST Call for POST request with url "extensions/bundles"
    And Status code 200 must be returned
    Then "com.asg.idc.Osgi1" osgi bundle should be uploaded to bundle table
      | description | schemaName | tableName | columnName | criteriaName | firstColName | secColName |
      | SELECT      | public     | V_Bundle  | *          | bundle       | version      | plugins    |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Bundle Manager link in administration tab
    And user clicks on bundle name "BackOffice"
    Then upload plugin "com.asg.idc.Osgi1" should be displayed in "BackOffice" bundle
    And List of bundles with version should be displayed
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | public     | V_Bundle  | name       | path         |
    And user click on each bundle and validate the bundle size with below db values
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | public     | V_Bundle  | version    | name         |
    And user delete all the plugins in "BackOffice" bundle type

  @MLP-2331 @webtest @positive
  Scenario: MLP-2331_Verification of Uploading WebService Type bundle
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When user makes a REST Call for DELETE request with url "extensions/bundles/OSGIWebServiceTest-9.2.0-SNAPSHOT.jar"
    And user attaches/upload file "osgibundle/OSGIWebServiceTest-9.2.0-SNAPSHOT.jar" to request
    When user makes a REST Call for POST request with url "extensions/bundles"
    And Status code 200 must be returned
    Then "com.asg.dis.platform.OSGIWebServiceTest" osgi bundle should be uploaded to bundle table
      | description | schemaName | tableName | columnName | criteriaName | firstColName | secColName |
      | SELECT      | public     | V_Bundle  | *          | bundle       | version      | plugins    |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Bundle Manager link in administration tab
    Then upload plugin "com.asg.dis.platform.OSGIWebServiceTest" should be displayed in "WebService" bundle
    And List of bundles with version should be displayed
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | public     | V_Bundle  | name       | path         |
    And user click on each bundle and validate the bundle size with below db values
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | public     | V_Bundle  | version    | name         |
    And user delete all the plugins in "WebService" bundle type

  @MLP-2330 @webtest @positive
  Scenario: MLP-2332_Verification of deleting the last bundle from a default bundle type
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When user makes a REST Call for DELETE request with url "extensions/bundles/OSGIWebServiceTest-9.2.0-SNAPSHOT.jar"
    And user attaches/upload file "osgibundle/OSGIWebServiceTest-9.2.0-SNAPSHOT.jar" to request
    When user makes a REST Call for POST request with url "extensions/bundles"
    And Status code 200 must be returned
    Then "com.asg.dis.platform.OSGIWebServiceTest" osgi bundle should be uploaded to bundle table
      | description | schemaName | tableName | columnName | criteriaName | firstColName | secColName |
      | SELECT      | public     | V_Bundle  | *          | bundle       | version      | plugins    |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Bundle Manager link in administration tab
    And user clicks on bundle name "WebService"
    And user delete all the plugin inside bundle
    And user clicks Yes on the alert window
    And user refreshes the application
    Then user validates following "WebService" are displayed by default

  @MLP-2330 @webtest @positive
  Scenario: MLP-2511 Verification of file size of bundle while uploading the jar
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Bundle Manager link in administration tab
    And user clicks on bundle upload button and click browse button
    #And user upload "OSGIWebServiceTest-9.2.0-SNAPSHOT.jar" bundle
    And user upload file
      | Method         | Action                                |
      | setAutoDelay   | 1000                                  |
      | selectOSGIFile | OSGIWebServiceTest-9.2.0-SNAPSHOT.jar |
      | setAutoDelay   | 1000                                  |
      | keyPress       | CONTROL                               |
      | keyPress       | V                                     |
      | keyRelease     | CONTROL                               |
      | keyRelease     | V                                     |
      | setAutoDelay   | 1000                                  |
      | keyPress       | ENTER                                 |
      | keyRelease     | ENTER                                 |
    And user clicks on submit button in the upload bundle page
    Then uploaded file size should get displayed in bundle upload page

  @MLP-2329 @webtest @regression @positive
  Scenario: Verification of assigning Text AttributeWidget with type as date
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user clicks on Administration widget
    Then widget for Bundle Manager should be displayed on the Dashboard
    And definition for Bundle Manager should be displayed on the Dashboard
    And description for Bundle Manager should be displayed on the Dashboard
    And recent label for Bundle Manager should be displayed on the Dashboard
    And quicklink label for Bundle Manager should be displayed on Dashboard
    And user clicks on upload new bundle link in Bundle Manager widget
    And user verifies Upload Bundle panel is displayed
    And user clicks on home button
    And user clicks on recent bundle first link
    And user verifies Bundle Details panel is displayed

  @MLP-2329 @webtest @regression @positive
  Scenario: Verification of Upload button in the Bundle Management panel
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    When user clicks on Bundle Manager link in administration tab
    Then user verifies Upload button is displayed in Bundle management

  @MLP-2329 @webtest @regression @positive
  Scenario: Verification of Bundle version details panel values
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    When user clicks on Bundle Manager link in administration tab
    Then user clicks on bundle name "Analysis"
    And user clicks on first bundle under Analysis
    And user verifies Bundle Details panel is displayed
    And user clicks on first bundle version
    And user verifies Name Type Version and Plugins label in bundle version page
    And user verifies plugin names are displayed

  @MLP-2331 @webtest @negative
  Scenario: MLP-2331_Verification of error message for uploading file which is not a bundle type
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Bundle Manager link in administration tab
    And user clicks on bundle upload button and click browse button
    #And user upload "Osgi1-0.0.1_Error.jar" bundle and click Submit
    And user upload file
      | Method         | Action                |
      | setAutoDelay   | 1000                  |
      | selectOSGIFile | Osgi1-0.0.1_Error.jar |
      | setAutoDelay   | 1000                  |
      | keyPress       | CONTROL               |
      | keyPress       | V                     |
      | keyRelease     | CONTROL               |
      | keyRelease     | V                     |
      | setAutoDelay   | 1000                  |
      | keyPress       | ENTER                 |
      | keyRelease     | ENTER                 |
    And user clicks on submit button in the upload bundle page
    Then Error message "Cannot detect bundle type in Bundle" should be displayed
    And user should be able logoff the IDC

  @MLP-2333 @webtest @positive
  Scenario: MLP-2333_Verification of number of plugins in the Bundle Details panel
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Bundle Manager link in administration tab
    And user clicks on bundle name "Analysis"
    And user compare the plugin count in bundle management and bundle version panel

  @MLP-2332 @webtest @positive
  Scenario: MLP-2332_Verification of delete button is enabled only when one bundle is selected
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Bundle Manager link in administration tab
    And user clicks on bundle name "Analysis"
    And Delete button should not be displayed
    And user clicks on first bundle under Analysis
    Then Delete button should be displayed

#  @MLP-2334 @webtest @positive
#  Scenario: MLP-2334 Verification of file size of bundle while uploading the jar
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Content-Type  | multipart/form-data                |
#      | Accept        | application/json                   |
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#    And user makes a REST Call for DELETE request with url "extensions/bundles/TestPlugin/com.asg.idc.Osgi1"
#    And user attaches/upload file "osgibundle/Osgi1-0.0.1-SNAPSHOT.jar" to request
#    When user makes a REST Call for POST request with url "extensions/bundles"
#    Then Status code 200 must be returned
#    And configure a new REST API for the service "IDC"
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
#      | Content-Type  | application/octet-stream           |
#      | Accept        | application/octet-stream           |
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#    And user makes a REST Call for Get request with url "extensions/bundles/TestPlugin/com.asg.idc.Osgi1/0.0.1.SNAPSHOT/content"
#    And Status code 200 must be returned
#    And Verify response header contains value
#      | HeaderField | HeaderValue                          |
#      | filename    | com.asg.idc.Osgi1-0.0.1.SNAPSHOT.jar |
#
