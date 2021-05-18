@MLP-18050
Feature: MLP_18050_To Verify Tag widget for an itemView [ Business Application ]

  @MLP-18050 @webtest @regression @positive
  Scenario:MLP-18050:Create an Item
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "Create Item" in Create new item page
      | fieldName           | attribute   | option |
      | BusinessApplication | Test_BA_Tag | Save   |

  ##6952532##6952533##6952574##6952577##6952578##6952584##6952586##6952593##6952594##6952595##6952596##6952597##6952598##
  @MLP-18050 @webtest @regression @positive
  Scenario:MLP-18050:SC#1_Verify that tag widget is displayed on the left hand side of the itemview for the Business Application item types.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And User performs following actions in the Item view Page
      | Actiontype                        | ActionItem          | ItemName |
      | Verifies Widget for Metadata type | BusinessApplication | Tags     |
      | Verifies Widget for Metadata type | Table               | Tags     |
      | Verifies Widget for Metadata type | Column              | Tags     |
      | Verifies Widget for Metadata type | Cluster             | Tags     |
      | Verifies Widget for Metadata type | Database            | Tags     |
      | Verifies Widget for Metadata type | Service             | Tags     |
      | Verifies Widget for Metadata type | Directory           | Tags     |
      | Verifies Widget for Metadata type | File                | Tags     |
      | Verifies Widget for Metadata type | Analysis            | Tags     |
      | Verifies Widget for Metadata type | Field               | Tags     |
      | Verifies Widget for Metadata type | Function            | Tags     |
      | Verifies Widget for Metadata type | Execution           | Tags     |
      | Verifies Widget for Metadata type | Host                | Tags     |

  # 6952584
  @MLP-18050 @webtest @regression @positive
  Scenario:MLP-18050:SC#6_Verify that tag widget is displayed on the left hand side of the itemview for the Field item types.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype             | ActionItem |
      | Verify Widget Presence | Tags       |

    # 6955194
  @MLP-18050 @webtest @regression @positive
  Scenario:MLP-18050:SC#15_Verify that the tag widget displays an information message if there is no tag is assigned to the item.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Test_BA_Tag" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype                   | ActionItem                                                                                  | Section |
      | Verifies Information Message | Looks like there are no tags associated with this item. To add your own tag, click + above. | Tags    |

#    # 6955203
#  @MLP-18050 @webtest @regression @positive
#  Scenario:MLP-18050:SC#16_Verify that tag widget is displayed on the left hand side of the itemview for the PII Property item types.
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user "enter text" in "Item Search in Home Page"
#      | fieldName   | actionItem |
#      | Search Area |            |
#    And user performs following actions in the header
#      | actionType | actionItem    |
#      | click      | Search Button |
#    And user performs "facet selection" in "PIIProperty" attribute under "Metadata Type" facets in Item Search results page
#    And user clicks on first item on the item list page
#     And User performs following actions in the Item view Page
#      | Actiontype             | ActionItem |
#      | Verify Widget Presence | Tags       |

    # 6955209
#  @MLP-18050 @webtest @regression @positive
#  Scenario:MLP-18050:SC#17_Verify that tag widget is displayed on the left hand side of the itemview for the PII Category item types.
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem    |
#      | click      | Search Button |
#    And user performs "facet selection" in "PIICategory" attribute under "Metadata Type" facets in Item Search results page
#    And user clicks on first item on the item list page
#     And User performs following actions in the Item view Page
#      | Actiontype             | ActionItem |
#      | Verify Widget Presence | Tags       |

#    # 6955210
#  @MLP-18050 @webtest @regression @positive
#  Scenario:MLP-18050:SC#18_Verify that tag widget is displayed on the left hand side of the itemview for the PII Entity item types.
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem    |
#      | click      | Search Button |
#    And user performs "facet selection" in "PIIEntity" attribute under "Metadata Type" facets in Item Search results page
#    And user clicks on first item on the item list page
#     And User performs following actions in the Item view Page
#      | Actiontype             | ActionItem |
#      | Verify Widget Presence | Tags       |

#    # 6955211
#  @MLP-18050 @webtest @regression @positive
#  Scenario:MLP-18050:SC#19_Verify that tag widget is displayed on the left hand side of the itemview for the PII Attribute item types.
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem    |
#      | click      | Search Button |
#    And user performs "facet selection" in "PIIAttribute" attribute under "Metadata Type" facets in Item Search results page
#    And user clicks on first item on the item list page
#     And User performs following actions in the Item view Page
#      | Actiontype             | ActionItem |
#      | Verify Widget Presence | Tags       |

#    # 6955212
#  @MLP-18050 @webtest @regression @positive
#  Scenario:MLP-18050:SC#20_Verify that tag widget is displayed on the left hand side of the itemview for Data Sets.
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem    |
#      | click      | Search Button |
#    And user performs "facet selection" in "DataSet" attribute under "Metadata Type" facets in Item Search results page
#    And user clicks on first item on the item list page
#     And User performs following actions in the Item view Page
#      | Actiontype             | ActionItem |
#      | Verify Widget Presence | Tags       |

    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name        | type                | query | param |
      | SingleItemDelete | Default | Test_BA_Tag | BusinessApplication |       |       |
