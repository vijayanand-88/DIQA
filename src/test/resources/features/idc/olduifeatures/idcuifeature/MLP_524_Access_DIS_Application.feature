@MLP-524
Feature:MLP-524: As a user I want to access the DIS application
  Description: This story covers the general access to the Data Intelligence Suite Application. It contains the design and implementation of:
  the login/logout
  if the user is an admin the admin page (any admin capabilities are not a part of this story)
  dashboard (use,)
  user profil (user settings)

  @MLP-524 @webtest @login @sanity @positive
  Scenario:MLP-524: Verify all the login page labels such as Admin Dashboard,ASG logo and name,Welcome content,login title ,username and password labels
    Given User launch browser and traverse to login page
    Then login page should display with all labels

  @MLP-524 @webtest
  @profileSettings @sanity @positive
  Scenario:MLP-524: Verify the details and preferences tabs,profile picture and role in User Profile Settings Page
    Given User launch browser and traverse to login page
    And user enter credentials for "Data Administrator" role
    When user clicks on Profile Settings button
    Then profile settings page should get displayed with details and preferences tabs
    And profile picture name and role of the user "Data Steward" should get displayed in details tab
    And user clicks on logout button

  @MLP-524 @webtest
  @profileSettings @sanity @positive
  Scenario:MLP-524: Verify whether the user is able to close the profile settings page
    Given User launch browser and traverse to login page
    And user enter credentials for "Data Administrator" role
    When user clicks on Profile Settings button
    And user clicks on Profile Settings close button
    Then profile settings page should get closed
    And user clicks on logout button

  @MLP-524 @webtest
  @logout @regression  @positive
  Scenario:MLP-524: To verify the logout functionality of DIS application for Data Administrator.
    Given User launch browser and traverse to login page
    And user enter credentials for "Data Administrator" role
    When user clicks on logout button
    Then logout must be success and display login page






