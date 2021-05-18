@MLP-22144
Feature:MLP_22144_To verifyEnable multiple value selection for Business Application - Architecture

  @MLP-22144 @regression @positive
  Scenario Outline:SC#1_Create BusinessApplication
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                       | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | idc/BusinessApplication/BATrustPolicy.json | 200           |                  |          |

  # 7075394 # 7075395# 7075396# 7075397# 707539
  @MLP-22144 @webtest @regression @positive
  Scenario:MLP-22144:SC#2_Verify the user is able to select the view the multi select drop down for Environment,Platforms, Languages, SDLC Environments, Interfaces Protocol EnvironmentType
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "BA_TrustPolicy" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "BA_TrustPolicy" item from search results
    And User performs following actions in the Item view Page
      | Actiontype                                 | ActionItem          | ItemName      |
      | click to Tab                               | Architecture        |               |
      | Edit Icon BusinessTab                      |                     |               |
      | Click Dropdown element                     | Environment         |               |
      | Select Multiple dropdown values of Widgets |                     | Hybrid        |
      | Select Multiple dropdown values of Widgets |                     | Cloud         |
      | Click Dropdown element                     | Environment Type    |               |
      | Select Multiple dropdown values of Widgets |                     | AWS           |
      | Select Multiple dropdown values of Widgets |                     | Google        |
      | Click Dropdown element                     | Platforms           |               |
      | Select Multiple dropdown values of Widgets |                     | Windows       |
      | Select Multiple dropdown values of Widgets |                     | Mac           |
      | Click Dropdown element                     | Languages           |               |
      | Select Multiple dropdown values of Widgets |                     | C             |
      | Select Multiple dropdown values of Widgets |                     | JAVA          |
      | Click Dropdown element                     | Interfaces Protocol |               |
      | Select Multiple dropdown values of Widgets |                     | FTP           |
      | Select Multiple dropdown values of Widgets |                     | SFTP          |
      | Click Dropdown element                     | SDLC Environments   |               |
      | Select Multiple dropdown values of Widgets |                     | Test          |
      | Select Multiple dropdown values of Widgets |                     | DR            |
      | Click                                      | Save                |               |
      | Verify presence of Dropdown Values         | Environment Type    | AWS, Google   |
      | Verify presence of Dropdown Values         | Environment         | Cloud, Hybrid |
      | Verify presence of Dropdown Values         | Platforms           | Mac, Windows  |
      | Verify presence of Dropdown Values         | Languages           | C, JAVA       |
      | Verify presence of Dropdown Values         | SDLC Environments   | Test, DR      |
      | Verify presence of Dropdown Values         | Interfaces Protocol | FTP, SFTP     |


  @MLP-22144@regression @positive
  Scenario:MLP-21085:SC#3 Delete the BA Item
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name           | type                | query | param |
      | SingleItemDelete | Default | BA_TrustPolicy | BusinessApplication |       |       |


  @MLP-22144 @regression @positive
  Scenario Outline:SC#4_Create BusinessApplication
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                       | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | idc/BusinessApplication/BATrustPolicy.json | 200           |                  |          |

  @MLP-22144 @webtest @regression @positive
  Scenario:MLP-22144:SC#6_Verify Architecture tab of BA
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "BA_TrustPolicy" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "BA_TrustPolicy" item from search results
    And User performs following actions in the Item view Page
      | Actiontype                         | ActionItem            | ItemName      |
      | click to Tab                       | Architecture          |               |
      | Click                              | Item view Edit Button |               |
      | Verify presence of Dropdown Values | Environment Type      | AWS, Google   |
      | Verify presence of Dropdown Values | Environment           | Cloud, Hybrid |
      | Verify presence of Dropdown Values | Platforms             | Mac, Windows  |
      | Verify presence of Dropdown Values | Languages             | C, JAVA       |
      | Verify presence of Dropdown Values | SDLC Environments     | Test, DR      |
      | Verify presence of Dropdown Values | Interfaces Protocol   | FTP, SFTP     |

  @MLP-22144@regression @positive
  Scenario:MLP-22144:SC#7Delete the BA Item
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                      | type                | query | param |
      | SingleItemDelete | Default | BA_TrustPolicy            | BusinessApplication |       |       |
      | SingleItemDelete | Default | Land and expand1          | BusinessApplication |       |       |
      | SingleItemDelete | Default | Power to the elbow1       | BusinessApplication |       |       |
      | SingleItemDelete | Default | Pull the plug1            | BusinessApplication |       |       |
      | SingleItemDelete | Default | Relinquish responsibility | BusinessApplication |       |       |
      | SingleItemDelete | Default | TestA                     | Import              |       |       |



