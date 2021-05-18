@MLP-4329
Feature: MLP-4329 A feature to verify that the Administrators and Information User can access build
  and version via information icon

  @MLP-4329 @webtest @InformationIcon @positive @regression
  Scenario:MLP-4329: Verification of Copyrights in the About Us panel
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And User clicks on the information icon in the header
    And User clicks on "About" submenu
    Then copyrights should be displayed in the popup
      | Year |
      | 2019 |

  @MLP-4329 @webtest @InformationIcon @positive @regression
  Scenario:MLP-4329: Verification of Copyrights in the About Us panel
    Given User launch browser and traverse to login page
    When user enter credentials for "Data Administrator" role
    And User clicks on the information icon in the header
    And User clicks on "About" submenu
    Then copyrights should be displayed in the popup
      | Year |
      | 2019 |

  @MLP-4329 @webtest @InformationIcon @positive @regression
  Scenario:MLP-4329: Verification of Copyrights in the About Us panel
    Given User launch browser and traverse to login page
    When user enter credentials for "Information User" role
    And User clicks on the information icon in the header
    And User clicks on "About" submenu
    Then copyrights should be displayed in the popup
      | Year |
      | 2019 |

  @MLP-4329 @webtest @InformationIcon @positive @sanity
  Scenario:MLP-4329: To verify that the information icon is displayed for Administrator
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then Information icon should be displayed in the header

  @MLP-4329 @webtest @InformationIcon @positive @sanity
  Scenario:MLP-4329: To verify that the information icon is displayed for Data Administrator
    Given User launch browser and traverse to login page
    And user enter credentials for "Data Administrator" role
    Then Information icon should be displayed in the header

  @MLP-4329 @webtest @InformationIcon @positive @sanity
  Scenario:MLP-4329: To verify that the information icon is displayed for Information User
    Given User launch browser and traverse to login page
    And user enter credentials for "Information User" role
    Then Information icon should be displayed in the header


  @MLP-4329 @webtest @InformationIcon @positive @regression
  Scenario:MLP-4329: To verify the submenus in the information icon
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And User clicks on the information icon in the header
    Then list of submenus should match with below values
      | subMenuList   |
      | About         |
      | Documentation |

  @MLP-4329 @webtest @InformationIcon @positive @regression
  Scenario:MLP-4329: To verify the submenus in the information icons
    Given User launch browser and traverse to login page
    And user enter credentials for "Data Administrator" role
    And User clicks on the information icon in the header
    Then list of submenus should match with below values
      | subMenuList   |
      | About         |
      | Documentation |

  @MLP-4329 @webtest @InformationIcon @positive @regression
  Scenario:MLP-4329: To verify the submenus in the information icon
    Given User launch browser and traverse to login page
    And user enter credentials for "Information User" role
    And User clicks on the information icon in the header
    Then list of submenus should match with below values
      | subMenuList   |
      | About         |
      | Documentation |


  @MLP-4329 @webtest @InformationIcon @positive @regression
  Scenario:MLP-4329: To verify Version number and Build information
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And User clicks on the information icon in the header
    And User clicks on "About" submenu
    Then Version number should be displayed in the pop up
#    Then Build information should be displayed in the pop up

  @MLP-4329 @webtest @InformationIcon @positive @regression
  Scenario:MLP-4329: To verify Version number and Build information
    Given User launch browser and traverse to login page
    When user enter credentials for "Data Administrator" role
    And User clicks on the information icon in the header
    And User clicks on "About" submenu
    Then Version number should be displayed in the pop up
#    Then Build information should be displayed in the pop up

  @MLP-4329 @webtest @InformationIcon @positive @regression
  Scenario:MLP-4329: To verify Version number and Build information
    Given User launch browser and traverse to login page
    When user enter credentials for "Information User" role
    And User clicks on the information icon in the header
    And User clicks on "About" submenu
    Then Version number should be displayed in the pop up
