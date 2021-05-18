@MLP-16998
Feature:MLP-16998: This feature is to verify that As a DI user i do not want to see unimplemented icons on left sidebar.

  #Test case is Descoped
# ##6918663##
#  @MLP-16998 @webtest @positive
#  Scenario:SC#1: Verify that the Create icon is removed from the left side bar.
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    Then user verifies "Create" menu is "not displayed" in the left menu.

     ##6918664##6918665##6918666##6918667##6918817##6918818##6918819##
  @MLP-16998 @webtest @positive
  Scenario:SC#2: Verify that the Monitor icon is removed from the left side bar.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    Then user verifies "Monitor" menu is "not displayed" in the left menu.
    Then user verifies "Guide" menu is "not displayed" in the left menu.
    Then user verifies "Define" menu is "not displayed" in the left menu.
    Then user verifies "Explore" menu is "not displayed" in the left menu.
    Then user verifies "Tasks" menu is "not displayed" in the left menu.
    Then user verifies "Recent Activity" menu is "not displayed" in the left menu.
    Then user verifies "Report" menu is "not displayed" in the left menu.





