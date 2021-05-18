@MLP-259,@MLP-1467
Feature:MLP-259: As a Data Administrator I want to create and edit a subject area
  Description: This Story covers the implementation of the subject area "Subject area Administration" with
  * create this Access Point in the Quick-Start page of the DIS
  * implement the Service functionality to create, edit the subject area (edit Name, edit description, edit Icon)
  * implement the UI base on the Viusal design and connect the available Services to the functionality. Show a message, if not implemented yet ( the complete set of functionality is defined under https://knowledge-team.asg.com/display/DI/DIS+Prototype+Business+Solutions)

  Goal: The subject area Administration is available to Access. It is possible to create a new subject area. It is possible to add an Icon. It is possible to edit the subject area.

  @MLP-259 @webtest @subjectAreaManagement @sanity @positive
  Scenario:MLP-259: Verify whether the Subject Area Manager link displays on the Dashboard page
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    Then subject area manager link should display on Dashboard page
    And user clicks on logout button

  @MLP-259 @webtest @subjectAreaManagement @sanity @positive @positive
  Scenario:MLP-259: Verify all the fields displayed in the New Subject Area page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    When User click on Subject Area Manager link on the Dashboard page
    And user clicks on Create Button in Subject Area Management page
    Then name,choose icon,quick links,description,users,views,tags field should get displayed in the New Subject Area Page
    And user should be able logoff the IDC

  @MLP-259 @webtest @subjectAreaManagement @sanity @positive
  Scenario:MLP-259: Verify whether the New Subject Area page is getting closed after clicking the close button
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    When User click on Subject Area Manager link on the Dashboard page
    And user clicks on Create Button in Subject Area Management page
    And user clicks on close button in the New Subject Area page
    Then new Subject Area page should be closed
    And user clicks on logout button

  @MLP-259 @webtest @subjectAreaManagement @sanity @positive
  Scenario:MLP-259: Verify whether the Subject Area Icon page is getting closed after clicking the close button
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    When User click on Subject Area Manager link on the Dashboard page
    And user clicks on Create Button in Subject Area Management page
    And user clicks on choose icon button in new Subject Area page
    And user clicks on close button in the Subject Area Icon page
    Then Subject Area Icon page should be closed
    And user should be able logoff the IDC

#  @MLP-259 @webtest @subjectAreaManagement @sanity @positive
#  Scenario:MLP-259: Verify the labels displayed in the Subject Area Icon Page
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    When User click on Subject Area Manager link on the Dashboard page
#    And user clicks on Create Button in Subject Area Management page
#    And user clicks on choose icon button in new Subject Area page
#    Then select an icon from the list below label should get displayed
#    And could not find the icon you are looking for label should get displayed
#    And request an icon with the help icon(?) label should get displayed
#    And user should be able logoff the IDC

  @MLP-259 @webtest @subjectAreaManagement @regression @positive
  Scenario:MLP-259: Verify creation of new Subject Area as a System Administrator
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And User click on Subject Area Manager link on the Dashboard page
    And user clicks on Create Button in Subject Area Management page
    And user enters Name and Description of New Subject Area using json config "Test Data1"
    And user clicks on choose icon button in new Subject Area page
    And user selects any icon for the subject area in Subject Area Icon page
    And user clicks on save button in New Subject Area page
    Then created subject area should get displayed under Subject Areas in the Subject Area Management page
    And user clicks on logout button

  @MLP-259 @webtest @subjectAreaManagement @regression @positive
  Scenario:MLP-259: Verify whether user is able to edit and update the description of any listed Subject Area
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And User click on Subject Area Manager link on the Dashboard page
    And user clicks on mentioned Subject Area in json config file "Test Data1"
    And user updates name and description in Edit Subject Area page from json config file
    And user clicks on save button in New Subject Area page
    And user refreshes the application
    And user clicks on mentioned Subject Area in json config file "Test Data2"
    Then name and description of the Edited Subject Area should get updated
    And user clicks on logout button

  @MLP-259 @webtest @subjectAreaManagement @regression @positive
  Scenario:MLP-259: Verify whether notification is getting displayed after new subject area is created
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    When User click on Subject Area Manager link on the Dashboard page
    And user clicks on Create Button in Subject Area Management page
    And user enters Name and Description of New Subject Area using json config "Test Data3"
    And user clicks on choose icon button in new Subject Area page
    And user selects any icon for the subject area in Subject Area Icon page
    And user clicks on save button in New Subject Area page
    And user clicks on notification icon in the left panel
    Then Subject Area created notification should get displyed in the notifications tab "Test Data3"
    And user clicks on logout button

  @MLP-259 @webtest @subjectAreaManagement @regression @positive
  Scenario Outline:MLP-259: Verify the deletion of Subject Area page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    When User click on Subject Area Manager link on the Dashboard page
    And user clicks on mentioned Subject Area to be deleted "<SubArea>" in json config file
    And user clicks on Delete button in the New Subject Area page
    Then deleted subject area mentioned in json config file should not get listed
    And user clicks on logout button

    Examples:
      | SubArea           |
      | qatestupdated     |
      | qaTestTag         |

#  @MLP-259 @webtest @subjectAreaManagement @regression
#  Scenario:MLP-259: Verify creation of tags New Subject Area page
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When User click on Subject Area Manager link on the Dashboard page
#    And user clicks on Create Button in Subject Area Management page
#    And user enters Name and Description of New Subject Area using json config "Test Data3"
#    And user clicks on Add tag in subject Area
#    And user click on create new tag in edit tags page
#    And user enters tag details and click save
#    And user clicks on mentioned Subject Area in json config file "Test Data3"
#    And user clicks on view tags in edit subject area
#    Then added tag should be displayed