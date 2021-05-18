#@MLP-617
#Feature:MLP-617: As a Data Administrator I want to create and manage a tagging structure for a selected subject area
#  Description: The Administrator can easily setup a tagging structure by tags manually within the subject area Administration.
#  The Integration of the Adding Tag Feature within the subject area Administration is defined by the visual design screens (07...). For the prototype we skip the Option to work with a tagging template.
#  The Management of the tagging structure within the subject area is demonstrated in the Screens (08..). Actually These Screens were shared for the tag template Management area so we skip all tag template related items here but integrate the idea to manage a tag structure by the Administrator.
#  There is an issue with subject  area tags field
#
#  @MLP-617 @webtest @subjectAreaManagement @regression
#  Scenario:MLP-617: Verify creation of new Subject Area as a Data Administrator
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator" role
#    And User click on Subject Area Manager link on the Dashboard page
#    And user clicks on Create Button in Subject Area Management page
#    And user enters Name and Description of New Subject Area using json config "Test Data1"
#    And user clicks on choose icon button in new Subject Area page
#    And user selects any icon for the subject area in Subject Area Icon page
#    And user clicks on save button in New Subject Area page
#    Then created subject area should get displayed under Subject Areas in the Subject Area Management page
#    And user should be able logoff the IDC
#
#  @MLP-617 @webtest @subjectAreaTags @regression
#  Scenario Outline:MLP-617: As a Data Administrator, user must create new tag under Subject Area
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    When User click on Subject Area Manager link on the Dashboard page
#    And user clicks on mentioned Subject Area in json config file "Test Data1"
#    And user click on tags on Edit Subject Area
#    And user click on create new tag in edit tags page
#    And user enter new tag details "<tagName>" "<tagDescription>" "<tagForType>"
#    And user clicks on save button in the edit properties page
#    Then created tag "<tagName>" must be displayed under tag structure in edit tags page
#    And user should be able logoff the IDC
#    Examples:
#      | tagName   | tagDescription | tagForType |
#      | qaTagTest | qaTagTestDes1  | qaTagType1 |

