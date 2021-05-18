@MLP-1495,@MLP-1496
Feature:MLP-1496_1495: Enable breadcrumb navigation by hyperlinks Cut the breadcrumb on the start and show ellipsis
  Description: Actually the current breadcrumb doesn't support hyerlinks on each entry.
  emphasized text_The breadcrumb can be very long. If the breadcrumb is longer as 4 (including the actual item) the breadcrumb should be cut by an ellipsis on the start:
  ... / item1 / item2 / item3 / current item

  @MLP-1495 @MLP-1496 @webtest @breadcrumb @sanity @positive
  Scenario:MLP-1496: Verfication of that the breadcrumb shows maximum entries
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user selects the BigData catalog from catalog list
    And user clicks on first item name link on the item list page
    Then breadcrumb items ahould get displayed

  @MLP-1495 @MLP-1496 @webtest @breadcrumb @sanity @positive
  Scenario:MLP-1496: Verfication of the breadcrumb for full view and preview page
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And  user clicks on first item on the item list page
    And user clicks on minimize icon in the item full view
    Then three dots and maximum entries are displayed
    When user clicks on enlarge button in the preview page
    Then breadcrumb items ahould get displayed

  @MLP-1495 @MLP-1496 @webtest @breadcrumb @sanity @positive
  Scenario:MLP-1496: Verfication of the breadcrumb opening for the hidden items
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user selects the BigData catalog from catalog list
    And  user clicks on first item on the item list page
    When user clicks on any item in the breadcrumb hidden items
    Then corresponding item should open in a preview page

  @MLP-1495 @MLP-1496 @webtest @breadcrumb @sanity @negative
  Scenario:MLP-1496: Verfication of the breadcrumb opening for tha already selected item
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user clicks on first item name link on the item list page
    When user clicks on any item in the breadcrumb items
    Then corresponding item should open in a preview page
    And user verifies "4" pane is disaplayed
    And user clicks on "HIVE" item in the breadcrumb items
    And user verifies "4" pane is disaplayed