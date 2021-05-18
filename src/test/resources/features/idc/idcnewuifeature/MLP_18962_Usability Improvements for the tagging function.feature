Feature:MLP_18962_To Verify Usability Improvements for the tagging function

  # 6972330
  @MLP-18962 @webtest @regression @positive
  Scenario:MLP-18962:SC#1_Verify if Tag Selection and Assigned Tags frame are displayed horizontal
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype            | ActionItem     |
      | Click                 | Add Tag Button |
      | Verify Frame Presence | Available      |
      | Verify Frame Presence | Assigned       |

  # 6972336
  @MLP-18962 @webtest @regression @positive
  Scenario:MLP-18962:SC#2_Verify if newly added tag has the label 'added'
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype    | ActionItem     | Section   |
      | Click         | Add Tag Button |           |
      | Click         | Search         |           |
      | Enter Text    | Tag Text box   | Gender    |
      | Tag Selection | Gender         | Available |
      | Click         | Search Close   |           |
      | Click         | Search         |           |
      | Enter Text    | Tag Text box   | Full Name |
      | Tag Selection | Full Name      | Available |
      | Click         | Search Close   |           |
    And User performs following actions in the Item view Page
      | Actiontype            | ActionItem | Section  | ItemName |
      | Verify Label Presence | Gender     | Assigned | "added"  |
    And user "click" on "Assign" button in "Create Item Page"
    And User performs following actions in the Item view Page
      | Actiontype          | ActionItem |
      | Verify Tag Presence | Gender     |
      | Verify Tag Presence | Full Name  |

   # 6972353
  @MLP-18962 @webtest @regression @positive
  Scenario:MLP-18962:SC#3_Verify if vertical scroll bar is displayed if the Tags list is huge in both Tag Selection and Tags Added frame
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     |
      | Click      | Add Tag Button |
    And User performs following actions in the Item view Page
      | Actiontype    | ActionItem     | Section       |
      | Click         | Add Tag Button |               |
      | Click         | Search         |               |
      | Enter Text    | Tag Text box   | Gender        |
      | Tag Selection | Gender         | Available     |
      | Click         | Search Close   |               |
      | Click         | Search         |               |
      | Enter Text    | Tag Text box   | Full Name     |
      | Tag Selection | Full Name      | Available     |
      | Click         | Search Close   |               |
      | Click         | Search         |               |
      | Enter Text    | Tag Text box   | State         |
      | Tag Selection | State          | Available     |
      | Click         | Search Close   |               |
      | Click         | Search         |               |
      | Enter Text    | Tag Text box   | Email Address |
      | Tag Selection | Email Address  | Available     |
      | Click         | Search Close   |               |
      | Click         | Search         |               |
      | Enter Text    | Tag Text box   | Phone Number  |
      | Tag Selection | Phone Number   | Available     |
      | Click         | Search Close   |               |
    And User performs following actions in the Item view Page
      | Actiontype            | ActionItem    | Section  | ItemName |
      | Verify Label Presence | Gender        | Assigned | "added"  |
      | Verify Label Presence | Full Name     | Assigned | "added"  |
      | Verify Label Presence | State         | Assigned | "added"  |
      | Verify Label Presence | Email Address | Assigned | "added"  |
      | Verify Label Presence | Phone Number  | Assigned | "added"  |
    And User performs following actions in the Item view Page
      | Actiontype        | ActionItem    | Section  |
      | Verify Scroll Bar | Gender        | Assigned |
      | Verify Scroll Bar | Full Name     | Assigned |
      | Verify Scroll Bar | State         | Assigned |
      | Verify Scroll Bar | Email Address | Assigned |
      | Verify Scroll Bar | Phone Number  | Assigned |
    And user "click" on "Assign" button in "Create Item Page"
    And User performs following actions in the Item view Page
      | Actiontype          | ActionItem   |
      | Verify Tag Presence | Gender       |
      | Verify Tag Presence | Full Name    |
      | Verify Tag Presence | State        |
      | Verify Tag Presence | State        |
      | Verify Tag Presence | Phone Number |

  # 6953080
  @MLP-18236 @webtest @regression @positive
  Scenario:MLP-18236:SC#4_Verify that the current year is displayed for the copyrights in the the login page footer.
    Given User launch browser and traverse to login page
    And user verifies the coyprights as "Copyright © 2020 ASG Technologies. All rights reserved." on login page