#    Then Build information should be displayed in the pop up


  @MLP-4329 @webtest @InformationIcon @positive @regression
  Scenario:MLP-4329: Verification of opening Documentation via information sub menu
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And User clicks on the information icon in the header
    And User clicks on "Documentation" submenu
    Then User should traverse to Documentation page in another window

  @MLP-4329 @webtest @InformationIcon @positive @regression
  Scenario:MLP-4329: Verification of opening Documentation via information sub menu
    Given User launch browser and traverse to login page
    When user enter credentials for "Data Administrator" role
    And User clicks on the information icon in the header
    And User clicks on "Documentation" submenu
    Then User should traverse to Documentation page in another window

  @MLP-4329 @webtest @InformationIcon @positive @regression
  Scenario:MLP-4329: Verification of opening Documentation via information sub menu
    Given User launch browser and traverse to login page
    When user enter credentials for "Information User" role
    And User clicks on the information icon in the header
    And User clicks on "Documentation" submenu
    Then User should traverse to Documentation page in another window

  @MLP-4329 @webtest @InformationIcon @positive @regression
  Scenario:MLP-4329: Verification of Privacy Policy link in the About Us panel
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And User clicks on the information icon in the header
    And User clicks on "About" submenu
    And User clicks on Privacy Policy link
    Then User should traverse to Privacy policy information page in another window

  @MLP-4329 @webtest @InformationIcon @positive @regression
  Scenario:MLP-4329: Verification of Privacy Policy link in the About Us panel
    Given User launch browser and traverse to login page
    When user enter credentials for "Data Administrator" role
    And User clicks on the information icon in the header
    And User clicks on "About" submenu
    And User clicks on Privacy Policy link
    Then User should traverse to Privacy policy information page in another window

  @MLP-4329 @webtest @InformationIcon @positive @regression
  Scenario:MLP-4329: Verification of Privacy Policy link in the About Us panel
    Given User launch browser and traverse to login page
    When user enter credentials for "Information User" role
    And User clicks on the information icon in the header
    And User clicks on "About" submenu
    And User clicks on Privacy Policy link
    Then User should traverse to Privacy policy information page in another window

  @MLP-4329 @webtest @InformationIcon @positive @regression
  Scenario:MLP-4329: Verification of Open Source Documents in the help panel
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And User clicks on the information icon in the header
    And User clicks on "About" submenu
    And User clicks on Open Source Documents link
    Then User should traverse to Open Source Documents page in another window

  @MLP-4329 @webtest @InformationIcon @positive @regression
  Scenario:MLP-4329: Verification of Open Source Documents in the help panel
    Given User launch browser and traverse to login page
    When user enter credentials for "Data Administrator" role
    And User clicks on the information icon in the header
    And User clicks on "About" submenu
    And User clicks on Open Source Documents link
    Then User should traverse to Open Source Documents page in another window

  @MLP-4329 @webtest @InformationIcon @positive @regression
  Scenario:MLP-4329: Verification of Open Source Documents in the help panel
    Given User launch browser and traverse to login page
    When user enter credentials for "Information User" role
    And User clicks on the information icon in the header
    And User clicks on "About" submenu
    And User clicks on Open Source Documents link
    Then User should traverse to Open Source Documents page in another window

  @MLP-4329 @webtest @InformationIcon @positive @regression
  Scenario:MLP-4329: Verification of Open Source Documents in the help panel
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And User clicks on the information icon in the header
    And User clicks on "About" submenu
    Then User clicks on the Close button and pop up should be closed

  @MLP-4329 @webtest @InformationIcon @positive @regression
  Scenario:MLP-4329: Verification of Open Source Documents in the help panel
    Given User launch browser and traverse to login page
    When user enter credentials for "Data Administrator" role
    And User clicks on the information icon in the header
    And User clicks on "About" submenu
    Then User clicks on the Close button and pop up should be closed

  @MLP-4329 @webtest @InformationIcon @positive @regression
  Scenario:MLP-4329: Verification of Open Source Documents in the help panel
    Given User launch browser and traverse to login page
    When user enter credentials for "Information User" role
    And User clicks on the information icon in the header
    And User clicks on "About" submenu
    Then User clicks on the Close button and pop up should be closed


